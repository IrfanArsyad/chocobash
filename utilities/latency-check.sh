#!/bin/bash

BASE_URL="https://raw.githubusercontent.com/IrfanArsyad/chocobash/main"

# Load language
CHOCO_LANG="${CHOCO_LANG:-id}"
eval "$(wget -qLO - ${BASE_URL}/lang/${CHOCO_LANG}.sh)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

# Function to check if ping is available
check_requirements() {
    if ! command -v ping &> /dev/null; then
        echo -e "${RED}[!] ping command not found. Installing iputils-ping...${NC}"
        sudo apt-get update -qq && sudo apt-get install -y iputils-ping
    fi

    if ! command -v traceroute &> /dev/null; then
        echo -e "${YELLOW}[*] traceroute not found. Installing...${NC}"
        sudo apt-get install -y traceroute
    fi
}

# Function to parse ping results
parse_ping_result() {
    local ping_output="$1"
    local host="$2"

    echo -e "\n${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${WHITE}${MSG_LATENCY_RESULT}: ${host}${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

    # Extract packet loss
    local packet_loss=$(echo "$ping_output" | grep -oP '\d+(?=% packet loss)' | head -1)

    # Extract min/avg/max/mdev
    local stats=$(echo "$ping_output" | grep -oP 'min/avg/max/(mdev|stddev) = \K[\d./]+' | head -1)

    if [ -n "$stats" ]; then
        IFS='/' read -r min avg max mdev <<< "$stats"

        echo -e "${GREEN}✓${NC} ${LBL_LATENCY_MIN}: ${WHITE}${min} ms${NC}"
        echo -e "${GREEN}✓${NC} ${LBL_LATENCY_AVG}: ${WHITE}${avg} ms${NC}"
        echo -e "${GREEN}✓${NC} ${LBL_LATENCY_MAX}: ${WHITE}${max} ms${NC}"

        if [ -n "$packet_loss" ]; then
            if [ "$packet_loss" -eq 0 ]; then
                echo -e "${GREEN}✓${NC} ${LBL_LATENCY_LOSS}: ${GREEN}${packet_loss}%${NC}"
            elif [ "$packet_loss" -lt 10 ]; then
                echo -e "${YELLOW}!${NC} ${LBL_LATENCY_LOSS}: ${YELLOW}${packet_loss}%${NC}"
            else
                echo -e "${RED}✗${NC} ${LBL_LATENCY_LOSS}: ${RED}${packet_loss}%${NC}"
            fi
        fi

        # Network quality assessment
        echo ""
        echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}"
        if (( $(echo "$avg < 50" | bc -l) )); then
            echo -e "${GREEN}[Excellent]${NC} Network quality is ${GREEN}excellent${NC} - Ideal for gaming & real-time apps"
        elif (( $(echo "$avg < 100" | bc -l) )); then
            echo -e "${GREEN}[Good]${NC} Network quality is ${GREEN}good${NC} - Suitable for most applications"
        elif (( $(echo "$avg < 200" | bc -l) )); then
            echo -e "${YELLOW}[Fair]${NC} Network quality is ${YELLOW}fair${NC} - May experience slight delays"
        else
            echo -e "${RED}[Poor]${NC} Network quality is ${RED}poor${NC} - High latency detected"
        fi
        echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}"
    else
        echo -e "${RED}[!] Could not parse ping results${NC}"
        echo -e "${YELLOW}Raw output:${NC}"
        echo "$ping_output"
    fi
}

# Function to perform ping test
ping_test() {
    local host="$1"
    local count="${2:-10}"

    echo ""
    echo -e "${YELLOW}[*] ${MSG_TESTING_LATENCY} ${host}...${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

    # Check if host is reachable
    if ! ping -c 1 -W 2 "$host" &> /dev/null; then
        echo -e "${RED}[!] Host ${host} is not reachable${NC}"
        return 1
    fi

    # Perform ping test
    local ping_output=$(ping -c "$count" "$host" 2>&1)

    parse_ping_result "$ping_output" "$host"
}

# Function to test multiple hosts
multi_host_test() {
    local hosts=(
        "8.8.8.8:Google DNS"
        "1.1.1.1:Cloudflare DNS"
        "208.67.222.222:OpenDNS"
        "google.com:Google"
        "github.com:GitHub"
    )

    echo ""
    echo -e "${CYAN}╔═══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${NC}         ${WHITE}MULTIPLE HOST LATENCY TEST${NC}                    ${CYAN}║${NC}"
    echo -e "${CYAN}╚═══════════════════════════════════════════════════════════╝${NC}"

    for host_entry in "${hosts[@]}"; do
        IFS=':' read -r host name <<< "$host_entry"
        echo ""
        echo -e "${WHITE}Testing: ${name} (${host})${NC}"
        ping_test "$host" 5
        sleep 1
    done

    echo ""
    echo -e "${GREEN}[✓] Multiple host test completed${NC}"
}

# Function to run traceroute
run_traceroute() {
    local host="$1"

    echo ""
    echo -e "${YELLOW}[*] ${MSG_RUNNING_TRACEROUTE} ${host}...${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""

    if command -v traceroute &> /dev/null; then
        traceroute -m 20 "$host"
        echo ""
        echo -e "${GREEN}[✓] Traceroute completed${NC}"
    else
        echo -e "${RED}[!] traceroute not installed${NC}"
        echo -e "${YELLOW}Installing traceroute...${NC}"
        sudo apt-get install -y traceroute
        traceroute -m 20 "$host"
    fi
}

# Check requirements
check_requirements

# Main menu
clear
echo -e "${CYAN}"
echo "  ╔═══════════════════════════════════════════════════════════╗"
echo "  ║           ${TITLE_LATENCY}              ║"
echo "  ╚═══════════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo ""
echo -e "${YELLOW}  ${MSG_SELECT_LATENCY}${NC}"
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${GREEN}[1]${NC} ${MSG_LATENCY_QUICK}      ${YELLOW}(${DESC_LATENCY_QUICK})${NC}"
echo -e "  ${GREEN}[2]${NC} ${MSG_LATENCY_CUSTOM}    ${YELLOW}(${DESC_LATENCY_CUSTOM})${NC}"
echo -e "  ${GREEN}[3]${NC} ${MSG_LATENCY_MULTI}     ${YELLOW}(${DESC_LATENCY_MULTI})${NC}"
echo -e "  ${GREEN}[4]${NC} ${MSG_LATENCY_TRACE}     ${YELLOW}(${DESC_LATENCY_TRACE})${NC}"
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${RED}[0]${NC} ${MSG_BACK_MAIN}"
echo ""

echo -ne "  ${CYAN}${MSG_ENTER_CHOICE} [0-4]: ${NC}"
read choice

case $choice in
    1)
        ping_test "8.8.8.8" 10
        ;;
    2)
        echo ""
        echo -ne "${CYAN}${MSG_ENTER_HOST}: ${NC}"
        read custom_host

        if [ -z "$custom_host" ]; then
            echo -e "${RED}[!] Host cannot be empty${NC}"
            exit 1
        fi

        echo -ne "${CYAN}${MSG_ENTER_COUNT}: ${NC}"
        read count
        count=${count:-10}

        ping_test "$custom_host" "$count"
        ;;
    3)
        multi_host_test
        ;;
    4)
        echo ""
        echo -ne "${CYAN}${MSG_ENTER_HOST}: ${NC}"
        read trace_host

        if [ -z "$trace_host" ]; then
            echo -e "${RED}[!] Host cannot be empty${NC}"
            exit 1
        fi

        run_traceroute "$trace_host"
        ;;
    0)
        exit 0
        ;;
    *)
        echo -e "  ${RED}${MSG_INVALID_CHOICE}${NC}"
        exit 1
        ;;
esac

echo ""
echo -e "${YELLOW}${MSG_PRESS_ENTER}${NC}"
read
