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
echo "  ║                  MONITORING INSTALLER                     ║"
echo "  ╚═══════════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo ""
echo -e "${YELLOW}  Pilih monitoring tool yang ingin diinstall:${NC}"
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${WHITE}System Monitoring:${NC}"
echo -e "  ${GREEN}[1]${NC} htop            ${YELLOW}(Interactive Process Viewer)${NC}"
echo -e "  ${GREEN}[2]${NC} btop            ${YELLOW}(Modern Resource Monitor)${NC}"
echo -e "  ${GREEN}[3]${NC} glances         ${YELLOW}(System Monitoring Tool)${NC}"
echo ""
echo -e "  ${WHITE}Real-Time Dashboard:${NC}"
echo -e "  ${GREEN}[4]${NC} Netdata         ${YELLOW}(Real-Time Performance)${NC}"
echo -e "  ${GREEN}[5]${NC} Grafana         ${YELLOW}(Analytics Dashboard)${NC}"
echo -e "  ${GREEN}[6]${NC} Prometheus      ${YELLOW}(Metrics Collection)${NC}"
echo ""
echo -e "  ${WHITE}Log Management:${NC}"
echo -e "  ${GREEN}[7]${NC} GoAccess        ${YELLOW}(Web Log Analyzer)${NC}"
echo -e "  ${GREEN}[8]${NC} Loki            ${YELLOW}(Log Aggregation)${NC}"
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${RED}[0]${NC} Kembali ke Menu Utama"
echo ""

echo -ne "  ${CYAN}Masukkan pilihan [0-8]: ${NC}"
read pilihan

case $pilihan in
    1)
        echo -e "\n${GREEN}[*] Memulai instalasi htop...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/monitoring/htop.sh)"
        ;;
    2)
        echo -e "\n${GREEN}[*] Memulai instalasi btop...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/monitoring/btop.sh)"
        ;;
    3)
        echo -e "\n${GREEN}[*] Memulai instalasi glances...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/monitoring/glances.sh)"
        ;;
    4)
        echo -e "\n${GREEN}[*] Memulai instalasi Netdata...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/monitoring/netdata.sh)"
        ;;
    5)
        echo -e "\n${GREEN}[*] Memulai instalasi Grafana...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/monitoring/grafana.sh)"
        ;;
    6)
        echo -e "\n${GREEN}[*] Memulai instalasi Prometheus...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/monitoring/prometheus.sh)"
        ;;
    7)
        echo -e "\n${GREEN}[*] Memulai instalasi GoAccess...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/monitoring/goaccess.sh)"
        ;;
    8)
        echo -e "\n${GREEN}[*] Memulai instalasi Loki...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/monitoring/loki.sh)"
        ;;
    0)
        exit 0
        ;;
    *)
        echo -e "  ${RED}Pilihan tidak valid!${NC}"
        ;;
esac
