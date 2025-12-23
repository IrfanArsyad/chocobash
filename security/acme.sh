#!/bin/bash

echo "[*] Menginstall acme.sh..."
curl https://get.acme.sh | sh -s email=your@email.com

echo "[*] Sourcing acme.sh..."
source ~/.bashrc

echo "[✓] acme.sh berhasil diinstall!"
echo ""
echo "Untuk mendapatkan SSL certificate:"
echo ""
echo "1. Menggunakan webroot:"
echo "   ~/.acme.sh/acme.sh --issue -d example.com -w /var/www/html"
echo ""
echo "2. Menggunakan standalone:"
echo "   ~/.acme.sh/acme.sh --issue -d example.com --standalone"
echo ""
echo "3. Menggunakan DNS (Cloudflare contoh):"
echo "   export CF_Email=\"your@email.com\""
echo "   export CF_Key=\"your-api-key\""
echo "   ~/.acme.sh/acme.sh --issue -d example.com --dns dns_cf"
