#!/bin/bash

echo "[*] Menginstall UFW..."
sudo apt-get update
sudo apt-get install -y ufw

echo "[*] Mengkonfigurasi UFW default policies..."
sudo ufw default deny incoming
sudo ufw default allow outgoing

echo "[*] Mengizinkan SSH..."
sudo ufw allow ssh

echo "[*] Mengaktifkan UFW..."
sudo ufw --force enable

echo "[✓] UFW berhasil diinstall dan dikonfigurasi!"
echo ""
sudo ufw status verbose
echo ""
echo "Perintah berguna:"
echo "  ufw allow 80/tcp     - Izinkan HTTP"
echo "  ufw allow 443/tcp    - Izinkan HTTPS"
echo "  ufw allow 3306/tcp   - Izinkan MySQL"
echo "  ufw status           - Lihat status"
echo "  ufw disable          - Nonaktifkan UFW"
