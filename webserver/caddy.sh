#!/bin/bash

echo "[*] Menginstall dependencies..."
sudo apt-get update
sudo apt-get install -y debian-keyring debian-archive-keyring apt-transport-https curl

echo "[*] Menambahkan repository Caddy..."
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list

echo "[*] Menginstall Caddy..."
sudo apt-get update
sudo apt-get install -y caddy

echo "[*] Mengaktifkan Caddy..."
sudo systemctl enable caddy
sudo systemctl start caddy

echo "[*] Mengkonfigurasi firewall..."
sudo ufw allow 80/tcp 2>/dev/null || true
sudo ufw allow 443/tcp 2>/dev/null || true

echo "[✓] Caddy berhasil diinstall!"
echo ""
echo "Status Caddy:"
sudo systemctl status caddy --no-pager
echo ""
caddy version
