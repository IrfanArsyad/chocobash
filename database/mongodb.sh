#!/bin/bash

echo "[*] Menginstall dependencies..."
sudo apt-get update
sudo apt-get install -y gnupg curl

echo "[*] Menambahkan MongoDB GPG key..."
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor

echo "[*] Menambahkan repository MongoDB..."
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | \
   sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

echo "[*] Menginstall MongoDB..."
sudo apt-get update
sudo apt-get install -y mongodb-org

echo "[*] Mengaktifkan MongoDB..."
sudo systemctl enable mongod
sudo systemctl start mongod

echo "[✓] MongoDB berhasil diinstall!"
echo ""
echo "Status MongoDB:"
sudo systemctl status mongod --no-pager
echo ""
mongod --version
