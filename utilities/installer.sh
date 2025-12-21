#!/bin/bash

BASE_URL="https://raw.githubusercontent.com/IrfanArsyad/chocobash/main"

# Warna
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

clear
echo -e "${CYAN}"
echo "  ╔═══════════════════════════════════════════════════════════╗"
echo "  ║                   SYSTEM UTILITIES                        ║"
echo "  ╚═══════════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo ""
echo -e "${YELLOW}  Pilih utility yang ingin dijalankan:${NC}"
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${WHITE}System Info:${NC}"
echo -e "  ${GREEN}[1]${NC} System Info     ${YELLOW}(Tampilkan Informasi Sistem)${NC}"
echo -e "  ${GREEN}[2]${NC} Disk Usage      ${YELLOW}(Tampilkan Penggunaan Disk)${NC}"
echo -e "  ${GREEN}[3]${NC} Network Info    ${YELLOW}(Tampilkan Informasi Jaringan)${NC}"
echo ""
echo -e "  ${WHITE}Maintenance:${NC}"
echo -e "  ${GREEN}[4]${NC} Update System   ${YELLOW}(Update & Upgrade Packages)${NC}"
echo -e "  ${GREEN}[5]${NC} Cleanup         ${YELLOW}(Bersihkan Cache & Temp Files)${NC}"
echo -e "  ${GREEN}[6]${NC} Fix Permissions ${YELLOW}(Perbaiki Permission Web)${NC}"
echo ""
echo -e "  ${WHITE}Tools:${NC}"
echo -e "  ${GREEN}[7]${NC} Install Essentials  ${YELLOW}(curl, wget, unzip, dll)${NC}"
echo -e "  ${GREEN}[8]${NC} Create Swap         ${YELLOW}(Buat Swap File)${NC}"
echo -e "  ${GREEN}[9]${NC} Set Timezone        ${YELLOW}(Atur Timezone)${NC}"
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${RED}[0]${NC} Kembali ke Menu Utama"
echo ""

echo -ne "  ${CYAN}Masukkan pilihan [0-9]: ${NC}"
read pilihan

case $pilihan in
    1)
        echo -e "\n${GREEN}[*] Menampilkan System Info...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/utilities/sysinfo.sh)"
        ;;
    2)
        echo -e "\n${GREEN}[*] Menampilkan Disk Usage...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/utilities/diskusage.sh)"
        ;;
    3)
        echo -e "\n${GREEN}[*] Menampilkan Network Info...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/utilities/netinfo.sh)"
        ;;
    4)
        echo -e "\n${GREEN}[*] Memulai Update System...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/utilities/update.sh)"
        ;;
    5)
        echo -e "\n${GREEN}[*] Memulai Cleanup...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/utilities/cleanup.sh)"
        ;;
    6)
        echo -e "\n${GREEN}[*] Memperbaiki Permissions...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/utilities/fix-permissions.sh)"
        ;;
    7)
        echo -e "\n${GREEN}[*] Menginstall Essential Tools...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/utilities/essentials.sh)"
        ;;
    8)
        echo -e "\n${GREEN}[*] Membuat Swap File...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/utilities/swap.sh)"
        ;;
    9)
        echo -e "\n${GREEN}[*] Mengatur Timezone...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/utilities/timezone.sh)"
        ;;
    0)
        exit 0
        ;;
    *)
        echo -e "  ${RED}Pilihan tidak valid!${NC}"
        ;;
esac
