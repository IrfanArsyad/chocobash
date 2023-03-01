#!/bin/bash


# Perbarui daftar paket dan instal dependensi
sudo apt-get update
sudo apt install lsb-release ca-certificates apt-transport-https software-properties-common -y
sudo add-apt-repository ppa:ondrej/php -y
sudo apt-get update 
sudo apt install php8.0 php8.0-cli php8.0-common php8.0-imap php8.0-redis php8.0-xml php8.0-zip php8.0-mbstring -y 

# Restart PHP-FPM 
sudo systemctl restart php7.4-fpm