#!/bin/bash

echo "[*] Menginstall Certbot..."
sudo apt-get update
sudo apt-get install -y certbot

# Cek web server yang terinstall
if command -v nginx &> /dev/null; then
    echo "[*] Nginx terdeteksi, menginstall plugin Nginx..."
    sudo apt-get install -y python3-certbot-nginx
    echo ""
    echo "Untuk mendapatkan SSL certificate:"
    echo "sudo certbot --nginx -d example.com -d www.example.com"
elif command -v apache2 &> /dev/null; then
    echo "[*] Apache terdeteksi, menginstall plugin Apache..."
    sudo apt-get install -y python3-certbot-apache
    echo ""
    echo "Untuk mendapatkan SSL certificate:"
    echo "sudo certbot --apache -d example.com -d www.example.com"
else
    echo ""
    echo "Untuk mendapatkan SSL certificate (standalone):"
    echo "sudo certbot certonly --standalone -d example.com"
fi

echo "[✓] Certbot berhasil diinstall!"
echo ""
certbot --version
echo ""
echo "Certificate akan auto-renew. Test dengan:"
echo "sudo certbot renew --dry-run"
