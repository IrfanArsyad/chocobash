#!/bin/bash

echo "[*] Menginstall dependencies..."
sudo apt-get update
sudo apt-get install -y wget curl

echo "[*] Mendownload dan menginstall OpenLiteSpeed..."
wget -O - https://repo.litespeed.sh | sudo bash
sudo apt-get install -y openlitespeed

echo "[*] Menginstall LSPHP (LiteSpeed PHP)..."
sudo apt-get install -y lsphp81 lsphp81-common lsphp81-mysql lsphp81-curl

echo "[*] Mengaktifkan OpenLiteSpeed..."
sudo systemctl enable lsws
sudo systemctl start lsws

echo "[*] Mengkonfigurasi firewall..."
sudo ufw allow 8088/tcp 2>/dev/null || true  # Admin panel
sudo ufw allow 80/tcp 2>/dev/null || true
sudo ufw allow 443/tcp 2>/dev/null || true

echo "[✓] OpenLiteSpeed berhasil diinstall!"
echo ""
echo "Status OpenLiteSpeed:"
sudo systemctl status lsws --no-pager
echo ""
echo "Admin Panel: http://your-ip:7080"
echo "Default Admin: admin"
echo ""
echo "Untuk set password admin, jalankan:"
echo "sudo /usr/local/lsws/admin/misc/admpass.sh"
