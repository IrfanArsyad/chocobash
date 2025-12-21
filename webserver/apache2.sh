#!/bin/bash

echo "[*] Mengupdate package list..."
sudo apt-get update

echo "[*] Menginstall Apache2..."
sudo apt-get install -y apache2

echo "[*] Mengaktifkan modul Apache yang diperlukan..."
sudo a2enmod rewrite
sudo a2enmod ssl
sudo a2enmod headers

echo "[*] Mengaktifkan Apache2..."
sudo systemctl enable apache2
sudo systemctl start apache2

echo "[*] Mengkonfigurasi firewall untuk Apache..."
sudo ufw allow 'Apache Full' 2>/dev/null || true

echo "[*] Membuat direktori web..."
sudo mkdir -p /var/www/html
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 755 /var/www/html

echo "[✓] Apache2 berhasil diinstall!"
echo ""
echo "Status Apache2:"
sudo systemctl status apache2 --no-pager
echo ""
apache2 -v
