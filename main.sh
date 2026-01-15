#!/bin/bash

# ============================================
# ChocoBash - Linux Installer Script
# Author: Irfan Arsyad
# ============================================

# Base URL untuk remote scripts
BASE_URL="https://raw.githubusercontent.com/IrfanArsyad/chocobash/main"

# Config file for language
LANG_CONFIG="$HOME/.chocobash_lang"

# Warna
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Load language file
load_language() {
    local lang_code="$1"
    local lang_file="${BASE_URL}/lang/${lang_code}.sh"

    # Download and source language file (remove CRLF if present)
    eval "$(wget -qLO - ${lang_file} | tr -d '\r')"
}

# Select language on first run or when requested
select_language() {
    clear
    echo -e "${CYAN}"
    echo "  ╔═══════════════════════════════════════════════════════════╗"
    echo "  ║              LANGUAGE / BAHASA                            ║"
    echo "  ╚═══════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    echo ""
    echo -e "${YELLOW}  Pilih Bahasa / Select Language:${NC}"
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -e "  ${GREEN}[1]${NC} ${WHITE}Bahasa Indonesia${NC}"
    echo -e "  ${GREEN}[2]${NC} ${WHITE}English${NC}"
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -ne "  ${CYAN}[1-2]: ${NC}"
    read lang_choice

    case $lang_choice in
        1)
            echo "id" > "$LANG_CONFIG"
            CHOCO_LANG="id"
            ;;
        2)
            echo "en" > "$LANG_CONFIG"
            CHOCO_LANG="en"
            ;;
        *)
            echo "id" > "$LANG_CONFIG"
            CHOCO_LANG="id"
            ;;
    esac

    load_language "$CHOCO_LANG"
}

# Check and load language
init_language() {
    if [ -f "$LANG_CONFIG" ]; then
        CHOCO_LANG=$(cat "$LANG_CONFIG")
        load_language "$CHOCO_LANG"
    else
        select_language
    fi
}

# Fungsi untuk menampilkan banner
show_banner() {
    clear
    echo -e "${CYAN}"
    echo "  ╔═══════════════════════════════════════════════════════════╗"
    echo "  ║                                                           ║"
    echo "  ║     ██████╗██╗  ██╗ ██████╗  ██████╗ ██████╗              ║"
    echo "  ║    ██╔════╝██║  ██║██╔═══██╗██╔════╝██╔═══██╗             ║"
    echo "  ║    ██║     ███████║██║   ██║██║     ██║   ██║             ║"
    echo "  ║    ██║     ██╔══██║██║   ██║██║     ██║   ██║             ║"
    echo "  ║    ╚██████╗██║  ██║╚██████╔╝╚██████╗╚██████╔╝             ║"
    echo "  ║     ╚═════╝╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═════╝              ║"
    echo "  ║                    ██████╗  █████╗ ███████╗██╗  ██╗       ║"
    echo "  ║                    ██╔══██╗██╔══██╗██╔════╝██║  ██║       ║"
    echo "  ║                    ██████╔╝███████║███████╗███████║       ║"
    echo "  ║                    ██╔══██╗██╔══██║╚════██║██╔══██║       ║"
    echo "  ║                    ██████╔╝██║  ██║███████║██║  ██║       ║"
    echo "  ║                    ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝       ║"
    echo "  ║                                                           ║"
    echo "  ║           Linux Server Installer & Manager                ║"
    echo "  ║                    Version 2.0                            ║"
    echo "  ╚═══════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# Fungsi untuk menampilkan garis pemisah
separator() {
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

# Fungsi untuk menampilkan menu utama
show_menu() {
    echo ""
    echo -e "${WHITE}  ${MSG_WELCOME}${NC}"
    echo -e "${YELLOW}  ${MSG_SELECT_CATEGORY}${NC}"
    echo ""
    separator
    echo ""
    echo -e "  ${GREEN}[1]${NC} ${WHITE}PHP${NC}              - ${DESC_PHP}"
    echo -e "  ${GREEN}[2]${NC} ${WHITE}Web Server${NC}       - ${DESC_WEBSERVER}"
    echo -e "  ${GREEN}[3]${NC} ${WHITE}Database${NC}         - ${DESC_DATABASE}"
    echo -e "  ${GREEN}[4]${NC} ${WHITE}Dev Tools${NC}        - ${DESC_DEVTOOLS}"
    echo -e "  ${GREEN}[5]${NC} ${WHITE}Container${NC}        - ${DESC_CONTAINER}"
    echo -e "  ${GREEN}[6]${NC} ${WHITE}Security${NC}         - ${DESC_SECURITY}"
    echo -e "  ${GREEN}[7]${NC} ${WHITE}Monitoring${NC}       - ${DESC_MONITORING}"
    echo -e "  ${GREEN}[8]${NC} ${WHITE}Utilities${NC}        - ${DESC_UTILITIES}"
    echo -e "  ${GREEN}[9]${NC} ${WHITE}User Management${NC}  - ${DESC_USERMANAGEMENT}"
    echo -e "  ${GREEN}[10]${NC} ${WHITE}Uninstall${NC}       - ${DESC_UNINSTALL}"
    echo ""
    separator
    echo ""
    echo -e "  ${PURPLE}[L]${NC} ${WHITE}Language${NC}         - Change Language / Ganti Bahasa"
    echo -e "  ${RED}[0]${NC} ${WHITE}${MSG_EXIT}${NC}"
    echo ""
}

# Fungsi untuk konfirmasi
confirm() {
    echo ""
    echo -e "${YELLOW}${MSG_PRESS_ENTER}${NC}"
    read
}

# Initialize language
init_language

# Loop menu utama
while true; do
    show_banner
    show_menu

    echo -ne "  ${CYAN}${MSG_ENTER_CHOICE} [0-10/L]: ${NC}"
    read pilihan

    case $pilihan in
        1)
            CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/php/installer.sh | tr -d '\r')"
            confirm
            ;;
        2)
            CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/webserver/installer.sh | tr -d '\r')"
            confirm
            ;;
        3)
            CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/database/installer.sh | tr -d '\r')"
            confirm
            ;;
        4)
            CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/devtools/installer.sh | tr -d '\r')"
            confirm
            ;;
        5)
            CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/container/installer.sh | tr -d '\r')"
            confirm
            ;;
        6)
            CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/security/installer.sh | tr -d '\r')"
            confirm
            ;;
        7)
            CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/monitoring/installer.sh | tr -d '\r')"
            confirm
            ;;
        8)
            CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/utilities/installer.sh | tr -d '\r')"
            confirm
            ;;
        9)
            CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/usermanagement/installer.sh | tr -d '\r')"
            confirm
            ;;
        10)
            CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/uninstall/installer.sh | tr -d '\r')"
            confirm
            ;;
        l|L)
            select_language
            ;;
        0)
            echo ""
            echo -e "  ${GREEN}${MSG_GOODBYE}${NC}"
            echo -e "  ${CYAN}${MSG_SEE_YOU}${NC}"
            echo ""
            exit 0
            ;;
        *)
            echo -e "  ${RED}${MSG_INVALID_CHOICE}${NC}"
            sleep 2
            ;;
    esac
done
