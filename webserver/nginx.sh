#!/bin/bash

echo "[*] Mengupdate package list..."
sudo apt-get update

echo "[*] Menginstall Nginx..."
sudo apt-get install -y nginx

echo "[*] Mengaktifkan Nginx..."
sudo systemctl enable nginx
sudo systemctl start nginx

echo "[*] Mengkonfigurasi firewall untuk Nginx..."
sudo ufw allow 'Nginx Full' 2>/dev/null || true

echo "[*] Membuat direktori web..."
sudo mkdir -p /var/www/html
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 755 /var/www/html

echo "[✓] Nginx berhasil diinstall!"
echo ""
echo "Status Nginx:"
sudo systemctl status nginx --no-pager
echo ""
nginx -v
