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
echo "  ║              ${TITLE_CREATE_USER}                         ║"
echo "  ╚═══════════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}[!] ${MSG_NEED_ROOT}${NC}"
    exit 1
fi

# Input username
echo -e "${YELLOW}${MSG_ENTER_USERNAME}:${NC}"
echo -ne "${CYAN}> ${NC}"
read USERNAME

# Validate username
if [ -z "$USERNAME" ]; then
    echo -e "${RED}[!] ${MSG_USERNAME_REQUIRED}${NC}"
    exit 1
fi

# Check if user already exists
if id "$USERNAME" &>/dev/null; then
    echo -e "${RED}[!] ${MSG_USER_EXISTS}: $USERNAME${NC}"
    exit 1
fi

# Ask if user should have sudo access
echo ""
echo -e "${YELLOW}${MSG_SUDO_ACCESS}?${NC}"
echo -e "${GREEN}[1]${NC} ${MSG_YES}"
echo -e "${GREEN}[2]${NC} ${MSG_NO} (${LBL_DEFAULT})"
echo -ne "${CYAN}${MSG_ENTER_CHOICE} [1-2]: ${NC}"
read SUDO_CHOICE

# Ask for password option
echo ""
echo -e "${YELLOW}${MSG_PASSWORD_OPTION}:${NC}"
echo -e "${GREEN}[1]${NC} ${MSG_SET_PASSWORD}"
echo -e "${GREEN}[2]${NC} ${MSG_NO_PASSWORD} (SSH key only)"
echo -ne "${CYAN}${MSG_ENTER_CHOICE} [1-2]: ${NC}"
read PASSWORD_CHOICE

# Create user
echo ""
echo -e "${GREEN}[*] ${MSG_CREATING_USER} $USERNAME...${NC}"

if [ "$PASSWORD_CHOICE" = "1" ]; then
    # Create user with home directory
    useradd -m -s /bin/bash "$USERNAME"

    # Set password
    echo ""
    echo -e "${YELLOW}${MSG_SET_PASSWORD_FOR} $USERNAME:${NC}"
    passwd "$USERNAME"
else
    # Create user without password
    useradd -m -s /bin/bash "$USERNAME"
    echo -e "${YELLOW}[*] ${MSG_USER_NO_PASSWORD}${NC}"
fi

# Add to sudo group if requested
if [ "$SUDO_CHOICE" = "1" ]; then
    usermod -aG sudo "$USERNAME"
    echo -e "${GREEN}[✓] ${MSG_SUDO_GRANTED}: $USERNAME${NC}"
fi

# Ask if SSH key should be set up
echo ""
echo -e "${YELLOW}${MSG_SETUP_SSH_KEY}?${NC}"
echo -e "${GREEN}[1]${NC} ${MSG_YES}"
echo -e "${GREEN}[2]${NC} ${MSG_NO} (${LBL_DEFAULT})"
echo -ne "${CYAN}${MSG_ENTER_CHOICE} [1-2]: ${NC}"
read SSH_CHOICE

if [ "$SSH_CHOICE" = "1" ]; then
    # Create .ssh directory
    USER_HOME="/home/$USERNAME"
    mkdir -p "$USER_HOME/.ssh"
    chmod 700 "$USER_HOME/.ssh"

    echo ""
    echo -e "${YELLOW}${MSG_ENTER_SSH_KEY}:${NC}"
    echo -e "${CYAN}(${MSG_PASTE_SSH_KEY})${NC}"
    echo -ne "${CYAN}> ${NC}"
    read SSH_KEY

    if [ -n "$SSH_KEY" ]; then
        echo "$SSH_KEY" > "$USER_HOME/.ssh/authorized_keys"
        chmod 600 "$USER_HOME/.ssh/authorized_keys"
        chown -R "$USERNAME:$USERNAME" "$USER_HOME/.ssh"
        echo -e "${GREEN}[✓] ${MSG_SSH_KEY_ADDED}${NC}"
    fi
fi

echo ""
echo -e "${GREEN}╔════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║          ${MSG_USER_CREATED_SUCCESS}                   ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${WHITE}${MSG_USER_INFO}:${NC}"
echo -e "  ${CYAN}Username:${NC} $USERNAME"
echo -e "  ${CYAN}Home Dir:${NC} /home/$USERNAME"

if [ "$SUDO_CHOICE" = "1" ]; then
    echo -e "  ${CYAN}Sudo:${NC} ${GREEN}Enabled${NC}"
else
    echo -e "  ${CYAN}Sudo:${NC} ${RED}Disabled${NC}"
fi

if [ "$PASSWORD_CHOICE" = "1" ]; then
    echo -e "  ${CYAN}Auth:${NC} Password"
else
    echo -e "  ${CYAN}Auth:${NC} SSH Key only"
fi

echo ""
echo -e "${YELLOW}${MSG_NEXT_STEPS}:${NC}"

if [ "$PASSWORD_CHOICE" = "1" ]; then
    echo -e "  1. ${MSG_LOGIN_AS}: ssh $USERNAME@your-server-ip"
else
    echo -e "  1. ${MSG_LOGIN_SSH_KEY}: ssh -i your_key $USERNAME@your-server-ip"
fi

if [ "$SUDO_CHOICE" = "1" ]; then
    echo -e "  2. ${MSG_SUDO_COMMAND}: sudo command"
fi

echo ""
