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

# Utility descriptions based on language
if [ "$CHOCO_LANG" = "en" ]; then
    DESC_SYSINFO="Show System Information"
    DESC_DISKUSAGE="Show Disk Usage"
    DESC_NETINFO="Show Network Information"
    DESC_UPDATE="Update & Upgrade Packages"
    DESC_CLEANUP="Clean Cache & Temp Files"
    DESC_FIXPERM="Fix Web Permissions"
    DESC_ESSENTIALS="curl, wget, unzip, etc"
    DESC_SWAP="Create Swap File"
    DESC_TIMEZONE="Set Timezone"
    MSG_SHOWING="Showing"
    MSG_STARTING="Starting"
    MSG_CREATING="Creating"
    MSG_SETTING="Setting"
    MSG_FIXING="Fixing"
    MSG_INSTALLING_TOOLS="Installing Essential Tools"
else
    DESC_SYSINFO="Tampilkan Informasi Sistem"
    DESC_DISKUSAGE="Tampilkan Penggunaan Disk"
    DESC_NETINFO="Tampilkan Informasi Jaringan"
    DESC_UPDATE="Update & Upgrade Packages"
    DESC_CLEANUP="Bersihkan Cache & Temp Files"
    DESC_FIXPERM="Perbaiki Permission Web"
    DESC_ESSENTIALS="curl, wget, unzip, dll"
    DESC_SWAP="Buat Swap File"
    DESC_TIMEZONE="Atur Timezone"
    MSG_SHOWING="Menampilkan"
    MSG_STARTING="Memulai"
    MSG_CREATING="Membuat"
    MSG_SETTING="Mengatur"
    MSG_FIXING="Memperbaiki"
    MSG_INSTALLING_TOOLS="Menginstall Essential Tools"
fi

clear
echo -e "${CYAN}"
echo "  ╔═══════════════════════════════════════════════════════════╗"
echo "  ║                   ${TITLE_UTILITIES}                        ║"
echo "  ╚═══════════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo ""
echo -e "${YELLOW}  ${MSG_SELECT_UTILITIES}${NC}"
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${WHITE}${CAT_SYSTEM_INFO}:${NC}"
echo -e "  ${GREEN}[1]${NC} System Info     ${YELLOW}(${DESC_SYSINFO})${NC}"
echo -e "  ${GREEN}[2]${NC} Disk Usage      ${YELLOW}(${DESC_DISKUSAGE})${NC}"
echo -e "  ${GREEN}[3]${NC} Network Info    ${YELLOW}(${DESC_NETINFO})${NC}"
echo ""
echo -e "  ${WHITE}${CAT_MAINTENANCE}:${NC}"
echo -e "  ${GREEN}[4]${NC} Update System   ${YELLOW}(${DESC_UPDATE})${NC}"
echo -e "  ${GREEN}[5]${NC} Cleanup         ${YELLOW}(${DESC_CLEANUP})${NC}"
echo -e "  ${GREEN}[6]${NC} Fix Permissions ${YELLOW}(${DESC_FIXPERM})${NC}"
echo ""
echo -e "  ${WHITE}${CAT_CONFIGURATION}:${NC}"
echo -e "  ${GREEN}[7]${NC} Install Essentials  ${YELLOW}(${DESC_ESSENTIALS})${NC}"
echo -e "  ${GREEN}[8]${NC} Create Swap         ${YELLOW}(${DESC_SWAP})${NC}"
echo -e "  ${GREEN}[9]${NC} Set Timezone        ${YELLOW}(${DESC_TIMEZONE})${NC}"
echo ""
echo -e "  ${WHITE}Analysis Tools:${NC}"
echo -e "  ${GREEN}[10]${NC} Disk Analysis      ${YELLOW}(${DESC_DISKANALYSIS})${NC}"
echo -e "  ${GREEN}[11]${NC} Smart Cleanup      ${YELLOW}(${DESC_SMARTCLEANUP})${NC}"
echo ""
echo -e "  ${WHITE}Network Tools:${NC}"
echo -e "  ${GREEN}[12]${NC} Latency Check            ${YELLOW}(${DESC_LATENCY})${NC}"
echo -e "  ${GREEN}[13]${NC} DB Connection Test       ${YELLOW}(Test koneksi database cross-country)${NC}"
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${RED}[0]${NC} ${MSG_BACK_MAIN}"
echo ""

echo -ne "  ${CYAN}${MSG_ENTER_CHOICE} [0-13]: ${NC}"
read pilihan

case $pilihan in
    1)
        echo -e "\n${GREEN}[*] ${MSG_SHOWING} System Info...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/utilities/sysinfo.sh)"
        ;;
    2)
        echo -e "\n${GREEN}[*] ${MSG_SHOWING} Disk Usage...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/utilities/diskusage.sh)"
        ;;
    3)
        echo -e "\n${GREEN}[*] ${MSG_SHOWING} Network Info...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/utilities/netinfo.sh)"
        ;;
    4)
        echo -e "\n${GREEN}[*] ${MSG_STARTING} Update System...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/utilities/update.sh)"
        ;;
    5)
        echo -e "\n${GREEN}[*] ${MSG_STARTING} Cleanup...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/utilities/cleanup.sh)"
        ;;
    6)
        echo -e "\n${GREEN}[*] ${MSG_FIXING} Permissions...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/utilities/fix-permissions.sh)"
        ;;
    7)
        echo -e "\n${GREEN}[*] ${MSG_INSTALLING_TOOLS}...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/utilities/essentials.sh)"
        ;;
    8)
        echo -e "\n${GREEN}[*] ${MSG_CREATING} Swap File...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/utilities/swap.sh)"
        ;;
    9)
        echo -e "\n${GREEN}[*] ${MSG_SETTING} Timezone...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/utilities/timezone.sh)"
        ;;
    10)
        echo -e "\n${GREEN}[*] ${MSG_ANALYZING} Disk...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/utilities/diskanalysis.sh)"
        ;;
    11)
        echo -e "\n${GREEN}[*] ${MSG_STARTING} Smart Cleanup...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/utilities/smart-cleanup.sh)"
        ;;
    12)
        echo -e "\n${GREEN}[*] ${MSG_STARTING} Latency Check...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/utilities/latency-check.sh)"
        ;;
    13)
        echo -e "\n${GREEN}[*] ${MSG_STARTING} Database Connection Test...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/utilities/db-connection-test.sh)"
        ;;
    0)
        exit 0
        ;;
    *)
        echo -e "  ${RED}${MSG_INVALID_CHOICE}${NC}"
        ;;
esac
