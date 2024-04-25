#!/bin/bash

sudo apt-get update
sudo apt-get install php8.1
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update

# Restart PHP-FPM 
sudo apt -y install lsb-release apt-transport-https ca-certificates
sudo wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php8.1.list
sudo apt-get update

sudo apt-get install php8.1 php8.1-curl php8.1-gd php8.1-bcmath php8.1-cgi php8.1-ldap php8.1-mbstring php8.1-xml php8.1-soap php8.1-xsl php8.1-zip


# Restart PHP-FPM 
sudo systemctl restart php8.1-fpm