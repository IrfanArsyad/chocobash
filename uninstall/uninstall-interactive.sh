#!/bin/bash

BASE_URL="https://raw.githubusercontent.com/IrfanArsyad/chocobash/main"

# Load language
CHOCO_LANG="${CHOCO_LANG:-id}"
eval "$(wget -qLO - ${BASE_URL}/lang/${CHOCO_LANG}.sh)"

# Warna
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
PURPLE='\033[0;35m'
NC='\033[0m'
BOLD='\033[1m'

# Messages based on language
if [ "$CHOCO_LANG" = "en" ]; then
    MSG_SCANNING="Scanning installed applications..."
    MSG_SAFE_APPS="Applications Safe to Uninstall"
    MSG_SELECT_APPS="Select applications to uninstall"
    MSG_NO_APPS="No applications found"
    MSG_UNINSTALLING="Uninstalling"
    MSG_UNINSTALL_DONE="Uninstall complete!"
    MSG_SELECTED="selected"
    MSG_CONFIRM_UNINSTALL="Confirm uninstall these applications?"
    MSG_CANCELLED="Operation cancelled"
    MSG_PAGE="Page"
    MSG_OF="of"
    MSG_CONTROLS="Controls"
    MSG_TOGGLE="Toggle select"
    MSG_NEXT_PAGE="Next page"
    MSG_PREV_PAGE="Previous page"
    MSG_DO_UNINSTALL="Uninstall selected"
    MSG_EXIT_MENU="Exit"
    MSG_SEARCH="Search"
    MSG_CLEAR_SEARCH="Clear search"
    MSG_ENTER_NUM="Enter number"
    MSG_YES="y"
    MSG_NO="n"
    MSG_TOTAL="Total"
    MSG_APPS="applications"
    MSG_NONE_SELECTED="No applications selected"
    MSG_WILL_REMOVE="Will be removed"
    MSG_ENTER_SEARCH="Enter search term (or empty to clear)"
    MSG_SEARCH_RESULTS="Search results for"
else
    MSG_SCANNING="Memindai aplikasi terinstall..."
    MSG_SAFE_APPS="Aplikasi Aman untuk Di-uninstall"
    MSG_SELECT_APPS="Pilih aplikasi untuk di-uninstall"
    MSG_NO_APPS="Tidak ada aplikasi ditemukan"
    MSG_UNINSTALLING="Menghapus"
    MSG_UNINSTALL_DONE="Uninstall selesai!"
    MSG_SELECTED="dipilih"
    MSG_CONFIRM_UNINSTALL="Konfirmasi uninstall aplikasi ini?"
    MSG_CANCELLED="Operasi dibatalkan"
    MSG_PAGE="Halaman"
    MSG_OF="dari"
    MSG_CONTROLS="Kontrol"
    MSG_TOGGLE="Toggle pilih"
    MSG_NEXT_PAGE="Halaman berikutnya"
    MSG_PREV_PAGE="Halaman sebelumnya"
    MSG_DO_UNINSTALL="Uninstall terpilih"
    MSG_EXIT_MENU="Keluar"
    MSG_SEARCH="Cari"
    MSG_CLEAR_SEARCH="Hapus pencarian"
    MSG_ENTER_NUM="Masukkan nomor"
    MSG_YES="y"
    MSG_NO="n"
    MSG_TOTAL="Total"
    MSG_APPS="aplikasi"
    MSG_NONE_SELECTED="Tidak ada aplikasi dipilih"
    MSG_WILL_REMOVE="Akan dihapus"
    MSG_ENTER_SEARCH="Masukkan kata kunci (atau kosong untuk hapus)"
    MSG_SEARCH_RESULTS="Hasil pencarian untuk"
fi

# Protected packages that should never be uninstalled
PROTECTED_PATTERNS=(
    "^ubuntu-"
    "^linux-"
    "^grub-"
    "^systemd"
    "^init"
    "^libc"
    "^libstdc"
    "^apt"
    "^dpkg"
    "^base-"
    "^passwd"
    "^login"
    "^coreutils"
    "^util-linux"
    "^mount"
    "^sudo"
    "^bash"
    "^dash"
    "^adduser"
    "^hostname"
    "^ifupdown"
    "^iproute"
    "^netbase"
    "^udev"
    "^dbus"
    "^perl-base"
    "^sed"
    "^grep"
    "^tar"
    "^gzip"
    "^bzip2"
    "^xz-utils"
    "^findutils"
    "^mawk"
    "^debconf"
    "^debianutils"
    "^diffutils"
    "^e2fsprogs"
    "^fdisk"
    "^gpgv"
    "^libapt"
    "^libpam"
    "^libselinux"
    "^libssl"
    "^libsystemd"
    "^libudev"
    "^zlib"
    "^libgcc"
    "^libncurses"
    "^libreadline"
    "^libpcre"
    "^libacl"
    "^libattr"
    "^libaudit"
    "^libblkid"
    "^libcap"
    "^libcom-err"
    "^libcrypt"
    "^libdb"
    "^libext2fs"
    "^libfdisk"
    "^libgcrypt"
    "^libgmp"
    "^libgnutls"
    "^libgpg-error"
    "^libidn"
    "^liblz4"
    "^liblzma"
    "^libmount"
    "^libnettle"
    "^libp11-kit"
    "^libseccomp"
    "^libsemanage"
    "^libsepol"
    "^libsmartcols"
    "^libtasn1"
    "^libunistring"
    "^libuuid"
    "^libzstd"
    "^openssh-server"
    "^network-manager"
    "^cloud-init"
    "^snapd"
)

# Build grep pattern
EXCLUDE_PATTERN=$(printf "|%s" "${PROTECTED_PATTERNS[@]}")
EXCLUDE_PATTERN="${EXCLUDE_PATTERN:1}"

# Get safe apps list
get_safe_apps() {
    apt-mark showmanual 2>/dev/null | grep -vE "${EXCLUDE_PATTERN}" | sort
}

# Store apps in array
mapfile -t ALL_APPS < <(get_safe_apps)
TOTAL_APPS=${#ALL_APPS[@]}

if [ $TOTAL_APPS -eq 0 ]; then
    echo -e "${YELLOW}  ${MSG_NO_APPS}${NC}"
    exit 0
fi

# Selected apps tracking (associative array)
declare -A SELECTED

# Pagination settings
PAGE_SIZE=15
CURRENT_PAGE=1
SEARCH_TERM=""

# Filter apps based on search
get_filtered_apps() {
    if [ -z "$SEARCH_TERM" ]; then
        printf '%s\n' "${ALL_APPS[@]}"
    else
        printf '%s\n' "${ALL_APPS[@]}" | grep -i "$SEARCH_TERM"
    fi
}

# Calculate total pages
get_total_pages() {
    local filtered_count
    filtered_count=$(get_filtered_apps | wc -l)
    echo $(( (filtered_count + PAGE_SIZE - 1) / PAGE_SIZE ))
}

# Get apps for current page
get_page_apps() {
    local start=$(( (CURRENT_PAGE - 1) * PAGE_SIZE ))
    get_filtered_apps | tail -n +$((start + 1)) | head -n $PAGE_SIZE
}

# Count selected apps
count_selected() {
    local count=0
    for key in "${!SELECTED[@]}"; do
        if [ "${SELECTED[$key]}" = "1" ]; then
            count=$((count + 1))
        fi
    done
    echo $count
}

# Get selected apps list
get_selected_apps() {
    for key in "${!SELECTED[@]}"; do
        if [ "${SELECTED[$key]}" = "1" ]; then
            echo "$key"
        fi
    done
}

# Display the interactive menu
show_menu() {
    clear
    local total_pages=$(get_total_pages)
    local selected_count=$(count_selected)
    local filtered_count=$(get_filtered_apps | wc -l)

    echo -e "${CYAN}"
    echo "  ╔═══════════════════════════════════════════════════════════╗"
    echo "  ║              ${MSG_SAFE_APPS}                   ║"
    echo "  ╚═══════════════════════════════════════════════════════════╝"
    echo -e "${NC}"

    # Show search info if active
    if [ -n "$SEARCH_TERM" ]; then
        echo -e "  ${PURPLE}${MSG_SEARCH_RESULTS}: \"${SEARCH_TERM}\" (${filtered_count} ${MSG_APPS})${NC}"
    fi

    echo -e "  ${YELLOW}${MSG_SELECTED}: ${GREEN}${selected_count}${NC} ${YELLOW}${MSG_APPS}${NC}"
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

    # Display apps for current page
    local i=1
    local start_num=$(( (CURRENT_PAGE - 1) * PAGE_SIZE + 1 ))

    while IFS= read -r app; do
        if [ -z "$app" ]; then continue; fi

        local checkbox
        if [ "${SELECTED[$app]}" = "1" ]; then
            checkbox="${GREEN}[X]${NC}"
        else
            checkbox="${WHITE}[ ]${NC}"
        fi

        local num=$((start_num + i - 1))
        local desc=$(dpkg-query -W -f='${Description}' "$app" 2>/dev/null | head -n1 | cut -c1-35)
        [ -z "$desc" ] && desc="-"

        printf "  ${checkbox} ${CYAN}%2d${NC} ${WHITE}%-25s${NC} ${YELLOW}%s${NC}\n" "$i" "$app" "$desc"
        i=$((i + 1))
    done < <(get_page_apps)

    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "  ${WHITE}${MSG_PAGE} ${CURRENT_PAGE} ${MSG_OF} ${total_pages}${NC} | ${WHITE}${MSG_TOTAL}: ${filtered_count} ${MSG_APPS}${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -e "  ${WHITE}${MSG_CONTROLS}:${NC}"
    echo -e "  ${GREEN}[1-${PAGE_SIZE}]${NC} ${MSG_TOGGLE}    ${GREEN}[n]${NC} ${MSG_NEXT_PAGE}    ${GREEN}[p]${NC} ${MSG_PREV_PAGE}"
    echo -e "  ${GREEN}[s]${NC} ${MSG_SEARCH}           ${GREEN}[c]${NC} ${MSG_CLEAR_SEARCH}"
    echo -e "  ${GREEN}[u]${NC} ${MSG_DO_UNINSTALL}  ${RED}[q]${NC} ${MSG_EXIT_MENU}"
    echo ""
}

# Main loop
while true; do
    show_menu

    echo -ne "  ${CYAN}${MSG_ENTER_NUM}: ${NC}"
    read -r choice

    case $choice in
        [1-9]|1[0-5])
            # Toggle selection for number
            local_apps=()
            while IFS= read -r app; do
                [ -n "$app" ] && local_apps+=("$app")
            done < <(get_page_apps)

            idx=$((choice - 1))
            if [ $idx -ge 0 ] && [ $idx -lt ${#local_apps[@]} ]; then
                app="${local_apps[$idx]}"
                if [ "${SELECTED[$app]}" = "1" ]; then
                    unset SELECTED["$app"]
                else
                    SELECTED["$app"]="1"
                fi
            fi
            ;;
        n|N)
            # Next page
            total_pages=$(get_total_pages)
            if [ $CURRENT_PAGE -lt $total_pages ]; then
                CURRENT_PAGE=$((CURRENT_PAGE + 1))
            fi
            ;;
        p|P)
            # Previous page
            if [ $CURRENT_PAGE -gt 1 ]; then
                CURRENT_PAGE=$((CURRENT_PAGE - 1))
            fi
            ;;
        s|S)
            # Search
            echo -ne "  ${CYAN}${MSG_ENTER_SEARCH}: ${NC}"
            read -r SEARCH_TERM
            CURRENT_PAGE=1
            ;;
        c|C)
            # Clear search
            SEARCH_TERM=""
            CURRENT_PAGE=1
            ;;
        u|U)
            # Uninstall selected
            selected_count=$(count_selected)
            if [ $selected_count -eq 0 ]; then
                echo -e "\n  ${YELLOW}${MSG_NONE_SELECTED}${NC}"
                sleep 2
                continue
            fi

            # Show confirmation
            clear
            echo -e "${CYAN}"
            echo "  ╔═══════════════════════════════════════════════════════════╗"
            echo "  ║              ${MSG_CONFIRM_UNINSTALL}                      ║"
            echo "  ╚═══════════════════════════════════════════════════════════╝"
            echo -e "${NC}"
            echo ""
            echo -e "  ${WHITE}${MSG_WILL_REMOVE}:${NC}"
            echo ""

            while IFS= read -r app; do
                echo -e "  ${RED}[-]${NC} ${WHITE}${app}${NC}"
            done < <(get_selected_apps)

            echo ""
            echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
            echo ""
            echo -ne "  ${YELLOW}${MSG_CONFIRM_UNINSTALL} [${MSG_YES}/${MSG_NO}]: ${NC}"
            read -r confirm

            if [[ "$confirm" =~ ^[Yy]$ ]]; then
                echo ""
                while IFS= read -r app; do
                    echo -e "  ${GREEN}[*]${NC} ${MSG_UNINSTALLING} ${WHITE}${app}${NC}..."
                    sudo apt remove -y "$app" 2>/dev/null
                done < <(get_selected_apps)

                # Clear selections
                SELECTED=()

                # Refresh app list
                mapfile -t ALL_APPS < <(get_safe_apps)
                TOTAL_APPS=${#ALL_APPS[@]}
                CURRENT_PAGE=1

                echo ""
                echo -e "  ${GREEN}[✓] ${MSG_UNINSTALL_DONE}${NC}"
                echo ""
                echo -e "${YELLOW}  ${MSG_PRESS_ENTER}${NC}"
                read
            else
                echo -e "\n  ${YELLOW}${MSG_CANCELLED}${NC}"
                sleep 2
            fi
            ;;
        q|Q|0)
            # Exit
            exit 0
            ;;
    esac
done
