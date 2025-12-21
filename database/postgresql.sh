#!/bin/bash

echo "[*] Mengupdate package list..."
sudo apt-get update

echo "[*] Menginstall PostgreSQL..."
sudo apt-get install -y postgresql postgresql-contrib

echo "[*] Mengaktifkan PostgreSQL..."
sudo systemctl enable postgresql
sudo systemctl start postgresql

echo "[✓] PostgreSQL berhasil diinstall!"
echo ""
echo "Status PostgreSQL:"
sudo systemctl status postgresql --no-pager
echo ""
psql --version
echo ""
echo "Untuk mengakses PostgreSQL:"
echo "sudo -u postgres psql"
