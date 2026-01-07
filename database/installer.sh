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
echo "  ║                   ${TITLE_DATABASE}                      ║"
echo "  ╚═══════════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo ""
echo -e "${YELLOW}  ${MSG_SELECT_DATABASE}${NC}"
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${WHITE}${CAT_SQL}:${NC}"
echo -e "  ${GREEN}[1]${NC} MySQL 8.0       ${YELLOW}(Oracle MySQL)${NC}"
echo -e "  ${GREEN}[2]${NC} MariaDB         ${YELLOW}(MySQL Fork - Recommended)${NC}"
echo -e "  ${GREEN}[3]${NC} PostgreSQL      ${YELLOW}(Advanced SQL Database)${NC}"
echo ""
echo -e "  ${WHITE}${CAT_NOSQL}:${NC}"
echo -e "  ${GREEN}[4]${NC} MongoDB         ${YELLOW}(Document Database)${NC}"
echo -e "  ${GREEN}[5]${NC} Redis           ${YELLOW}(In-Memory Cache & DB)${NC}"
echo -e "  ${GREEN}[6]${NC} Memcached       ${YELLOW}(High-Performance Cache)${NC}"
echo ""
echo -e "  ${WHITE}${CAT_DB_TOOLS}:${NC}"
echo -e "  ${GREEN}[7]${NC} ${MSG_PGSQL_SETUP}  ${YELLOW}(${DESC_PGSQL_SETUP})${NC}"
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${RED}[0]${NC} ${MSG_BACK_MAIN}"
echo ""

echo -ne "  ${CYAN}${MSG_ENTER_CHOICE} [0-7]: ${NC}"
read pilihan

case $pilihan in
    1)
        echo -e "\n${GREEN}[*] ${MSG_START_INSTALL} MySQL 8.0...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/database/mysql.sh)"
        ;;
    2)
        echo -e "\n${GREEN}[*] ${MSG_START_INSTALL} MariaDB...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/database/mariadb.sh)"
        ;;
    3)
        echo -e "\n${GREEN}[*] ${MSG_START_INSTALL} PostgreSQL...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/database/postgresql.sh)"
        ;;
    4)
        echo -e "\n${GREEN}[*] ${MSG_START_INSTALL} MongoDB...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/database/mongodb.sh)"
        ;;
    5)
        echo -e "\n${GREEN}[*] ${MSG_START_INSTALL} Redis...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/database/redis.sh)"
        ;;
    6)
        echo -e "\n${GREEN}[*] ${MSG_START_INSTALL} Memcached...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/database/memcached.sh)"
        ;;
    7)
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/database/postgresql_setup.sh | tr -d '\r')"
        ;;
    0)
        exit 0
        ;;
    *)
        echo -e "  ${RED}${MSG_INVALID_CHOICE}${NC}"
        ;;
esac
