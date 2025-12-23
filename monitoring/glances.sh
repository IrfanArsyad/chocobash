#!/bin/bash

echo "[*] Menginstall Glances..."
sudo apt-get update
sudo apt-get install -y glances

echo "[✓] Glances berhasil diinstall!"
echo ""
glances --version
echo ""
echo "Jalankan dengan: glances"
echo "Mode web: glances -w (akses di http://localhost:61208)"
