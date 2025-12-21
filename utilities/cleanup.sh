#!/bin/bash

echo "[*] Membersihkan apt cache..."
sudo apt-get clean
sudo apt-get autoclean

echo "[*] Menghapus package yang tidak diperlukan..."
sudo apt-get autoremove -y

echo "[*] Membersihkan old kernels..."
sudo apt-get purge -y $(dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d') 2>/dev/null || true

echo "[*] Membersihkan journal logs..."
sudo journalctl --vacuum-time=7d

echo "[*] Membersihkan temporary files..."
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*

echo "[*] Membersihkan thumbnail cache..."
rm -rf ~/.cache/thumbnails/*

echo "[✓] Cleanup selesai!"
echo ""
echo "Disk usage setelah cleanup:"
df -h /
