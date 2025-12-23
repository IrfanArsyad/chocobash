#!/bin/bash

# Warna
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${CYAN}"
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║                    CREATE SWAP FILE                       ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Cek swap yang ada
CURRENT_SWAP=$(free -h | awk '/^Swap:/ {print $2}')
echo -e "${YELLOW}Current swap: $CURRENT_SWAP${NC}"
echo ""

echo -ne "${YELLOW}Masukkan ukuran swap (contoh: 2G, 4G, 8G) [2G]: ${NC}"
read swap_size

if [ -z "$swap_size" ]; then
    swap_size="2G"
fi

SWAP_FILE="/swapfile"

echo "[*] Mematikan swap yang ada..."
sudo swapoff -a 2>/dev/null

echo "[*] Membuat swap file $swap_size..."
sudo fallocate -l $swap_size $SWAP_FILE

echo "[*] Setting permissions..."
sudo chmod 600 $SWAP_FILE

echo "[*] Setting up swap..."
sudo mkswap $SWAP_FILE

echo "[*] Mengaktifkan swap..."
sudo swapon $SWAP_FILE

echo "[*] Menambahkan ke fstab..."
if ! grep -q "$SWAP_FILE" /etc/fstab; then
    echo "$SWAP_FILE none swap sw 0 0" | sudo tee -a /etc/fstab
fi

echo -e "${GREEN}[✓] Swap file berhasil dibuat!${NC}"
echo ""
free -h
