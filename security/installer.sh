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
echo "  ║                   SECURITY INSTALLER                      ║"
echo "  ╚═══════════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo ""
echo -e "${YELLOW}  Pilih security tool yang ingin diinstall:${NC}"
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${WHITE}Firewall:${NC}"
echo -e "  ${GREEN}[1]${NC} UFW             ${YELLOW}(Uncomplicated Firewall)${NC}"
echo -e "  ${GREEN}[2]${NC} Firewalld       ${YELLOW}(Dynamic Firewall)${NC}"
echo ""
echo -e "  ${WHITE}Intrusion Prevention:${NC}"
echo -e "  ${GREEN}[3]${NC} Fail2Ban        ${YELLOW}(Ban Malicious IPs)${NC}"
echo -e "  ${GREEN}[4]${NC} CrowdSec        ${YELLOW}(Modern Security Engine)${NC}"
echo ""
echo -e "  ${WHITE}SSL/TLS:${NC}"
echo -e "  ${GREEN}[5]${NC} Certbot         ${YELLOW}(Let's Encrypt SSL)${NC}"
echo -e "  ${GREEN}[6]${NC} acme.sh         ${YELLOW}(ACME Client)${NC}"
echo ""
echo -e "  ${WHITE}Security Audit:${NC}"
echo -e "  ${GREEN}[7]${NC} Lynis           ${YELLOW}(Security Auditing)${NC}"
echo -e "  ${GREEN}[8]${NC} ClamAV          ${YELLOW}(Antivirus Scanner)${NC}"
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${RED}[0]${NC} Kembali ke Menu Utama"
echo ""

echo -ne "  ${CYAN}Masukkan pilihan [0-8]: ${NC}"
read pilihan

case $pilihan in
    1)
        echo -e "\n${GREEN}[*] Memulai instalasi UFW...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/security/ufw.sh)"
        ;;
    2)
        echo -e "\n${GREEN}[*] Memulai instalasi Firewalld...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/security/firewalld.sh)"
        ;;
    3)
        echo -e "\n${GREEN}[*] Memulai instalasi Fail2Ban...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/security/fail2ban.sh)"
        ;;
    4)
        echo -e "\n${GREEN}[*] Memulai instalasi CrowdSec...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/security/crowdsec.sh)"
        ;;
    5)
        echo -e "\n${GREEN}[*] Memulai instalasi Certbot...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/security/certbot.sh)"
        ;;
    6)
        echo -e "\n${GREEN}[*] Memulai instalasi acme.sh...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/security/acme.sh)"
        ;;
    7)
        echo -e "\n${GREEN}[*] Memulai instalasi Lynis...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/security/lynis.sh)"
        ;;
    8)
        echo -e "\n${GREEN}[*] Memulai instalasi ClamAV...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/security/clamav.sh)"
        ;;
    0)
        exit 0
        ;;
    *)
        echo -e "  ${RED}Pilihan tidak valid!${NC}"
        ;;
esac
