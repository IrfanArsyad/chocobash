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

clear
echo -e "${CYAN}"
echo "  ╔═══════════════════════════════════════════════════════════╗"
echo "  ║                     ${TITLE_PHP}                         ║"
echo "  ╚═══════════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo ""
echo -e "${YELLOW}  ${MSG_SELECT_PHP}${NC}"
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${GREEN}[1]${NC} PHP 7.4 FPM    ${YELLOW}(${LBL_LEGACY})${NC}"
echo -e "  ${GREEN}[2]${NC} PHP 8.0 FPM    ${YELLOW}(${LBL_EOL})${NC}"
echo -e "  ${GREEN}[3]${NC} PHP 8.1 FPM    ${YELLOW}(${LBL_SECURITY})${NC}"
echo -e "  ${GREEN}[4]${NC} PHP 8.2 FPM    ${YELLOW}(${LBL_STABLE})${NC}"
echo -e "  ${GREEN}[5]${NC} PHP 8.3 FPM    ${YELLOW}(${LBL_RECOMMENDED})${NC}"
echo -e "  ${GREEN}[6]${NC} PHP 8.4 FPM    ${YELLOW}(${LBL_LATEST})${NC}"
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${RED}[0]${NC} ${MSG_BACK_MAIN}"
echo ""

echo -ne "  ${CYAN}${MSG_ENTER_CHOICE} [0-6]: ${NC}"
read pilihan

case $pilihan in
    1)
        echo -e "\n${GREEN}[*] ${MSG_START_INSTALL} PHP 7.4 FPM...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/php/7.4-fpm.sh)"
        echo -e "\n${GREEN}[✓] PHP 7.4 FPM ${MSG_SUCCESS}${NC}"
        ;;
    2)
        echo -e "\n${GREEN}[*] ${MSG_START_INSTALL} PHP 8.0 FPM...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/php/8.0-fpm.sh)"
        echo -e "\n${GREEN}[✓] PHP 8.0 FPM ${MSG_SUCCESS}${NC}"
        ;;
    3)
        echo -e "\n${GREEN}[*] ${MSG_START_INSTALL} PHP 8.1 FPM...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/php/8.1-fpm.sh)"
        echo -e "\n${GREEN}[✓] PHP 8.1 FPM ${MSG_SUCCESS}${NC}"
        ;;
    4)
        echo -e "\n${GREEN}[*] ${MSG_START_INSTALL} PHP 8.2 FPM...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/php/8.2-fpm.sh)"
        echo -e "\n${GREEN}[✓] PHP 8.2 FPM ${MSG_SUCCESS}${NC}"
        ;;
    5)
        echo -e "\n${GREEN}[*] ${MSG_START_INSTALL} PHP 8.3 FPM...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/php/8.3-fpm.sh)"
        echo -e "\n${GREEN}[✓] PHP 8.3 FPM ${MSG_SUCCESS}${NC}"
        ;;
    6)
        echo -e "\n${GREEN}[*] ${MSG_START_INSTALL} PHP 8.4 FPM...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/php/8.4-fpm.sh)"
        echo -e "\n${GREEN}[✓] PHP 8.4 FPM ${MSG_SUCCESS}${NC}"
        ;;
    0)
        exit 0
        ;;
    *)
        echo -e "  ${RED}${MSG_INVALID_CHOICE}${NC}"
        ;;
esac
