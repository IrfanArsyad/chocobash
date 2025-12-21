#!/bin/bash

# ============================================
# ChocoBash - Linux Installer Script
# Author: Irfan Arsyad
# ============================================

# Base URL untuk remote scripts
BASE_URL="https://raw.githubusercontent.com/IrfanArsyad/chocobash/main"

# Warna
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

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
    echo -e "${WHITE}  Selamat Datang di ChocoBash!${NC}"
    echo -e "${YELLOW}  Pilih kategori instalasi:${NC}"
    echo ""
    separator
    echo ""
    echo -e "  ${GREEN}[1]${NC} ${WHITE}PHP${NC}              - Install PHP (7.4 - 8.4)"
    echo -e "  ${GREEN}[2]${NC} ${WHITE}Web Server${NC}       - Nginx, Apache2, Caddy"
    echo -e "  ${GREEN}[3]${NC} ${WHITE}Database${NC}         - MySQL, MariaDB, PostgreSQL, Redis, MongoDB"
    echo -e "  ${GREEN}[4]${NC} ${WHITE}Dev Tools${NC}        - Git, Composer, Node.js, Yarn, NPM"
    echo -e "  ${GREEN}[5]${NC} ${WHITE}Container${NC}        - Docker, Docker Compose, Portainer"
    echo -e "  ${GREEN}[6]${NC} ${WHITE}Security${NC}         - UFW Firewall, Fail2Ban, SSL/Certbot"
    echo -e "  ${GREEN}[7]${NC} ${WHITE}Monitoring${NC}       - htop, netdata, Grafana"
    echo -e "  ${GREEN}[8]${NC} ${WHITE}Utilities${NC}        - System Info, Cleanup, Update System"
    echo ""
    separator
    echo ""
    echo -e "  ${RED}[0]${NC} ${WHITE}Keluar${NC}"
    echo ""
}

# Fungsi untuk konfirmasi
confirm() {
    echo ""
    echo -e "${YELLOW}Tekan Enter untuk kembali ke menu...${NC}"
    read
}

# Loop menu utama
while true; do
    show_banner
    show_menu

    echo -ne "  ${CYAN}Masukkan pilihan [0-8]: ${NC}"
    read pilihan

    case $pilihan in
        1)
            bash -c "$(wget -qLO - ${BASE_URL}/php/installer.sh)"
            confirm
            ;;
        2)
            bash -c "$(wget -qLO - ${BASE_URL}/webserver/installer.sh)"
            confirm
            ;;
        3)
            bash -c "$(wget -qLO - ${BASE_URL}/database/installer.sh)"
            confirm
            ;;
        4)
            bash -c "$(wget -qLO - ${BASE_URL}/devtools/installer.sh)"
            confirm
            ;;
        5)
            bash -c "$(wget -qLO - ${BASE_URL}/container/installer.sh)"
            confirm
            ;;
        6)
            bash -c "$(wget -qLO - ${BASE_URL}/security/installer.sh)"
            confirm
            ;;
        7)
            bash -c "$(wget -qLO - ${BASE_URL}/monitoring/installer.sh)"
            confirm
            ;;
        8)
            bash -c "$(wget -qLO - ${BASE_URL}/utilities/installer.sh)"
            confirm
            ;;
        0)
            echo ""
            echo -e "  ${GREEN}Terima kasih telah menggunakan ChocoBash!${NC}"
            echo -e "  ${CYAN}Sampai jumpa lagi!${NC}"
            echo ""
            exit 0
            ;;
        *)
            echo -e "  ${RED}Pilihan tidak valid! Silahkan pilih 0-8.${NC}"
            sleep 2
            ;;
    esac
done
