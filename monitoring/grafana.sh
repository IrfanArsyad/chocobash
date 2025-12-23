#!/bin/bash

echo "[*] Menginstall dependencies..."
sudo apt-get update
sudo apt-get install -y apt-transport-https software-properties-common wget

echo "[*] Menambahkan Grafana GPG key..."
sudo mkdir -p /etc/apt/keyrings/
wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null

echo "[*] Menambahkan repository Grafana..."
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee /etc/apt/sources.list.d/grafana.list

echo "[*] Menginstall Grafana..."
sudo apt-get update
sudo apt-get install -y grafana

echo "[*] Mengaktifkan Grafana..."
sudo systemctl daemon-reload
sudo systemctl enable grafana-server
sudo systemctl start grafana-server

echo "[✓] Grafana berhasil diinstall!"
echo ""
echo "Akses dashboard di: http://localhost:3000"
echo "Default login: admin / admin"
