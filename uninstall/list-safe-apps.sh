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
NC='\033[0m'

# Messages based on language
if [ "$CHOCO_LANG" = "en" ]; then
    MSG_SCANNING="Scanning installed applications..."
    MSG_SAFE_APPS="Applications safe to uninstall"
    MSG_TOTAL="Total"
    MSG_APPS="applications"
    MSG_TIP="TIP: Use option [1] in Uninstall menu for interactive selection"
else
    MSG_SCANNING="Memindai aplikasi terinstall..."
    MSG_SAFE_APPS="Aplikasi aman untuk di-uninstall"
    MSG_TOTAL="Total"
    MSG_APPS="aplikasi"
    MSG_TIP="TIP: Gunakan opsi [1] di menu Uninstall untuk pemilihan interaktif"
fi

echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${WHITE}  ${MSG_SAFE_APPS}${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

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

# Get manually installed packages, excluding protected ones
SAFE_APPS=$(apt-mark showmanual 2>/dev/null | grep -vE "${EXCLUDE_PATTERN}" | sort)

if [ -z "$SAFE_APPS" ]; then
    echo -e "${YELLOW}  ${MSG_NO_APPS}${NC}"
else
    COUNT=0
    while IFS= read -r app; do
        COUNT=$((COUNT + 1))
        # Get package description
        DESC=$(dpkg-query -W -f='${Description}' "$app" 2>/dev/null | head -n1 | cut -c1-50)
        if [ -z "$DESC" ]; then
            DESC="-"
        fi
        printf "  ${GREEN}%-30s${NC} ${WHITE}%s${NC}\n" "$app" "$DESC"
    done <<< "$SAFE_APPS"

    echo ""
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${WHITE}  ${MSG_TOTAL}: ${GREEN}${COUNT}${NC} ${WHITE}${MSG_APPS}${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -e "${YELLOW}  ${MSG_TIP}${NC}"
fi

echo ""
