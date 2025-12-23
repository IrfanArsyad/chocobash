#!/bin/bash

echo "[*] Menginstall btop..."
sudo apt-get update
sudo apt-get install -y btop

echo "[✓] btop berhasil diinstall!"
echo ""
btop --version
echo ""
echo "Jalankan dengan: btop"
