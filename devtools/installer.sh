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
echo "  ║                DEVELOPMENT TOOLS INSTALLER                ║"
echo "  ╚═══════════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo ""
echo -e "${YELLOW}  Pilih development tool yang ingin diinstall:${NC}"
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${WHITE}Version Control:${NC}"
echo -e "  ${GREEN}[1]${NC} Git             ${YELLOW}(Version Control System)${NC}"
echo ""
echo -e "  ${WHITE}PHP Development:${NC}"
echo -e "  ${GREEN}[2]${NC} Composer        ${YELLOW}(PHP Package Manager)${NC}"
echo -e "  ${GREEN}[3]${NC} Laravel         ${YELLOW}(Laravel Installer)${NC}"
echo ""
echo -e "  ${WHITE}JavaScript/Node.js:${NC}"
echo -e "  ${GREEN}[4]${NC} Node.js LTS     ${YELLOW}(JavaScript Runtime)${NC}"
echo -e "  ${GREEN}[5]${NC} Node.js Latest  ${YELLOW}(Latest Version)${NC}"
echo -e "  ${GREEN}[6]${NC} Yarn            ${YELLOW}(Package Manager)${NC}"
echo -e "  ${GREEN}[7]${NC} PNPM            ${YELLOW}(Fast Package Manager)${NC}"
echo -e "  ${GREEN}[8]${NC} Bun             ${YELLOW}(Fast JS Runtime & Toolkit)${NC}"
echo ""
echo -e "  ${WHITE}Python:${NC}"
echo -e "  ${GREEN}[9]${NC} Python 3 + Pip  ${YELLOW}(Python Environment)${NC}"
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${RED}[0]${NC} Kembali ke Menu Utama"
echo ""

echo -ne "  ${CYAN}Masukkan pilihan [0-9]: ${NC}"
read pilihan

case $pilihan in
    1)
        echo -e "\n${GREEN}[*] Memulai instalasi Git...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/devtools/git.sh)"
        ;;
    2)
        echo -e "\n${GREEN}[*] Memulai instalasi Composer...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/devtools/composer.sh)"
        ;;
    3)
        echo -e "\n${GREEN}[*] Memulai instalasi Laravel Installer...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/devtools/laravel.sh)"
        ;;
    4)
        echo -e "\n${GREEN}[*] Memulai instalasi Node.js LTS...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/devtools/nodejs-lts.sh)"
        ;;
    5)
        echo -e "\n${GREEN}[*] Memulai instalasi Node.js Latest...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/devtools/nodejs-latest.sh)"
        ;;
    6)
        echo -e "\n${GREEN}[*] Memulai instalasi Yarn...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/devtools/yarn.sh)"
        ;;
    7)
        echo -e "\n${GREEN}[*] Memulai instalasi PNPM...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/devtools/pnpm.sh)"
        ;;
    8)
        echo -e "\n${GREEN}[*] Memulai instalasi Bun...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/devtools/bun.sh)"
        ;;
    9)
        echo -e "\n${GREEN}[*] Memulai instalasi Python 3...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/devtools/python.sh)"
        ;;
    0)
        exit 0
        ;;
    *)
        echo -e "  ${RED}Pilihan tidak valid!${NC}"
        ;;
esac
