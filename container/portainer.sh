#!/bin/bash

echo "[*] Memastikan Docker terinstall..."
if ! command -v docker &> /dev/null; then
    echo "[!] Docker tidak ditemukan. Menginstall Docker..."
    bash container/docker.sh
fi

echo "[*] Membuat volume untuk Portainer..."
sudo docker volume create portainer_data

echo "[*] Menjalankan Portainer..."
sudo docker run -d \
    -p 8000:8000 \
    -p 9443:9443 \
    --name=portainer \
    --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    portainer/portainer-ce:latest

echo "[✓] Portainer berhasil diinstall!"
echo ""
echo "Akses Portainer di: https://localhost:9443"
echo "atau: https://your-server-ip:9443"
