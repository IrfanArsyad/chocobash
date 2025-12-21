#!/bin/bash

echo "[*] Menginstall htop..."
sudo apt-get update
sudo apt-get install -y htop

echo "[✓] htop berhasil diinstall!"
echo ""
htop --version
echo ""
echo "Jalankan dengan: htop"
