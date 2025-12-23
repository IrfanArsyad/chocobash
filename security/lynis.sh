#!/bin/bash

echo "[*] Menginstall Lynis..."
sudo apt-get update
sudo apt-get install -y lynis

echo "[✓] Lynis berhasil diinstall!"
echo ""
lynis --version
echo ""
echo "Untuk menjalankan security audit:"
echo "sudo lynis audit system"
echo ""
echo "Untuk audit cepat:"
echo "sudo lynis audit system --quick"
