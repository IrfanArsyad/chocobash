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
echo "  ║                   ${TITLE_SECURITY}                      ║"
echo "  ╚═══════════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo ""
echo -e "${YELLOW}  ${MSG_SELECT_SECURITY}${NC}"
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${WHITE}${CAT_FIREWALL}:${NC}"
echo -e "  ${GREEN}[1]${NC} UFW             ${YELLOW}(Uncomplicated Firewall)${NC}"
echo -e "  ${GREEN}[2]${NC} Firewalld       ${YELLOW}(Dynamic Firewall)${NC}"
echo ""
echo -e "  ${WHITE}${CAT_INTRUSION}:${NC}"
echo -e "  ${GREEN}[3]${NC} Fail2Ban        ${YELLOW}(Ban Malicious IPs)${NC}"
echo -e "  ${GREEN}[4]${NC} CrowdSec        ${YELLOW}(${LBL_MODERN} Security Engine)${NC}"
echo ""
echo -e "  ${WHITE}${CAT_SSL}:${NC}"
echo -e "  ${GREEN}[5]${NC} Certbot         ${YELLOW}(Let's Encrypt SSL)${NC}"
echo -e "  ${GREEN}[6]${NC} acme.sh         ${YELLOW}(ACME Client)${NC}"
echo ""
echo -e "  ${WHITE}${CAT_AUDIT}:${NC}"
echo -e "  ${GREEN}[7]${NC} Lynis           ${YELLOW}(Security Auditing)${NC}"
echo -e "  ${GREEN}[8]${NC} ClamAV          ${YELLOW}(Antivirus Scanner)${NC}"
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${RED}[0]${NC} ${MSG_BACK_MAIN}"
echo ""

echo -ne "  ${CYAN}${MSG_ENTER_CHOICE} [0-8]: ${NC}"
read pilihan

case $pilihan in
    1)
        echo -e "\n${GREEN}[*] ${MSG_START_INSTALL} UFW...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/security/ufw.sh)"
        ;;
    2)
        echo -e "\n${GREEN}[*] ${MSG_START_INSTALL} Firewalld...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/security/firewalld.sh)"
        ;;
    3)
        echo -e "\n${GREEN}[*] ${MSG_START_INSTALL} Fail2Ban...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/security/fail2ban.sh)"
        ;;
    4)
        echo -e "\n${GREEN}[*] ${MSG_START_INSTALL} CrowdSec...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/security/crowdsec.sh)"
        ;;
    5)
        echo -e "\n${GREEN}[*] ${MSG_START_INSTALL} Certbot...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/security/certbot.sh)"
        ;;
    6)
        echo -e "\n${GREEN}[*] ${MSG_START_INSTALL} acme.sh...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/security/acme.sh)"
        ;;
    7)
        echo -e "\n${GREEN}[*] ${MSG_START_INSTALL} Lynis...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/security/lynis.sh)"
        ;;
    8)
        echo -e "\n${GREEN}[*] ${MSG_START_INSTALL} ClamAV...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/security/clamav.sh)"
        ;;
    0)
        exit 0
        ;;
    *)
        echo -e "  ${RED}${MSG_INVALID_CHOICE}${NC}"
        ;;
esac
