#!/bin/bash

echo "[*] Menginstall dependencies..."
sudo apt-get update
sudo apt-get install -y curl unzip

echo "[*] Menginstall Bun..."
curl -fsSL https://bun.sh/install | bash

echo "[*] Menambahkan Bun ke PATH..."
BUN_PATH='export BUN_INSTALL="$HOME/.bun"'
BUN_BIN='export PATH="$BUN_INSTALL/bin:$PATH"'

if ! grep -q ".bun" ~/.bashrc; then
    echo "$BUN_PATH" >> ~/.bashrc
    echo "$BUN_BIN" >> ~/.bashrc
fi

echo "[✓] Bun berhasil diinstall!"
echo ""
echo "Jalankan: source ~/.bashrc"
echo "Lalu cek versi dengan: bun --version"
