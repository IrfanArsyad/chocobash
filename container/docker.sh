#!/bin/bash

echo "[*] Menghapus versi Docker lama jika ada..."
sudo apt-get remove -y docker docker-engine docker.io containerd runc 2>/dev/null

echo "[*] Menginstall dependencies..."
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg lsb-release

echo "[*] Menambahkan Docker GPG key..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "[*] Menambahkan Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "[*] Menginstall Docker Engine..."
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "[*] Menambahkan user ke grup docker..."
sudo usermod -aG docker $USER

echo "[*] Mengaktifkan Docker..."
sudo systemctl enable docker
sudo systemctl start docker

echo "[✓] Docker berhasil diinstall!"
echo ""
docker --version
echo ""
echo "PENTING: Logout dan login kembali agar group docker aktif"
echo "Atau jalankan: newgrp docker"
