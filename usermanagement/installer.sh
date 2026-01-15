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

# User Management descriptions based on language
if [ "$CHOCO_LANG" = "en" ]; then
    DESC_CREATE_USER="Create New User"
    DESC_LIST_USERS="List All Users"
    DESC_DELETE_USER="Delete User"
    DESC_MODIFY_USER="Modify User (add/remove sudo)"
    MSG_LISTING="Listing"
    MSG_DELETING="Deleting"
    MSG_MODIFYING="Modifying"
else
    DESC_CREATE_USER="Buat User Baru"
    DESC_LIST_USERS="Lihat Daftar User"
    DESC_DELETE_USER="Hapus User"
    DESC_MODIFY_USER="Ubah User (tambah/hapus sudo)"
    MSG_LISTING="Menampilkan"
    MSG_DELETING="Menghapus"
    MSG_MODIFYING="Mengubah"
fi

clear
echo -e "${CYAN}"
echo "  ╔═══════════════════════════════════════════════════════════╗"
echo "  ║              ${TITLE_USERMANAGEMENT}                      ║"
echo "  ╚═══════════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo ""
echo -e "${YELLOW}  ${MSG_SELECT_USERMANAGEMENT}${NC}"
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${GREEN}[1]${NC} ${MSG_CREATE_USER}       ${YELLOW}(${DESC_CREATE_USER})${NC}"
echo -e "  ${GREEN}[2]${NC} ${MSG_LIST_USERS}        ${YELLOW}(${DESC_LIST_USERS})${NC}"
echo -e "  ${GREEN}[3]${NC} ${MSG_DELETE_USER}       ${YELLOW}(${DESC_DELETE_USER})${NC}"
echo -e "  ${GREEN}[4]${NC} ${MSG_MODIFY_USER}       ${YELLOW}(${DESC_MODIFY_USER})${NC}"
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${RED}[0]${NC} ${MSG_BACK_MAIN}"
echo ""

echo -ne "  ${CYAN}${MSG_ENTER_CHOICE} [0-4]: ${NC}"
read pilihan

case $pilihan in
    1)
        echo -e "\n${GREEN}[*] ${MSG_CREATING} User...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/usermanagement/create-user.sh)"
        ;;
    2)
        echo -e "\n${GREEN}[*] ${MSG_LISTING} Users...${NC}\n"
        echo -e "${WHITE}System Users:${NC}"
        echo ""
        # List users with UID >= 1000 (regular users)
        echo -e "${CYAN}Username        UID    Groups${NC}"
        echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        awk -F: '$3 >= 1000 && $1 != "nobody" {printf "%-15s %-6s %s\n", $1, $3, $1}' /etc/passwd | while read user uid name; do
            groups=$(groups $user 2>/dev/null | cut -d: -f2)
            printf "${WHITE}%-15s${NC} ${YELLOW}%-6s${NC} ${GREEN}%s${NC}\n" "$user" "$uid" "$groups"
        done
        echo ""
        ;;
    3)
        echo -e "\n${GREEN}[*] ${MSG_DELETING} User...${NC}\n"

        # Check if running as root
        if [ "$EUID" -ne 0 ]; then
            echo -e "${RED}[!] ${MSG_NEED_ROOT}${NC}"
            exit 1
        fi

        # List users
        echo -e "${WHITE}Available Users:${NC}"
        awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd
        echo ""

        echo -e "${YELLOW}${MSG_ENTER_USERNAME}:${NC}"
        echo -ne "${CYAN}> ${NC}"
        read USERNAME

        if [ -z "$USERNAME" ]; then
            echo -e "${RED}[!] ${MSG_USERNAME_REQUIRED}${NC}"
            exit 1
        fi

        # Check if user exists
        if ! id "$USERNAME" &>/dev/null; then
            echo -e "${RED}[!] ${MSG_USER_NOT_FOUND}: $USERNAME${NC}"
            exit 1
        fi

        # Confirm deletion
        echo ""
        echo -e "${YELLOW}${MSG_DELETE_CONFIRM} $USERNAME?${NC}"
        echo -e "${RED}${MSG_DELETE_WARNING}${NC}"
        echo -e "${GREEN}[1]${NC} ${MSG_YES}"
        echo -e "${GREEN}[2]${NC} ${MSG_NO}"
        echo -ne "${CYAN}${MSG_ENTER_CHOICE} [1-2]: ${NC}"
        read CONFIRM

        if [ "$CONFIRM" = "1" ]; then
            # Delete user and home directory
            userdel -r "$USERNAME" 2>/dev/null
            echo -e "${GREEN}[✓] ${MSG_USER_DELETED}: $USERNAME${NC}"
        else
            echo -e "${YELLOW}[*] ${MSG_PGSQL_CANCELLED}${NC}"
        fi
        ;;
    4)
        echo -e "\n${GREEN}[*] ${MSG_MODIFYING} User...${NC}\n"

        # Check if running as root
        if [ "$EUID" -ne 0 ]; then
            echo -e "${RED}[!] ${MSG_NEED_ROOT}${NC}"
            exit 1
        fi

        # List users
        echo -e "${WHITE}Available Users:${NC}"
        awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd
        echo ""

        echo -e "${YELLOW}${MSG_ENTER_USERNAME}:${NC}"
        echo -ne "${CYAN}> ${NC}"
        read USERNAME

        if [ -z "$USERNAME" ]; then
            echo -e "${RED}[!] ${MSG_USERNAME_REQUIRED}${NC}"
            exit 1
        fi

        # Check if user exists
        if ! id "$USERNAME" &>/dev/null; then
            echo -e "${RED}[!] ${MSG_USER_NOT_FOUND}: $USERNAME${NC}"
            exit 1
        fi

        # Check if user has sudo
        if groups "$USERNAME" | grep -q "\bsudo\b"; then
            HAS_SUDO=true
            echo -e "${CYAN}User $USERNAME ${MSG_HAS_SUDO}${NC}"
            echo ""
            echo -e "${YELLOW}${MSG_REMOVE_SUDO}?${NC}"
            echo -e "${GREEN}[1]${NC} ${MSG_YES}"
            echo -e "${GREEN}[2]${NC} ${MSG_NO}"
            echo -ne "${CYAN}${MSG_ENTER_CHOICE} [1-2]: ${NC}"
            read CHOICE

            if [ "$CHOICE" = "1" ]; then
                gpasswd -d "$USERNAME" sudo
                echo -e "${GREEN}[✓] ${MSG_SUDO_REMOVED}: $USERNAME${NC}"
            fi
        else
            HAS_SUDO=false
            echo -e "${CYAN}User $USERNAME ${MSG_NO_SUDO}${NC}"
            echo ""
            echo -e "${YELLOW}${MSG_ADD_SUDO}?${NC}"
            echo -e "${GREEN}[1]${NC} ${MSG_YES}"
            echo -e "${GREEN}[2]${NC} ${MSG_NO}"
            echo -ne "${CYAN}${MSG_ENTER_CHOICE} [1-2]: ${NC}"
            read CHOICE

            if [ "$CHOICE" = "1" ]; then
                usermod -aG sudo "$USERNAME"
                echo -e "${GREEN}[✓] ${MSG_SUDO_GRANTED}: $USERNAME${NC}"
            fi
        fi
        ;;
    0)
        exit 0
        ;;
    *)
        echo -e "  ${RED}${MSG_INVALID_CHOICE}${NC}"
        ;;
esac
