#!/bin/bash

echo "[*] Menginstall Fail2Ban..."
sudo apt-get update
sudo apt-get install -y fail2ban

echo "[*] Membuat konfigurasi lokal..."
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local

echo "[*] Mengkonfigurasi Fail2Ban untuk SSH..."
sudo tee /etc/fail2ban/jail.d/sshd.local > /dev/null <<EOF
[sshd]
enabled = true
port = ssh
filter = sshd
logpath = /var/log/auth.log
maxretry = 5
bantime = 3600
findtime = 600
EOF

echo "[*] Mengaktifkan Fail2Ban..."
sudo systemctl enable fail2ban
sudo systemctl restart fail2ban

echo "[✓] Fail2Ban berhasil diinstall!"
echo ""
sudo fail2ban-client status
echo ""
echo "Perintah berguna:"
echo "  fail2ban-client status sshd    - Status jail SSH"
echo "  fail2ban-client unban IP       - Unban IP"
