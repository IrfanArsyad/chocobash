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
echo "  ║                  ${TITLE_CONTAINER}                      ║"
echo "  ╚═══════════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo ""
echo -e "${YELLOW}  ${MSG_SELECT_CONTAINER}${NC}"
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${GREEN}[1]${NC} Docker          ${YELLOW}(Container Runtime)${NC}"
echo -e "  ${GREEN}[2]${NC} Docker Compose  ${YELLOW}(Multi-Container Tool)${NC}"
echo -e "  ${GREEN}[3]${NC} Portainer       ${YELLOW}(Docker Web UI)${NC}"
echo -e "  ${GREEN}[4]${NC} Podman          ${YELLOW}(Docker ${LBL_ALTERNATIVE})${NC}"
echo -e "  ${GREEN}[5]${NC} Kubernetes      ${YELLOW}(K8s with Minikube)${NC}"
echo -e "  ${GREEN}[6]${NC} Lazydocker      ${YELLOW}(Docker TUI Manager)${NC}"
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${RED}[0]${NC} ${MSG_BACK_MAIN}"
echo ""

echo -ne "  ${CYAN}${MSG_ENTER_CHOICE} [0-6]: ${NC}"
read pilihan

case $pilihan in
    1)
        echo -e "\n${GREEN}[*] ${MSG_START_INSTALL} Docker...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/container/docker.sh)"
        ;;
    2)
        echo -e "\n${GREEN}[*] ${MSG_START_INSTALL} Docker Compose...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/container/docker-compose.sh)"
        ;;
    3)
        echo -e "\n${GREEN}[*] ${MSG_START_INSTALL} Portainer...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/container/portainer.sh)"
        ;;
    4)
        echo -e "\n${GREEN}[*] ${MSG_START_INSTALL} Podman...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/container/podman.sh)"
        ;;
    5)
        echo -e "\n${GREEN}[*] ${MSG_START_INSTALL} Kubernetes (Minikube)...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/container/kubernetes.sh)"
        ;;
    6)
        echo -e "\n${GREEN}[*] ${MSG_START_INSTALL} Lazydocker...${NC}\n"
        CHOCO_LANG="$CHOCO_LANG" bash -c "$(wget -qLO - ${BASE_URL}/container/lazydocker.sh)"
        ;;
    0)
        exit 0
        ;;
    *)
        echo -e "  ${RED}${MSG_INVALID_CHOICE}${NC}"
        ;;
esac
