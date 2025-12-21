#!/bin/bash

echo "[*] Menginstall CrowdSec..."
curl -s https://install.crowdsec.net | sudo sh
sudo apt-get update
sudo apt-get install -y crowdsec

echo "[*] Menginstall CrowdSec Firewall Bouncer..."
sudo apt-get install -y crowdsec-firewall-bouncer-iptables

echo "[*] Mengaktifkan CrowdSec..."
sudo systemctl enable crowdsec
sudo systemctl start crowdsec

echo "[✓] CrowdSec berhasil diinstall!"
echo ""
sudo cscli version
echo ""
echo "Perintah berguna:"
echo "  cscli decisions list    - Lihat keputusan ban"
echo "  cscli alerts list       - Lihat alerts"
echo "  cscli hub list          - Lihat collections"
