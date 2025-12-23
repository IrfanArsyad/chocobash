#!/bin/bash

# Warna
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

clear
echo -e "${CYAN}"
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║                      DISK USAGE                           ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo -e "${NC}"

echo -e "${YELLOW}>> Mounted Filesystems${NC}"
echo ""
df -h | head -1
echo "────────────────────────────────────────────────────────────"
df -h | tail -n +2 | while read line; do
    usage=$(echo $line | awk '{print $5}' | tr -d '%')
    if [ "$usage" -ge 90 ]; then
        echo -e "${RED}$line${NC}"
    elif [ "$usage" -ge 70 ]; then
        echo -e "${YELLOW}$line${NC}"
    else
        echo -e "${GREEN}$line${NC}"
    fi
done
echo ""

echo -e "${YELLOW}>> Largest Directories in /home${NC}"
echo ""
sudo du -sh /home/* 2>/dev/null | sort -rh | head -10
echo ""

echo -e "${YELLOW}>> Largest Directories in /var${NC}"
echo ""
sudo du -sh /var/* 2>/dev/null | sort -rh | head -10
echo ""
