#!/bin/bash

BASE_URL="https://raw.githubusercontent.com/IrfanArsyad/chocobash/main"
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
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║                    SYSTEM INFORMATION                     ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo -e "${NC}"

echo -e "${YELLOW}>> ${LBL_OS_INFO}${NC}"
echo -e "${WHITE}${LBL_HOSTNAME}${NC}       $(hostname)"
echo -e "${WHITE}${LBL_OS}${NC}             $(lsb_release -ds 2>/dev/null || cat /etc/os-release | grep PRETTY_NAME | cut -d'"' -f2)"
echo -e "${WHITE}${LBL_KERNEL}${NC}         $(uname -r)"
echo -e "${WHITE}Architecture:${NC}   $(uname -m)"
echo ""

echo -e "${YELLOW}>> ${LBL_HARDWARE}${NC}"
echo -e "${WHITE}${LBL_CPU}${NC}            $(grep 'model name' /proc/cpuinfo | head -1 | cut -d':' -f2 | xargs)"
echo -e "${WHITE}CPU Cores:${NC}      $(nproc)"
echo -e "${WHITE}${LBL_TOTAL_RAM}${NC}      $(free -h | awk '/^Mem:/ {print $2}')"
echo -e "${WHITE}${LBL_USED_RAM}${NC}       $(free -h | awk '/^Mem:/ {print $3}')"
echo -e "${WHITE}${LBL_FREE_RAM}${NC}       $(free -h | awk '/^Mem:/ {print $4}')"
echo ""

echo -e "${YELLOW}>> ${LBL_DISK_INFO}${NC}"
df -h / | tail -1 | awk '{print "Root Disk:      " $1 " - " $2 " total, " $3 " used, " $4 " free (" $5 " used)"}'
echo ""

echo -e "${YELLOW}>> ${LBL_NETWORK_INFO}${NC}"
echo -e "${WHITE}${LBL_IP_ADDRESS}${NC}     $(hostname -I | awk '{print $1}')"
echo -e "${WHITE}${LBL_PUBLIC_IP}${NC}      $(curl -s ifconfig.me 2>/dev/null || echo 'N/A')"
echo ""

echo -e "${YELLOW}>> ${LBL_UPTIME}${NC}"
uptime -p
echo ""
