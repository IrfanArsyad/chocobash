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
echo "  ║                   DATABASE INSTALLER                      ║"
echo "  ╚═══════════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo ""
echo -e "${YELLOW}  Pilih database yang ingin diinstall:${NC}"
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${WHITE}SQL Database:${NC}"
echo -e "  ${GREEN}[1]${NC} MySQL 8.0       ${YELLOW}(Oracle MySQL)${NC}"
echo -e "  ${GREEN}[2]${NC} MariaDB         ${YELLOW}(MySQL Fork - Recommended)${NC}"
echo -e "  ${GREEN}[3]${NC} PostgreSQL      ${YELLOW}(Advanced SQL Database)${NC}"
echo ""
echo -e "  ${WHITE}NoSQL Database:${NC}"
echo -e "  ${GREEN}[4]${NC} MongoDB         ${YELLOW}(Document Database)${NC}"
echo -e "  ${GREEN}[5]${NC} Redis           ${YELLOW}(In-Memory Cache & DB)${NC}"
echo -e "  ${GREEN}[6]${NC} Memcached       ${YELLOW}(High-Performance Cache)${NC}"
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${RED}[0]${NC} Kembali ke Menu Utama"
echo ""

echo -ne "  ${CYAN}Masukkan pilihan [0-6]: ${NC}"
read pilihan

case $pilihan in
    1)
        echo -e "\n${GREEN}[*] Memulai instalasi MySQL 8.0...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/database/mysql.sh)"
        ;;
    2)
        echo -e "\n${GREEN}[*] Memulai instalasi MariaDB...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/database/mariadb.sh)"
        ;;
    3)
        echo -e "\n${GREEN}[*] Memulai instalasi PostgreSQL...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/database/postgresql.sh)"
        ;;
    4)
        echo -e "\n${GREEN}[*] Memulai instalasi MongoDB...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/database/mongodb.sh)"
        ;;
    5)
        echo -e "\n${GREEN}[*] Memulai instalasi Redis...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/database/redis.sh)"
        ;;
    6)
        echo -e "\n${GREEN}[*] Memulai instalasi Memcached...${NC}\n"
        bash -c "$(wget -qLO - ${BASE_URL}/database/memcached.sh)"
        ;;
    0)
        exit 0
        ;;
    *)
        echo -e "  ${RED}Pilihan tidak valid!${NC}"
        ;;
esac
