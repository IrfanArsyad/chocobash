#!/bin/bash

# Perbarui daftar paket dan instal dependensi
sudo apt-get update
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:ondrej/php
sudo apt-get update
sudo apt-get install -y php7.4-fpm php7.4-cli php7.4-mysql php7.4-curl php7.4-gd php7.4-mbstring php7.4-xml php7.4-xmlrpc php7.4-zip 

# Restart PHP-FPM 
sudo systemctl restart php7.4-fpm