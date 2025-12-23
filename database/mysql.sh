#!/bin/bash

echo "[*] Mengupdate package list..."
sudo apt-get update

echo "[*] Menginstall MySQL 8.0..."
sudo apt-get install -y mysql-server mysql-client

echo "[*] Mengaktifkan MySQL..."
sudo systemctl enable mysql
sudo systemctl start mysql

echo "[✓] MySQL berhasil diinstall!"
echo ""
echo "Status MySQL:"
sudo systemctl status mysql --no-pager
echo ""
mysql --version
echo ""
echo "Untuk mengamankan instalasi MySQL, jalankan:"
echo "sudo mysql_secure_installation"
