#!/bin/bash

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

echo -e "${YELLOW}>> OS Information${NC}"
echo -e "${WHITE}Hostname:${NC}       $(hostname)"
echo -e "${WHITE}OS:${NC}             $(lsb_release -ds 2>/dev/null || cat /etc/os-release | grep PRETTY_NAME | cut -d'"' -f2)"
echo -e "${WHITE}Kernel:${NC}         $(uname -r)"
echo -e "${WHITE}Architecture:${NC}   $(uname -m)"
echo ""

echo -e "${YELLOW}>> Hardware Information${NC}"
echo -e "${WHITE}CPU:${NC}            $(grep 'model name' /proc/cpuinfo | head -1 | cut -d':' -f2 | xargs)"
echo -e "${WHITE}CPU Cores:${NC}      $(nproc)"
echo -e "${WHITE}Total RAM:${NC}      $(free -h | awk '/^Mem:/ {print $2}')"
echo -e "${WHITE}Used RAM:${NC}       $(free -h | awk '/^Mem:/ {print $3}')"
echo -e "${WHITE}Free RAM:${NC}       $(free -h | awk '/^Mem:/ {print $4}')"
echo ""

echo -e "${YELLOW}>> Disk Information${NC}"
df -h / | tail -1 | awk '{print "Root Disk:      " $1 " - " $2 " total, " $3 " used, " $4 " free (" $5 " used)"}'
echo ""

echo -e "${YELLOW}>> Network Information${NC}"
echo -e "${WHITE}IP Address:${NC}     $(hostname -I | awk '{print $1}')"
echo -e "${WHITE}Public IP:${NC}      $(curl -s ifconfig.me 2>/dev/null || echo 'N/A')"
echo ""

echo -e "${YELLOW}>> Uptime${NC}"
uptime -p
echo ""
