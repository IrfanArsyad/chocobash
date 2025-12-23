#!/bin/bash
# Nginx Virtual Host Configuration with PHP-FPM
# ChocoBash - https://github.com/IrfanArsyad/chocobash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Load language
BASE_URL="https://raw.githubusercontent.com/IrfanArsyad/chocobash/main"
CHOCO_LANG="${CHOCO_LANG:-id}"
eval "$(wget -qLO - ${BASE_URL}/lang/${CHOCO_LANG}.sh)" 2>/dev/null || true

# Nginx paths
NGINX_AVAILABLE="/etc/nginx/sites-available"
NGINX_ENABLED="/etc/nginx/sites-enabled"

# Function: separator
separator() {
    echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}"
}

# Function: Check nginx installed
check_nginx() {
    if ! command -v nginx &> /dev/null; then
        echo -e "${RED}[!] Nginx ${MSG_NOT_INSTALLED:-tidak terinstall}!${NC}"
        echo -e "${YELLOW}${MSG_INSTALL_FIRST:-Install nginx terlebih dahulu}${NC}"
        exit 1
    fi
}

# Function: Detect installed PHP versions
detect_php_versions() {
    PHP_VERSIONS=()
    for version in 7.4 8.0 8.1 8.2 8.3 8.4; do
        if [ -S "/var/run/php/php${version}-fpm.sock" ] || systemctl is-active --quiet "php${version}-fpm" 2>/dev/null; then
            PHP_VERSIONS+=("$version")
        fi
    done
}

# Function: Show PHP version menu
show_php_menu() {
    echo ""
    echo -e "${CYAN}${MSG_SELECT_PHP_VERSION:-Pilih versi PHP:}${NC}"
    separator

    local i=1
    for version in "${PHP_VERSIONS[@]}"; do
        local status=""
        case $version in
            "7.4") status="${YELLOW}(${LBL_LEGACY:-Legacy})${NC}" ;;
            "8.0") status="${RED}(${LBL_EOL:-EOL})${NC}" ;;
            "8.1") status="${YELLOW}(${LBL_SECURITY:-Security})${NC}" ;;
            "8.2") status="${GREEN}(${LBL_STABLE:-Stable})${NC}" ;;
            "8.3") status="${GREEN}(${LBL_RECOMMENDED:-Recommended})${NC}" ;;
            "8.4") status="${CYAN}(${LBL_LATEST:-Latest})${NC}" ;;
        esac
        echo -e "  ${GREEN}$i)${NC} PHP $version $status"
        ((i++))
    done
    separator
}

# Function: Generate nginx config
generate_nginx_config() {
    local domain=$1
    local php_version=$2
    local web_root=$3

    cat << EOF
server {
    listen 80;
    listen [::]:80;

    server_name ${domain} www.${domain};
    root ${web_root};

    index index.php index.html index.htm;

    # Logging
    access_log /var/log/nginx/${domain}.access.log;
    error_log /var/log/nginx/${domain}.error.log;

    # Security headers
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header X-XSS-Protection "1; mode=block" always;

    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    # PHP-FPM Configuration
    location ~ \.php\$ {
        fastcgi_split_path_info ^(.+\.php)(/.+)\$;
        fastcgi_pass unix:/var/run/php/php${php_version}-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        include fastcgi_params;

        # PHP Timeouts
        fastcgi_connect_timeout 60;
        fastcgi_send_timeout 180;
        fastcgi_read_timeout 180;
        fastcgi_buffer_size 128k;
        fastcgi_buffers 4 256k;
        fastcgi_busy_buffers_size 256k;
    }

    # Deny access to hidden files
    location ~ /\. {
        deny all;
    }

    # Deny access to sensitive files
    location ~* (?:\.(?:bak|conf|dist|fla|in[ci]|log|psd|sh|sql|sw[op])|~)\$ {
        deny all;
    }

    # Static file caching
    location ~* \.(jpg|jpeg|gif|png|css|js|ico|xml|webp|svg|woff|woff2|ttf|eot)\$ {
        expires 30d;
        add_header Cache-Control "public, immutable";
    }

    # Gzip compression
    gzip on;
    gzip_vary on;
    gzip_min_length 1024;
    gzip_types text/plain text/css text/xml text/javascript application/javascript application/x-javascript application/xml application/json;
}
EOF
}

# Function: Create virtual host
create_vhost() {
    local domain=$1
    local php_version=$2
    local web_root=$3
    local config_file="${NGINX_AVAILABLE}/${domain}"

    echo ""
    echo -e "${CYAN}[*] ${MSG_CREATING:-Membuat} nginx config...${NC}"

    # Generate and save config
    generate_nginx_config "$domain" "$php_version" "$web_root" | sudo tee "$config_file" > /dev/null

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}[✓] Config ${MSG_CREATED:-dibuat}: ${config_file}${NC}"
    else
        echo -e "${RED}[!] ${MSG_FAILED:-Gagal} membuat config${NC}"
        return 1
    fi

    # Create symlink
    echo -e "${CYAN}[*] ${MSG_CREATING_SYMLINK:-Membuat symlink}...${NC}"
    if [ -L "${NGINX_ENABLED}/${domain}" ]; then
        sudo rm "${NGINX_ENABLED}/${domain}"
    fi

    sudo ln -s "$config_file" "${NGINX_ENABLED}/${domain}"

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}[✓] Symlink ${MSG_CREATED:-dibuat}: ${NGINX_ENABLED}/${domain}${NC}"
    else
        echo -e "${RED}[!] ${MSG_FAILED:-Gagal} membuat symlink${NC}"
        return 1
    fi

    # Create web root directory
    echo -e "${CYAN}[*] ${MSG_CREATING:-Membuat} web directory...${NC}"
    sudo mkdir -p "$web_root"
    sudo chown -R www-data:www-data "$web_root"
    sudo chmod -R 755 "$web_root"
    echo -e "${GREEN}[✓] Web directory: ${web_root}${NC}"

    # Create test PHP file
    echo -e "${CYAN}[*] ${MSG_CREATING:-Membuat} test file...${NC}"
    echo "<?php phpinfo(); ?>" | sudo tee "${web_root}/info.php" > /dev/null
    sudo chown www-data:www-data "${web_root}/info.php"
    echo -e "${GREEN}[✓] Test file: ${web_root}/info.php${NC}"

    return 0
}

# Function: Test and reload nginx
test_and_reload() {
    echo ""
    echo -e "${CYAN}[*] ${MSG_TESTING:-Testing} nginx config...${NC}"

    if sudo nginx -t 2>&1; then
        echo ""
        echo -e "${CYAN}[*] ${MSG_RELOADING:-Reloading} nginx...${NC}"
        sudo systemctl reload nginx

        if [ $? -eq 0 ]; then
            echo -e "${GREEN}[✓] Nginx ${MSG_RELOADED:-berhasil direload}${NC}"
            return 0
        else
            echo -e "${RED}[!] ${MSG_FAILED:-Gagal} reload nginx${NC}"
            return 1
        fi
    else
        echo -e "${RED}[!] Nginx config ${MSG_INVALID:-tidak valid}!${NC}"
        echo -e "${YELLOW}${MSG_CHECK_CONFIG:-Periksa konfigurasi}${NC}"
        return 1
    fi
}

# Function: Show summary
show_summary() {
    local domain=$1
    local php_version=$2
    local web_root=$3

    echo ""
    separator
    echo -e "${GREEN}[✓] ${MSG_SETUP_COMPLETE:-Setup selesai}!${NC}"
    separator
    echo ""
    echo -e "${CYAN}${MSG_SUMMARY:-Ringkasan}:${NC}"
    echo -e "  Domain      : ${GREEN}${domain}${NC}"
    echo -e "  PHP Version : ${GREEN}${php_version}${NC}"
    echo -e "  Web Root    : ${GREEN}${web_root}${NC}"
    echo -e "  Config      : ${GREEN}${NGINX_AVAILABLE}/${domain}${NC}"
    echo -e "  Symlink     : ${GREEN}${NGINX_ENABLED}/${domain}${NC}"
    echo ""
    echo -e "${YELLOW}${MSG_NEXT_STEPS:-Langkah selanjutnya}:${NC}"
    echo -e "  1. ${MSG_ADD_HOSTS:-Tambahkan ke /etc/hosts jika testing lokal}:"
    echo -e "     ${CYAN}echo '127.0.0.1 ${domain}' | sudo tee -a /etc/hosts${NC}"
    echo ""
    echo -e "  2. ${MSG_TEST_PHP:-Test PHP}:"
    echo -e "     ${CYAN}http://${domain}/info.php${NC}"
    echo ""
    echo -e "  3. ${MSG_REMOVE_PHPINFO:-Hapus info.php setelah testing (keamanan)}:"
    echo -e "     ${CYAN}sudo rm ${web_root}/info.php${NC}"
    echo ""
}

# Function: List existing sites
list_sites() {
    echo ""
    echo -e "${CYAN}${MSG_AVAILABLE_SITES:-Sites tersedia}:${NC}"
    separator

    for site in ${NGINX_AVAILABLE}/*; do
        if [ -f "$site" ]; then
            site_name=$(basename "$site")
            if [ -L "${NGINX_ENABLED}/${site_name}" ]; then
                echo -e "  ${GREEN}●${NC} ${site_name} ${GREEN}(${MSG_ENABLED:-enabled})${NC}"
            else
                echo -e "  ${RED}○${NC} ${site_name} ${YELLOW}(${MSG_DISABLED:-disabled})${NC}"
            fi
        fi
    done

    separator
    echo ""
}

# Function: Enable site
enable_site() {
    local site=$1

    if [ ! -f "${NGINX_AVAILABLE}/${site}" ]; then
        echo -e "${RED}[!] Site '${site}' ${MSG_NOT_FOUND:-tidak ditemukan}${NC}"
        return 1
    fi

    if [ -L "${NGINX_ENABLED}/${site}" ]; then
        echo -e "${YELLOW}[!] Site '${site}' ${MSG_ALREADY_ENABLED:-sudah aktif}${NC}"
        return 0
    fi

    sudo ln -s "${NGINX_AVAILABLE}/${site}" "${NGINX_ENABLED}/${site}"
    echo -e "${GREEN}[✓] Site '${site}' ${MSG_ENABLED:-diaktifkan}${NC}"

    test_and_reload
}

# Function: Disable site
disable_site() {
    local site=$1

    if [ ! -L "${NGINX_ENABLED}/${site}" ]; then
        echo -e "${YELLOW}[!] Site '${site}' ${MSG_NOT_ENABLED:-tidak aktif}${NC}"
        return 0
    fi

    sudo rm "${NGINX_ENABLED}/${site}"
    echo -e "${GREEN}[✓] Site '${site}' ${MSG_DISABLED:-dinonaktifkan}${NC}"

    test_and_reload
}

# Main Menu
show_menu() {
    clear
    echo ""
    separator
    echo -e "${CYAN}    NGINX VIRTUAL HOST MANAGER${NC}"
    separator
    echo ""
    echo -e "${CYAN}${MSG_SELECT_ACTION:-Pilih aksi}:${NC}"
    echo ""
    echo -e "  ${GREEN}1)${NC} ${MSG_CREATE_NEW:-Buat virtual host baru}"
    echo -e "  ${GREEN}2)${NC} ${MSG_LIST_SITES:-Lihat daftar sites}"
    echo -e "  ${GREEN}3)${NC} ${MSG_ENABLE_SITE:-Aktifkan site}"
    echo -e "  ${GREEN}4)${NC} ${MSG_DISABLE_SITE:-Nonaktifkan site}"
    echo ""
    echo -e "  ${RED}0)${NC} ${MSG_BACK_MAIN:-Kembali}"
    separator
    echo ""
}

# Main execution
main() {
    check_nginx
    detect_php_versions

    if [ ${#PHP_VERSIONS[@]} -eq 0 ]; then
        echo -e "${RED}[!] ${MSG_NO_PHP:-Tidak ada PHP-FPM yang terinstall}!${NC}"
        echo -e "${YELLOW}${MSG_INSTALL_PHP_FIRST:-Install PHP-FPM terlebih dahulu}${NC}"
        exit 1
    fi

    while true; do
        show_menu
        read -p "$(echo -e ${GREEN}${MSG_ENTER_CHOICE:-Pilihan}:${NC} )" choice

        case $choice in
            1)
                # Create new virtual host
                echo ""
                separator
                echo -e "${CYAN}    ${MSG_CREATE_NEW:-BUAT VIRTUAL HOST BARU}${NC}"
                separator
                echo ""

                # Get domain name
                read -p "$(echo -e ${GREEN}Domain name:${NC} )" domain
                if [ -z "$domain" ]; then
                    echo -e "${RED}[!] Domain ${MSG_REQUIRED:-diperlukan}!${NC}"
                    read -p "$(echo -e ${MSG_PRESS_ENTER:-Tekan Enter...})"
                    continue
                fi

                # Remove www. prefix if present
                domain="${domain#www.}"

                # Select PHP version
                show_php_menu
                read -p "$(echo -e ${GREEN}${MSG_ENTER_CHOICE:-Pilihan}:${NC} )" php_choice

                if [ -z "$php_choice" ] || [ "$php_choice" -lt 1 ] || [ "$php_choice" -gt ${#PHP_VERSIONS[@]} ] 2>/dev/null; then
                    echo -e "${RED}[!] ${MSG_INVALID_CHOICE:-Pilihan tidak valid}!${NC}"
                    read -p "$(echo -e ${MSG_PRESS_ENTER:-Tekan Enter...})"
                    continue
                fi

                php_version="${PHP_VERSIONS[$((php_choice-1))]}"

                # Get web root
                default_root="/var/www/${domain}/public"
                read -p "$(echo -e ${GREEN}Web root${NC} [${default_root}]: )" web_root
                web_root="${web_root:-$default_root}"

                # Confirm
                echo ""
                echo -e "${CYAN}${MSG_CONFIRM:-Konfirmasi}:${NC}"
                echo -e "  Domain   : ${GREEN}${domain}${NC}"
                echo -e "  PHP      : ${GREEN}${php_version}${NC}"
                echo -e "  Web Root : ${GREEN}${web_root}${NC}"
                echo ""
                read -p "$(echo -e ${YELLOW}${MSG_CONTINUE:-Lanjutkan}? [Y/n]:${NC} )" confirm

                if [[ "$confirm" =~ ^[Nn] ]]; then
                    continue
                fi

                # Create virtual host
                if create_vhost "$domain" "$php_version" "$web_root"; then
                    if test_and_reload; then
                        show_summary "$domain" "$php_version" "$web_root"
                    fi
                fi

                read -p "$(echo -e ${MSG_PRESS_ENTER:-Tekan Enter...})"
                ;;
            2)
                # List sites
                list_sites
                read -p "$(echo -e ${MSG_PRESS_ENTER:-Tekan Enter...})"
                ;;
            3)
                # Enable site
                list_sites
                read -p "$(echo -e ${GREEN}Site name:${NC} )" site
                if [ -n "$site" ]; then
                    enable_site "$site"
                fi
                read -p "$(echo -e ${MSG_PRESS_ENTER:-Tekan Enter...})"
                ;;
            4)
                # Disable site
                list_sites
                read -p "$(echo -e ${GREEN}Site name:${NC} )" site
                if [ -n "$site" ]; then
                    disable_site "$site"
                fi
                read -p "$(echo -e ${MSG_PRESS_ENTER:-Tekan Enter...})"
                ;;
            0)
                exit 0
                ;;
            *)
                echo -e "${RED}[!] ${MSG_INVALID_CHOICE:-Pilihan tidak valid}!${NC}"
                sleep 1
                ;;
        esac
    done
}

# Run
main
