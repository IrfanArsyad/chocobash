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

# Function: Generate nginx config for PRODUCTION (with domain)
generate_nginx_config_production() {
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

# Function: Generate nginx config for SELF-HOSTED (IP:port, no domain)
generate_nginx_config_selfhosted() {
    local app_name=$1
    local php_version=$2
    local web_root=$3
    local port=$4

    cat << EOF
# Self-hosted configuration for ${app_name}
# Access via: http://YOUR_IP:${port} or http://localhost:${port}

server {
    listen ${port} default_server;
    listen [::]:${port} default_server;

    # No domain needed - accepts any hostname/IP
    server_name _;
    root ${web_root};

    index index.php index.html index.htm;

    # Logging
    access_log /var/log/nginx/${app_name}.access.log;
    error_log /var/log/nginx/${app_name}.error.log;

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

# Function: Create virtual host (Production - with domain)
create_vhost() {
    local domain=$1
    local php_version=$2
    local web_root=$3
    local config_file="${NGINX_AVAILABLE}/${domain}"

    echo ""
    echo -e "${CYAN}[*] ${MSG_CREATING:-Membuat} nginx config...${NC}"

    # Generate and save config
    generate_nginx_config_production "$domain" "$php_version" "$web_root" | sudo tee "$config_file" > /dev/null

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

# Function: Check and handle default site conflict
check_default_site_conflict() {
    local port=$1

    # Check if default site exists and is enabled
    if [ -L "${NGINX_ENABLED}/default" ]; then
        # Check if default site uses the same port
        if grep -q "listen.*${port}" "${NGINX_AVAILABLE}/default" 2>/dev/null || [ "$port" = "80" ]; then
            echo -e "${YELLOW}[!] ${MSG_DEFAULT_CONFLICT:-Default site mungkin konflik dengan port ${port}}${NC}"
            read -p "$(echo -e ${YELLOW}${MSG_DISABLE_DEFAULT:-Nonaktifkan default site}? [Y/n]:${NC} )" disable_default

            if [[ ! "$disable_default" =~ ^[Nn] ]]; then
                sudo rm "${NGINX_ENABLED}/default" 2>/dev/null
                echo -e "${GREEN}[✓] Default site ${MSG_DISABLED:-dinonaktifkan}${NC}"
            fi
        fi
    fi
}

# Function: Create virtual host (Self-hosted - IP:port, no domain)
create_vhost_selfhosted() {
    local app_name=$1
    local php_version=$2
    local web_root=$3
    local port=$4
    local config_file="${NGINX_AVAILABLE}/${app_name}"

    # Check for default site conflict
    check_default_site_conflict "$port"

    echo ""
    echo -e "${CYAN}[*] ${MSG_CREATING:-Membuat} nginx config (self-hosted)...${NC}"

    # Generate and save config
    generate_nginx_config_selfhosted "$app_name" "$php_version" "$web_root" "$port" | sudo tee "$config_file" > /dev/null

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}[✓] Config ${MSG_CREATED:-dibuat}: ${config_file}${NC}"
    else
        echo -e "${RED}[!] ${MSG_FAILED:-Gagal} membuat config${NC}"
        return 1
    fi

    # Create symlink
    echo -e "${CYAN}[*] ${MSG_CREATING_SYMLINK:-Membuat symlink}...${NC}"
    if [ -L "${NGINX_ENABLED}/${app_name}" ]; then
        sudo rm "${NGINX_ENABLED}/${app_name}"
    fi

    sudo ln -s "$config_file" "${NGINX_ENABLED}/${app_name}"

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}[✓] Symlink ${MSG_CREATED:-dibuat}: ${NGINX_ENABLED}/${app_name}${NC}"
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

# Function: Show summary (Self-hosted)
show_summary_selfhosted() {
    local app_name=$1
    local php_version=$2
    local web_root=$3
    local port=$4

    # Get server IP
    local server_ip=$(hostname -I | awk '{print $1}')

    echo ""
    separator
    echo -e "${GREEN}[✓] ${MSG_SETUP_COMPLETE:-Setup selesai}!${NC}"
    separator
    echo ""
    echo -e "${CYAN}${MSG_SUMMARY:-Ringkasan}:${NC}"
    echo -e "  App Name    : ${GREEN}${app_name}${NC}"
    echo -e "  Port        : ${GREEN}${port}${NC}"
    echo -e "  PHP Version : ${GREEN}${php_version}${NC}"
    echo -e "  Web Root    : ${GREEN}${web_root}${NC}"
    echo -e "  Config      : ${GREEN}${NGINX_AVAILABLE}/${app_name}${NC}"
    echo -e "  Symlink     : ${GREEN}${NGINX_ENABLED}/${app_name}${NC}"
    echo ""
    echo -e "${YELLOW}${MSG_ACCESS_URL:-URL Akses}:${NC}"
    echo -e "  ${CYAN}http://localhost:${port}${NC}     (dari server ini)"
    echo -e "  ${CYAN}http://${server_ip}:${port}${NC}  (dari jaringan lokal)"
    echo ""
    echo -e "${YELLOW}${MSG_NEXT_STEPS:-Langkah selanjutnya}:${NC}"
    echo -e "  1. ${MSG_TEST_PHP:-Test PHP}:"
    echo -e "     ${CYAN}http://localhost:${port}/info.php${NC}"
    echo ""
    echo -e "  2. ${MSG_REMOVE_PHPINFO:-Hapus info.php setelah testing (keamanan)}:"
    echo -e "     ${CYAN}sudo rm ${web_root}/info.php${NC}"
    echo ""
    echo -e "  3. ${MSG_FIREWALL:-Buka port di firewall (jika diperlukan)}:"
    echo -e "     ${CYAN}sudo ufw allow ${port}/tcp${NC}"
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
    echo -e "  ${GREEN}1)${NC} ${MSG_CREATE_PRODUCTION:-Buat vhost Production (dengan domain)}"
    echo -e "  ${GREEN}2)${NC} ${MSG_CREATE_SELFHOSTED:-Buat vhost Self-hosted (IP:port, tanpa domain)}"
    echo -e "  ${GREEN}3)${NC} ${MSG_LIST_SITES:-Lihat daftar sites}"
    echo -e "  ${GREEN}4)${NC} ${MSG_ENABLE_SITE:-Aktifkan site}"
    echo -e "  ${GREEN}5)${NC} ${MSG_DISABLE_SITE:-Nonaktifkan site}"
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
                # Create Production virtual host (with domain)
                echo ""
                separator
                echo -e "${CYAN}    ${MSG_CREATE_PRODUCTION:-PRODUCTION VHOST (DENGAN DOMAIN)}${NC}"
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
                # Create Self-hosted virtual host (IP:port, no domain)
                echo ""
                separator
                echo -e "${CYAN}    ${MSG_CREATE_SELFHOSTED:-SELF-HOSTED VHOST (IP:PORT)}${NC}"
                separator
                echo -e "${YELLOW}${MSG_SELFHOSTED_DESC:-Untuk menjalankan aplikasi tanpa domain, diakses via IP:port}${NC}"
                echo ""

                # Get app name
                read -p "$(echo -e ${GREEN}${MSG_APP_NAME:-Nama aplikasi}:${NC} )" app_name
                if [ -z "$app_name" ]; then
                    echo -e "${RED}[!] ${MSG_APP_NAME:-Nama aplikasi} ${MSG_REQUIRED:-diperlukan}!${NC}"
                    read -p "$(echo -e ${MSG_PRESS_ENTER:-Tekan Enter...})"
                    continue
                fi

                # Sanitize app name (lowercase, no spaces)
                app_name=$(echo "$app_name" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd 'a-z0-9-')

                # Get port
                read -p "$(echo -e ${GREEN}Port${NC} [8080]: )" port
                port="${port:-8080}"

                # Validate port
                if ! [[ "$port" =~ ^[0-9]+$ ]] || [ "$port" -lt 1 ] || [ "$port" -gt 65535 ]; then
                    echo -e "${RED}[!] Port ${MSG_INVALID:-tidak valid}! (1-65535)${NC}"
                    read -p "$(echo -e ${MSG_PRESS_ENTER:-Tekan Enter...})"
                    continue
                fi

                # Check if port is already in use
                if sudo lsof -i:${port} &>/dev/null; then
                    echo -e "${YELLOW}[!] ${MSG_PORT_IN_USE:-Port ${port} sudah digunakan}${NC}"
                    read -p "$(echo -e ${YELLOW}${MSG_CONTINUE_ANYWAY:-Lanjutkan?} [y/N]:${NC} )" port_confirm
                    if [[ ! "$port_confirm" =~ ^[Yy] ]]; then
                        continue
                    fi
                fi

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
                default_root="/var/www/${app_name}/public"
                read -p "$(echo -e ${GREEN}Web root${NC} [${default_root}]: )" web_root
                web_root="${web_root:-$default_root}"

                # Confirm
                echo ""
                echo -e "${CYAN}${MSG_CONFIRM:-Konfirmasi}:${NC}"
                echo -e "  App Name : ${GREEN}${app_name}${NC}"
                echo -e "  Port     : ${GREEN}${port}${NC}"
                echo -e "  PHP      : ${GREEN}${php_version}${NC}"
                echo -e "  Web Root : ${GREEN}${web_root}${NC}"
                echo ""
                read -p "$(echo -e ${YELLOW}${MSG_CONTINUE:-Lanjutkan}? [Y/n]:${NC} )" confirm

                if [[ "$confirm" =~ ^[Nn] ]]; then
                    continue
                fi

                # Create self-hosted virtual host
                if create_vhost_selfhosted "$app_name" "$php_version" "$web_root" "$port"; then
                    if test_and_reload; then
                        show_summary_selfhosted "$app_name" "$php_version" "$web_root" "$port"
                    fi
                fi

                read -p "$(echo -e ${MSG_PRESS_ENTER:-Tekan Enter...})"
                ;;
            3)
                # List sites
                list_sites
                read -p "$(echo -e ${MSG_PRESS_ENTER:-Tekan Enter...})"
                ;;
            4)
                # Enable site
                list_sites
                read -p "$(echo -e ${GREEN}Site name:${NC} )" site
                if [ -n "$site" ]; then
                    enable_site "$site"
                fi
                read -p "$(echo -e ${MSG_PRESS_ENTER:-Tekan Enter...})"
                ;;
            5)
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
