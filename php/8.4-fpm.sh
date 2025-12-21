#!/bin/bash

# PHP 8.4 FPM Installer
echo "[*] Menambahkan repository PHP..."
sudo apt-get update
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:ondrej/php
sudo apt-get update

echo "[*] Menginstall PHP 8.4 FPM dan ekstensi..."
sudo apt-get install -y php8.4-fpm php8.4-cli php8.4-common php8.4-mysql \
    php8.4-curl php8.4-gd php8.4-mbstring php8.4-xml php8.4-zip \
    php8.4-bcmath php8.4-intl php8.4-readline php8.4-soap \
    php8.4-ldap php8.4-imap php8.4-redis php8.4-imagick

echo "[*] Mengaktifkan dan restart PHP 8.4 FPM..."
sudo systemctl enable php8.4-fpm
sudo systemctl restart php8.4-fpm

echo "[✓] PHP 8.4 FPM berhasil diinstall!"
php -v
