#!/bin/bash

# Perbarui daftar paket dan instal dependensi
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update
sudo apt install php8.2 php8.2-cli php8.2-fpm php8.2-mysql php8.2-curl php8.2-gd php8.2-mbstring php8.2-xml php8.2-xmlrpc php8.2-zip

# Restart PHP-FPM 
sudo systemctl restart php8.2-fpm