#!/bin/bash

BASE_URL="https://raw.githubusercontent.com/IrfanArsyad/chocobash/main"
CHOCO_LANG="${CHOCO_LANG:-id}"
eval "$(wget -qLO - ${BASE_URL}/lang/${CHOCO_LANG}.sh)"

echo "[*] ${MSG_UPDATING}"
sudo apt-get update

echo "[*] ${MSG_INSTALLING} Nginx..."
sudo apt-get install -y nginx

echo "[*] ${MSG_ENABLING} Nginx..."
sudo systemctl enable nginx
sudo systemctl start nginx

echo "[*] ${MSG_CONFIGURING} firewall..."
sudo ufw allow 'Nginx Full' 2>/dev/null || true

echo "[*] ${MSG_CREATING} web directory..."
sudo mkdir -p /var/www/html
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 755 /var/www/html

echo "[✓] Nginx ${MSG_SUCCESS}"
echo ""
echo "Status Nginx:"
sudo systemctl status nginx --no-pager
echo ""
nginx -v
