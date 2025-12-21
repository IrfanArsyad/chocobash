#!/bin/bash

echo "[*] Menginstall dependencies..."
sudo apt-get update
sudo apt-get install -y php-cli php-zip php-curl unzip

echo "[*] Mendownload Composer installer..."
cd /tmp
curl -sS https://getcomposer.org/installer -o composer-setup.php

echo "[*] Menginstall Composer globally..."
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer

echo "[*] Membersihkan file installer..."
rm composer-setup.php

echo "[✓] Composer berhasil diinstall!"
echo ""
composer --version
