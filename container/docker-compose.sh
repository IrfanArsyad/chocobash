#!/bin/bash

echo "[*] Memastikan Docker terinstall..."
if ! command -v docker &> /dev/null; then
    echo "[!] Docker tidak ditemukan. Menginstall Docker..."
    bash container/docker.sh
fi

echo "[*] Docker Compose sudah termasuk dalam Docker (docker compose)..."
echo "[*] Menginstall docker-compose standalone (opsional)..."

COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

sudo curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "[✓] Docker Compose berhasil diinstall!"
echo ""
docker compose version
docker-compose --version
