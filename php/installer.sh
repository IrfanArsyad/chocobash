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
echo "  ║                     PHP INSTALLER                         ║"
echo "  ╚═══════════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo ""
echo -e "${YELLOW}  Pilih versi PHP yang ingin diinstall:${NC}"
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${GREEN}[1]${NC} PHP 7.4 FPM    ${YELLOW}(Legacy Support)${NC}"
echo -e "  ${GREEN}[2]${NC} PHP 8.0 FPM    ${YELLOW}(End of Life)${NC}"
echo -e "  ${GREEN}[3]${NC} PHP 8.1 FPM    ${YELLOW}(Security Support)${NC}"
echo -e "  ${GREEN}[4]${NC} PHP 8.2 FPM    ${YELLOW}(Stable)${NC}"
echo -e "  ${GREEN}[5]${NC} PHP 8.3 FPM    ${YELLOW}(Stable - Recommended)${NC}"
echo -e "  ${GREEN}[6]${NC} PHP 8.4 FPM    ${YELLOW}(Latest)${NC}"
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${RED}[0]${NC} Kembali ke Menu Utama"
echo ""

echo -ne "  ${CYAN}Masukkan pilihan [0-6]: ${NC}"
read pilihan

case $pilihan in
    1)
        echo -e "\n${GREEN}[*] Memulai instalasi PHP 7.4 FPM...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/php/7.4-fpm.sh)"
        echo -e "\n${GREEN}[✓] PHP 7.4 FPM berhasil diinstall!${NC}"
        ;;
    2)
        echo -e "\n${GREEN}[*] Memulai instalasi PHP 8.0 FPM...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/php/8.0-fpm.sh)"
        echo -e "\n${GREEN}[✓] PHP 8.0 FPM berhasil diinstall!${NC}"
        ;;
    3)
        echo -e "\n${GREEN}[*] Memulai instalasi PHP 8.1 FPM...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/php/8.1-fpm.sh)"
        echo -e "\n${GREEN}[✓] PHP 8.1 FPM berhasil diinstall!${NC}"
        ;;
    4)
        echo -e "\n${GREEN}[*] Memulai instalasi PHP 8.2 FPM...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/php/8.2-fpm.sh)"
        echo -e "\n${GREEN}[✓] PHP 8.2 FPM berhasil diinstall!${NC}"
        ;;
    5)
        echo -e "\n${GREEN}[*] Memulai instalasi PHP 8.3 FPM...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/php/8.3-fpm.sh)"
        echo -e "\n${GREEN}[✓] PHP 8.3 FPM berhasil diinstall!${NC}"
        ;;
    6)
        echo -e "\n${GREEN}[*] Memulai instalasi PHP 8.4 FPM...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/php/8.4-fpm.sh)"
        echo -e "\n${GREEN}[✓] PHP 8.4 FPM berhasil diinstall!${NC}"
        ;;
    0)
        exit 0
        ;;
    *)
        echo -e "  ${RED}Pilihan tidak valid!${NC}"
        ;;
esac
