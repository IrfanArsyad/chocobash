#!/bin/bash

# Warna
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
WHITE='\033[1;37m'
NC='\033[0m'

clear
echo -e "${CYAN}"
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║                   NETWORK INFORMATION                     ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo -e "${NC}"

echo -e "${YELLOW}>> Network Interfaces${NC}"
echo ""
ip -brief address
echo ""

echo -e "${YELLOW}>> Default Gateway${NC}"
ip route | grep default
echo ""

echo -e "${YELLOW}>> DNS Servers${NC}"
cat /etc/resolv.conf | grep nameserver
echo ""

echo -e "${YELLOW}>> Public IP${NC}"
echo -e "${WHITE}IPv4:${NC} $(curl -s -4 ifconfig.me 2>/dev/null || echo 'N/A')"
echo -e "${WHITE}IPv6:${NC} $(curl -s -6 ifconfig.me 2>/dev/null || echo 'N/A')"
echo ""

echo -e "${YELLOW}>> Listening Ports${NC}"
echo ""
sudo ss -tulpn | head -20
echo ""
