#!/bin/bash

echo "[*] Menginstall Firewalld..."
sudo apt-get update
sudo apt-get install -y firewalld

echo "[*] Mengaktifkan Firewalld..."
sudo systemctl enable firewalld
sudo systemctl start firewalld

echo "[*] Mengkonfigurasi default zone..."
sudo firewall-cmd --set-default-zone=public

echo "[*] Mengizinkan SSH..."
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --reload

echo "[✓] Firewalld berhasil diinstall!"
echo ""
sudo firewall-cmd --state
sudo firewall-cmd --list-all
echo ""
echo "Perintah berguna:"
echo "  firewall-cmd --permanent --add-service=http"
echo "  firewall-cmd --permanent --add-port=8080/tcp"
echo "  firewall-cmd --reload"
