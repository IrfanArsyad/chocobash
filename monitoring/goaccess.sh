#!/bin/bash

echo "[*] Menginstall GoAccess..."
sudo apt-get update
sudo apt-get install -y goaccess

echo "[✓] GoAccess berhasil diinstall!"
echo ""
goaccess --version
echo ""
echo "Contoh penggunaan:"
echo ""
echo "1. Analisis log Nginx (terminal):"
echo "   goaccess /var/log/nginx/access.log -c"
echo ""
echo "2. Analisis log Apache (terminal):"
echo "   goaccess /var/log/apache2/access.log -c"
echo ""
echo "3. Generate HTML report:"
echo "   goaccess /var/log/nginx/access.log -o report.html --log-format=COMBINED"
