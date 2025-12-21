#!/bin/bash

echo "[*] Mengupdate package list..."
sudo apt-get update

echo "[*] Menginstall Git..."
sudo apt-get install -y git

echo "[✓] Git berhasil diinstall!"
echo ""
git --version
echo ""
echo "Untuk konfigurasi Git:"
echo "git config --global user.name \"Nama Anda\""
echo "git config --global user.email \"email@anda.com\""
