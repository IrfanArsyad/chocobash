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
echo "  ║                  ${TITLE_MONITORING}                     ║"
echo "  ╚═══════════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo ""
echo -e "${YELLOW}  ${MSG_SELECT_MONITORING}${NC}"
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${WHITE}${CAT_SYSTEM_MONITOR}:${NC}"
echo -e "  ${GREEN}[1]${NC} htop            ${YELLOW}(Interactive Process Viewer)${NC}"
echo -e "  ${GREEN}[2]${NC} btop            ${YELLOW}(${LBL_MODERN} Resource Monitor)${NC}"
echo -e "  ${GREEN}[3]${NC} glances         ${YELLOW}(System Monitoring Tool)${NC}"
echo ""
echo -e "  ${WHITE}${CAT_METRICS}:${NC}"
echo -e "  ${GREEN}[4]${NC} Netdata         ${YELLOW}(Real-Time Performance)${NC}"
echo -e "  ${GREEN}[5]${NC} Grafana         ${YELLOW}(Analytics Dashboard)${NC}"
echo -e "  ${GREEN}[6]${NC} Prometheus      ${YELLOW}(Metrics Collection)${NC}"
echo ""
echo -e "  ${WHITE}${CAT_LOGGING}:${NC}"
echo -e "  ${GREEN}[7]${NC} GoAccess        ${YELLOW}(Web Log Analyzer)${NC}"
echo -e "  ${GREEN}[8]${NC} Loki            ${YELLOW}(Log Aggregation)${NC}"
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${RED}[0]${NC} ${MSG_BACK_MAIN}"
echo ""

echo -ne "  ${CYAN}${MSG_ENTER_CHOICE} [0-8]: ${NC}"
read pilihan

case $pilihan in
    1)
        echo -e "\n${GREEN}[*] ${MSG_START_INSTALL} htop...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/monitoring/htop.sh)"
        ;;
    2)
        echo -e "\n${GREEN}[*] ${MSG_START_INSTALL} btop...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/monitoring/btop.sh)"
        ;;
    3)
        echo -e "\n${GREEN}[*] ${MSG_START_INSTALL} glances...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/monitoring/glances.sh)"
        ;;
    4)
        echo -e "\n${GREEN}[*] ${MSG_START_INSTALL} Netdata...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/monitoring/netdata.sh)"
        ;;
    5)
        echo -e "\n${GREEN}[*] ${MSG_START_INSTALL} Grafana...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/monitoring/grafana.sh)"
        ;;
    6)
        echo -e "\n${GREEN}[*] ${MSG_START_INSTALL} Prometheus...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/monitoring/prometheus.sh)"
        ;;
    7)
        echo -e "\n${GREEN}[*] ${MSG_START_INSTALL} GoAccess...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/monitoring/goaccess.sh)"
        ;;
    8)
        echo -e "\n${GREEN}[*] ${MSG_START_INSTALL} Loki...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/monitoring/loki.sh)"
        ;;
    0)
        exit 0
        ;;
    *)
        echo -e "  ${RED}${MSG_INVALID_CHOICE}${NC}"
        ;;
esac
