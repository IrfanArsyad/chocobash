#!/bin/bash

# Warna
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${CYAN}[*] Memperbaiki permissions untuk web directory...${NC}"

WEB_DIR="/var/www/html"

echo -ne "${YELLOW}Masukkan path web directory [$WEB_DIR]: ${NC}"
read input_dir

if [ -n "$input_dir" ]; then
    WEB_DIR="$input_dir"
fi

if [ ! -d "$WEB_DIR" ]; then
    echo "Directory tidak ditemukan: $WEB_DIR"
    exit 1
fi

echo "[*] Setting ownership ke www-data:www-data..."
sudo chown -R www-data:www-data "$WEB_DIR"

echo "[*] Setting permission untuk directories (755)..."
sudo find "$WEB_DIR" -type d -exec chmod 755 {} \;

echo "[*] Setting permission untuk files (644)..."
sudo find "$WEB_DIR" -type f -exec chmod 644 {} \;

echo -e "${GREEN}[✓] Permissions berhasil diperbaiki untuk: $WEB_DIR${NC}"
