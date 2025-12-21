#!/bin/bash

echo "[*] Menginstall ClamAV..."
sudo apt-get update
sudo apt-get install -y clamav clamav-daemon

echo "[*] Menghentikan freshclam untuk update database..."
sudo systemctl stop clamav-freshclam

echo "[*] Mengupdate virus database..."
sudo freshclam

echo "[*] Mengaktifkan ClamAV daemon..."
sudo systemctl enable clamav-daemon
sudo systemctl start clamav-daemon
sudo systemctl start clamav-freshclam

echo "[✓] ClamAV berhasil diinstall!"
echo ""
clamscan --version
echo ""
echo "Perintah berguna:"
echo "  clamscan /path/to/scan              - Scan folder"
echo "  clamscan -r /path/to/scan           - Scan recursive"
echo "  clamscan -r --remove /path/to/scan  - Scan & hapus infected"
