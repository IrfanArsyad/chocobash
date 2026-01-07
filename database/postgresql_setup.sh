#!/bin/bash

BASE_URL="https://raw.githubusercontent.com/IrfanArsyad/chocobash/main"

# Load language
CHOCO_LANG="${CHOCO_LANG:-id}"
eval "$(wget -qLO - ${BASE_URL}/lang/${CHOCO_LANG}.sh | tr -d '\r')"

# Warna
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

# Check if PostgreSQL is installed
check_postgresql() {
    if ! command -v psql &> /dev/null; then
        echo -e "${RED}[!] PostgreSQL ${MSG_NOT_INSTALLED}${NC}"
        echo -e "${YELLOW}[*] ${MSG_INSTALL_FIRST}${NC}"
        exit 1
    fi
}

# Show menu
show_menu() {
    clear
    echo -e "${CYAN}"
    echo "  ╔═══════════════════════════════════════════════════════════╗"
    echo "  ║              ${TITLE_PGSQL_SETUP}                      ║"
    echo "  ╚═══════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    echo ""
    echo -e "${YELLOW}  ${MSG_SELECT_ACTION}:${NC}"
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -e "  ${GREEN}[1]${NC} ${MSG_PGSQL_CREATE_DB}       ${YELLOW}(Create Database)${NC}"
    echo -e "  ${GREEN}[2]${NC} ${MSG_PGSQL_CREATE_USER}     ${YELLOW}(Create User)${NC}"
    echo -e "  ${GREEN}[3]${NC} ${MSG_PGSQL_CREATE_ALL}      ${YELLOW}(Database + User + Grant)${NC}"
    echo -e "  ${GREEN}[4]${NC} ${MSG_PGSQL_LIST_DB}         ${YELLOW}(Show Databases)${NC}"
    echo -e "  ${GREEN}[5]${NC} ${MSG_PGSQL_LIST_USER}       ${YELLOW}(Show Users)${NC}"
    echo -e "  ${GREEN}[6]${NC} ${MSG_PGSQL_CHANGE_PASS}     ${YELLOW}(Change Password)${NC}"
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -e "  ${RED}[0]${NC} ${MSG_BACK_MAIN}"
    echo ""
}

# Create database only
create_database() {
    echo ""
    echo -ne "  ${CYAN}${MSG_PGSQL_ENTER_DBNAME}: ${NC}"
    read db_name

    if [ -z "$db_name" ]; then
        echo -e "  ${RED}[!] ${MSG_PGSQL_DBNAME_REQUIRED}${NC}"
        return 1
    fi

    echo -e "\n${GREEN}[*] ${MSG_CREATING} database '${db_name}'...${NC}\n"
    sudo -u postgres psql -c "CREATE DATABASE ${db_name};"

    if [ $? -eq 0 ]; then
        echo -e "\n${GREEN}[✓] Database '${db_name}' ${MSG_SUCCESS}${NC}"
    else
        echo -e "\n${RED}[!] ${MSG_FAILED} create database${NC}"
    fi
}

# Create user only
create_user() {
    echo ""
    echo -ne "  ${CYAN}${MSG_PGSQL_ENTER_USERNAME}: ${NC}"
    read pg_user

    if [ -z "$pg_user" ]; then
        echo -e "  ${RED}[!] ${MSG_PGSQL_USERNAME_REQUIRED}${NC}"
        return 1
    fi

    echo -ne "  ${CYAN}${MSG_PGSQL_ENTER_PASSWORD}: ${NC}"
    read -s pg_pass
    echo ""

    if [ -z "$pg_pass" ]; then
        echo -e "  ${RED}[!] ${MSG_PGSQL_PASSWORD_REQUIRED}${NC}"
        return 1
    fi

    echo -e "\n${GREEN}[*] ${MSG_CREATING} user '${pg_user}'...${NC}\n"
    sudo -u postgres psql -c "CREATE USER ${pg_user} WITH PASSWORD '${pg_pass}';"

    if [ $? -eq 0 ]; then
        echo -e "\n${GREEN}[✓] User '${pg_user}' ${MSG_SUCCESS}${NC}"
    else
        echo -e "\n${RED}[!] ${MSG_FAILED} create user${NC}"
    fi
}

# Create database, user and grant privileges
create_all() {
    echo ""
    echo -e "${WHITE}  ${MSG_PGSQL_SETUP_WIZARD}${NC}"
    echo ""

    echo -ne "  ${CYAN}${MSG_PGSQL_ENTER_DBNAME}: ${NC}"
    read db_name

    if [ -z "$db_name" ]; then
        echo -e "  ${RED}[!] ${MSG_PGSQL_DBNAME_REQUIRED}${NC}"
        return 1
    fi

    echo -ne "  ${CYAN}${MSG_PGSQL_ENTER_USERNAME}: ${NC}"
    read pg_user

    if [ -z "$pg_user" ]; then
        echo -e "  ${RED}[!] ${MSG_PGSQL_USERNAME_REQUIRED}${NC}"
        return 1
    fi

    echo -ne "  ${CYAN}${MSG_PGSQL_ENTER_PASSWORD}: ${NC}"
    read -s pg_pass
    echo ""

    if [ -z "$pg_pass" ]; then
        echo -e "  ${RED}[!] ${MSG_PGSQL_PASSWORD_REQUIRED}${NC}"
        return 1
    fi

    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "  ${WHITE}${MSG_SUMMARY}:${NC}"
    echo -e "  Database : ${GREEN}${db_name}${NC}"
    echo -e "  Username : ${GREEN}${pg_user}${NC}"
    echo -e "  Password : ${GREEN}********${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -ne "  ${YELLOW}${MSG_CONTINUE}? [y/n]: ${NC}"
    read confirm

    if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
        echo -e "  ${RED}[!] ${MSG_PGSQL_CANCELLED}${NC}"
        return 1
    fi

    echo -e "\n${GREEN}[*] ${MSG_CREATING} user '${pg_user}'...${NC}"
    sudo -u postgres psql -c "CREATE USER ${pg_user} WITH PASSWORD '${pg_pass}';"

    echo -e "${GREEN}[*] ${MSG_CREATING} database '${db_name}'...${NC}"
    sudo -u postgres psql -c "CREATE DATABASE ${db_name} OWNER ${pg_user};"

    echo -e "${GREEN}[*] ${MSG_PGSQL_GRANTING}...${NC}"
    sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE ${db_name} TO ${pg_user};"

    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}[✓] ${MSG_SETUP_COMPLETE}!${NC}"
    echo ""
    echo -e "  ${WHITE}${MSG_PGSQL_CONNECT_INFO}:${NC}"
    echo -e "  ${CYAN}psql -h localhost -U ${pg_user} -d ${db_name}${NC}"
    echo ""
    echo -e "  ${WHITE}${MSG_PGSQL_CONNECTION_STRING}:${NC}"
    echo -e "  ${CYAN}postgresql://${pg_user}:<password>@localhost:5432/${db_name}${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

# List databases
list_databases() {
    echo ""
    echo -e "${WHITE}  ${MSG_PGSQL_LIST_DB}:${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    sudo -u postgres psql -c "\l"
}

# List users
list_users() {
    echo ""
    echo -e "${WHITE}  ${MSG_PGSQL_LIST_USER}:${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    sudo -u postgres psql -c "\du"
}

# Change password
change_password() {
    echo ""
    echo -ne "  ${CYAN}${MSG_PGSQL_ENTER_USERNAME}: ${NC}"
    read pg_user

    if [ -z "$pg_user" ]; then
        echo -e "  ${RED}[!] ${MSG_PGSQL_USERNAME_REQUIRED}${NC}"
        return 1
    fi

    echo -ne "  ${CYAN}${MSG_PGSQL_ENTER_NEW_PASSWORD}: ${NC}"
    read -s pg_pass
    echo ""

    if [ -z "$pg_pass" ]; then
        echo -e "  ${RED}[!] ${MSG_PGSQL_PASSWORD_REQUIRED}${NC}"
        return 1
    fi

    echo -e "\n${GREEN}[*] ${MSG_PGSQL_CHANGING_PASS} '${pg_user}'...${NC}\n"
    sudo -u postgres psql -c "ALTER USER ${pg_user} WITH PASSWORD '${pg_pass}';"

    if [ $? -eq 0 ]; then
        echo -e "\n${GREEN}[✓] ${MSG_PGSQL_PASS_CHANGED}${NC}"
    else
        echo -e "\n${RED}[!] ${MSG_FAILED}${NC}"
    fi
}

# Main
check_postgresql

while true; do
    show_menu

    echo -ne "  ${CYAN}${MSG_ENTER_CHOICE} [0-6]: ${NC}"
    read pilihan

    case $pilihan in
        1)
            create_database
            echo ""
            echo -e "${YELLOW}${MSG_PRESS_ENTER}${NC}"
            read
            ;;
        2)
            create_user
            echo ""
            echo -e "${YELLOW}${MSG_PRESS_ENTER}${NC}"
            read
            ;;
        3)
            create_all
            echo ""
            echo -e "${YELLOW}${MSG_PRESS_ENTER}${NC}"
            read
            ;;
        4)
            list_databases
            echo ""
            echo -e "${YELLOW}${MSG_PRESS_ENTER}${NC}"
            read
            ;;
        5)
            list_users
            echo ""
            echo -e "${YELLOW}${MSG_PRESS_ENTER}${NC}"
            read
            ;;
        6)
            change_password
            echo ""
            echo -e "${YELLOW}${MSG_PRESS_ENTER}${NC}"
            read
            ;;
        0)
            exit 0
            ;;
        *)
            echo -e "  ${RED}${MSG_INVALID_CHOICE}${NC}"
            sleep 2
            ;;
    esac
done
