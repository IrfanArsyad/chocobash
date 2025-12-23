#!/bin/bash

echo "[*] Mengupdate package list..."
sudo apt-get update

echo "[*] Menginstall MariaDB..."
sudo apt-get install -y mariadb-server mariadb-client

echo "[*] Mengaktifkan MariaDB..."
sudo systemctl enable mariadb
sudo systemctl start mariadb

echo "[✓] MariaDB berhasil diinstall!"
echo ""
echo "Status MariaDB:"
sudo systemctl status mariadb --no-pager
echo ""
mariadb --version
echo ""
echo "Untuk mengamankan instalasi MariaDB, jalankan:"
echo "sudo mysql_secure_installation"
