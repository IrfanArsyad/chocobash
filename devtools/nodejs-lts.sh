#!/bin/bash

echo "[*] Menginstall dependencies..."
sudo apt-get update
sudo apt-get install -y curl

echo "[*] Menambahkan NodeSource repository (LTS)..."
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -

echo "[*] Menginstall Node.js LTS..."
sudo apt-get install -y nodejs

echo "[✓] Node.js LTS berhasil diinstall!"
echo ""
node --version
npm --version
