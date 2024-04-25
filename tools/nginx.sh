#!/bin/bash

# Perbarui daftar paket dan instal dependensi
sudo apt-get update
sudo apt install nginx

# Konfigurasikan Nginx
sudo rm /etc/nginx/sites-enabled/default
sudo touch /etc/nginx/sites-available/example.com
sudo ln -s /etc/nginx/sites-available/example.com /etc/nginx/sites-enabled/
sudo tee /etc/nginx/sites-available/example.com <<EOF
server {
    listen 80;
    server_name example.com;
    root /var/www/html;
    index index.php index.html index.htm;
    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php7.4-fpm.sock;
    }
}
EOF
sudo systemctl restart nginx

# Buat file phpinfo.php di root direktori
sudo tee /var/www/html/phpinfo.php <<EOF
<?php
phpinfo();
EOF

# Setel izin pada folder root
sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/

# Restart Nginx
sudo systemctl restart nginx