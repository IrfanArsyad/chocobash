#!/bin/bash

echo "[*] Mengupdate package list..."
sudo apt-get update

echo "[*] Menginstall Redis..."
sudo apt-get install -y redis-server

echo "[*] Mengkonfigurasi Redis untuk supervised systemd..."
sudo sed -i 's/supervised no/supervised systemd/g' /etc/redis/redis.conf

echo "[*] Mengaktifkan Redis..."
sudo systemctl enable redis-server
sudo systemctl restart redis-server

echo "[✓] Redis berhasil diinstall!"
echo ""
echo "Status Redis:"
sudo systemctl status redis-server --no-pager
echo ""
redis-server --version
echo ""
echo "Test koneksi Redis:"
redis-cli ping
