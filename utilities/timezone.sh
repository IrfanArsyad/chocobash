#!/bin/bash

# Warna
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${CYAN}"
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║                     SET TIMEZONE                          ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo -e "${NC}"

CURRENT_TZ=$(timedatectl show --property=Timezone --value)
echo -e "${YELLOW}Current timezone: $CURRENT_TZ${NC}"
echo ""

echo "Timezone populer:"
echo "  1. Asia/Jakarta (WIB)"
echo "  2. Asia/Makassar (WITA)"
echo "  3. Asia/Jayapura (WIT)"
echo "  4. Asia/Singapore"
echo "  5. America/New_York (EST)"
echo "  6. Europe/London (GMT)"
echo "  7. UTC"
echo "  8. Input manual"
echo ""

echo -ne "${YELLOW}Pilih timezone [1-8]: ${NC}"
read choice

case $choice in
    1) TZ="Asia/Jakarta" ;;
    2) TZ="Asia/Makassar" ;;
    3) TZ="Asia/Jayapura" ;;
    4) TZ="Asia/Singapore" ;;
    5) TZ="America/New_York" ;;
    6) TZ="Europe/London" ;;
    7) TZ="UTC" ;;
    8)
        echo -ne "Masukkan timezone (contoh: Asia/Jakarta): "
        read TZ
        ;;
    *)
        echo "Pilihan tidak valid"
        exit 1
        ;;
esac

echo "[*] Setting timezone ke $TZ..."
sudo timedatectl set-timezone $TZ

echo -e "${GREEN}[✓] Timezone berhasil diubah!${NC}"
echo ""
timedatectl
