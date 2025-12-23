#!/bin/bash

echo "[*] Menginstall Netdata..."
wget -O /tmp/netdata-kickstart.sh https://get.netdata.cloud/kickstart.sh
sh /tmp/netdata-kickstart.sh --non-interactive

echo "[*] Mengaktifkan Netdata..."
sudo systemctl enable netdata
sudo systemctl start netdata

echo "[✓] Netdata berhasil diinstall!"
echo ""
echo "Akses dashboard di: http://localhost:19999"
echo "atau: http://your-server-ip:19999"
