#!/bin/bash

echo "[*] Mengupdate package list..."
sudo apt-get update

echo "[*] Menginstall Memcached..."
sudo apt-get install -y memcached libmemcached-tools

echo "[*] Mengaktifkan Memcached..."
sudo systemctl enable memcached
sudo systemctl start memcached

echo "[✓] Memcached berhasil diinstall!"
echo ""
echo "Status Memcached:"
sudo systemctl status memcached --no-pager
echo ""
memcached -h | head -1
echo ""
echo "Default port: 11211"
echo "Config file: /etc/memcached.conf"
