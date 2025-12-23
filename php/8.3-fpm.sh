#!/bin/bash

# PHP 8.3 FPM Installer
echo "[*] Menambahkan repository PHP..."
sudo apt-get update
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:ondrej/php
sudo apt-get update

echo "[*] Menginstall PHP 8.3 FPM dan ekstensi..."
sudo apt-get install -y php8.3-fpm php8.3-cli php8.3-common php8.3-mysql \
    php8.3-curl php8.3-gd php8.3-mbstring php8.3-xml php8.3-zip \
    php8.3-bcmath php8.3-intl php8.3-readline php8.3-soap \
    php8.3-ldap php8.3-imap php8.3-redis php8.3-imagick

echo "[*] Mengaktifkan dan restart PHP 8.3 FPM..."
sudo systemctl enable php8.3-fpm
sudo systemctl restart php8.3-fpm

echo "[✓] PHP 8.3 FPM berhasil diinstall!"
php -v
