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
PURPLE='\033[0;35m'
NC='\033[0m'

# Uninstall descriptions based on language
if [ "$CHOCO_LANG" = "en" ]; then
    DESC_LIST_APPS="List all safe-to-remove applications"
    DESC_UNINSTALL_SELECT="Select and uninstall applications"
    DESC_AUTOREMOVE="Remove unused dependencies"
    MSG_SCANNING="Scanning installed applications..."
    MSG_SAFE_APPS="Applications safe to uninstall"
    MSG_SELECT_UNINSTALL="Select applications to uninstall"
    MSG_NO_APPS="No applications found"
    MSG_UNINSTALLING="Uninstalling"
    MSG_UNINSTALL_DONE="Uninstall complete!"
    MSG_AUTOREMOVE_DONE="Autoremove complete!"
    MSG_SELECTED="selected"
    MSG_TOGGLE="Toggle selection"
    MSG_CONFIRM_UNINSTALL="Confirm uninstall?"
    MSG_CANCELLED="Operation cancelled"
    MSG_PAGE="Page"
    MSG_OF="of"
    MSG_NEXT="Next page"
    MSG_PREV="Previous page"
    MSG_SEARCH="Search"
    MSG_ENTER_SEARCH="Enter search term"
    MSG_CLEAR_SEARCH="Clear search"
    MSG_RESULTS="results"
else
    DESC_LIST_APPS="Lihat daftar aplikasi yang aman di-uninstall"
    DESC_UNINSTALL_SELECT="Pilih dan uninstall aplikasi"
    DESC_AUTOREMOVE="Hapus dependencies yang tidak terpakai"
    MSG_SCANNING="Memindai aplikasi terinstall..."
    MSG_SAFE_APPS="Aplikasi aman untuk di-uninstall"
    MSG_SELECT_UNINSTALL="Pilih aplikasi untuk di-uninstall"
    MSG_NO_APPS="Tidak ada aplikasi ditemukan"
    MSG_UNINSTALLING="Menghapus"
    MSG_UNINSTALL_DONE="Uninstall selesai!"
    MSG_AUTOREMOVE_DONE="Autoremove selesai!"
    MSG_SELECTED="dipilih"
    MSG_TOGGLE="Toggle pilihan"
    MSG_CONFIRM_UNINSTALL="Konfirmasi uninstall?"
    MSG_CANCELLED="Operasi dibatalkan"
    MSG_PAGE="Halaman"
    MSG_OF="dari"
    MSG_NEXT="Halaman berikutnya"
    MSG_PREV="Halaman sebelumnya"
    MSG_SEARCH="Cari"
    MSG_ENTER_SEARCH="Masukkan kata kunci"
    MSG_CLEAR_SEARCH="Hapus pencarian"
    MSG_RESULTS="hasil"
fi

clear
echo -e "${CYAN}"
echo "  ╔═══════════════════════════════════════════════════════════╗"
echo "  ║               ${TITLE_UNINSTALL}                          ║"
echo "  ╚═══════════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo ""
echo -e "${YELLOW}  ${MSG_SELECT_UNINSTALL_MENU}${NC}"
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${GREEN}[1]${NC} ${WHITE}${MSG_UNINSTALL_INTERACTIVE}${NC}"
echo -e "      ${YELLOW}(${DESC_UNINSTALL_SELECT})${NC}"
echo ""
echo -e "  ${GREEN}[2]${NC} ${WHITE}${MSG_UNINSTALL_LIST}${NC}"
echo -e "      ${YELLOW}(${DESC_LIST_APPS})${NC}"
echo ""
echo -e "  ${GREEN}[3]${NC} ${WHITE}Autoremove${NC}"
echo -e "      ${YELLOW}(${DESC_AUTOREMOVE})${NC}"
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${RED}[0]${NC} ${MSG_BACK_MAIN}"
echo ""

echo -ne "  ${CYAN}${MSG_ENTER_CHOICE} [0-3]: ${NC}"
read pilihan

case $pilihan in
    1)
        echo -e "\n${GREEN}[*] ${MSG_SCANNING}${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/uninstall/uninstall-interactive.sh)"
        ;;
    2)
        echo -e "\n${GREEN}[*] ${MSG_SCANNING}${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/uninstall/list-safe-apps.sh)"
        ;;
    3)
        echo -e "\n${GREEN}[*] ${MSG_REMOVING} unused packages...${NC}\n"
        sudo apt autoremove -y
        echo -e "\n${GREEN}[✓] ${MSG_AUTOREMOVE_DONE}${NC}\n"
        ;;
    0)
        exit 0
        ;;
    *)
        echo -e "  ${RED}${MSG_INVALID_CHOICE}${NC}"
        ;;
esac
