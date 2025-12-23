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
echo "  ║                ${TITLE_DEVTOOLS}                ║"
echo "  ╚═══════════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo ""
echo -e "${YELLOW}  ${MSG_SELECT_DEVTOOLS}${NC}"
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${WHITE}${CAT_VERSION_CONTROL}:${NC}"
echo -e "  ${GREEN}[1]${NC} Git             ${YELLOW}(Version Control System)${NC}"
echo ""
echo -e "  ${WHITE}${CAT_PHP_TOOLS}:${NC}"
echo -e "  ${GREEN}[2]${NC} Composer        ${YELLOW}(PHP Package Manager)${NC}"
echo -e "  ${GREEN}[3]${NC} Laravel         ${YELLOW}(Laravel Installer)${NC}"
echo ""
echo -e "  ${WHITE}${CAT_JAVASCRIPT}:${NC}"
echo -e "  ${GREEN}[4]${NC} Node.js LTS     ${YELLOW}(JavaScript Runtime)${NC}"
echo -e "  ${GREEN}[5]${NC} Node.js Latest  ${YELLOW}(${LBL_LATEST})${NC}"
echo -e "  ${GREEN}[6]${NC} Yarn            ${YELLOW}(Package Manager)${NC}"
echo -e "  ${GREEN}[7]${NC} PNPM            ${YELLOW}(${LBL_FAST} Package Manager)${NC}"
echo -e "  ${GREEN}[8]${NC} Bun             ${YELLOW}(${LBL_FAST} JS Runtime & Toolkit)${NC}"
echo ""
echo -e "  ${WHITE}${CAT_PYTHON}:${NC}"
echo -e "  ${GREEN}[9]${NC} Python 3 + Pip  ${YELLOW}(Python Environment)${NC}"
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${RED}[0]${NC} ${MSG_BACK_MAIN}"
echo ""

echo -ne "  ${CYAN}${MSG_ENTER_CHOICE} [0-9]: ${NC}"
read pilihan

case $pilihan in
    1)
        echo -e "\n${GREEN}[*] ${MSG_START_INSTALL} Git...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/devtools/git.sh)"
        ;;
    2)
        echo -e "\n${GREEN}[*] ${MSG_START_INSTALL} Composer...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/devtools/composer.sh)"
        ;;
    3)
        echo -e "\n${GREEN}[*] ${MSG_START_INSTALL} Laravel Installer...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/devtools/laravel.sh)"
        ;;
    4)
        echo -e "\n${GREEN}[*] ${MSG_START_INSTALL} Node.js LTS...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/devtools/nodejs-lts.sh)"
        ;;
    5)
        echo -e "\n${GREEN}[*] ${MSG_START_INSTALL} Node.js Latest...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/devtools/nodejs-latest.sh)"
        ;;
    6)
        echo -e "\n${GREEN}[*] ${MSG_START_INSTALL} Yarn...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/devtools/yarn.sh)"
        ;;
    7)
        echo -e "\n${GREEN}[*] ${MSG_START_INSTALL} PNPM...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/devtools/pnpm.sh)"
        ;;
    8)
        echo -e "\n${GREEN}[*] ${MSG_START_INSTALL} Bun...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/devtools/bun.sh)"
        ;;
    9)
        echo -e "\n${GREEN}[*] ${MSG_START_INSTALL} Python 3...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/devtools/python.sh)"
        ;;
    0)
        exit 0
        ;;
    *)
        echo -e "  ${RED}${MSG_INVALID_CHOICE}${NC}"
        ;;
esac
