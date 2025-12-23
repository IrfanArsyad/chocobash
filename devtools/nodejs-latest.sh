#!/bin/bash

echo "[*] Menginstall dependencies..."
sudo apt-get update
sudo apt-get install -y curl

echo "[*] Menambahkan NodeSource repository (Current/Latest)..."
curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -

echo "[*] Menginstall Node.js Latest..."
sudo apt-get install -y nodejs

echo "[✓] Node.js Latest berhasil diinstall!"
echo ""
node --version
npm --version
