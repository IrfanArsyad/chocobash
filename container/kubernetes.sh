#!/bin/bash

echo "[*] Menginstall dependencies..."
sudo apt-get update
sudo apt-get install -y curl wget apt-transport-https

echo "[*] Memastikan Docker terinstall..."
if ! command -v docker &> /dev/null; then
    echo "[!] Docker tidak ditemukan. Menginstall Docker..."
    bash container/docker.sh
fi

echo "[*] Menginstall kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl

echo "[*] Menginstall Minikube..."
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64

echo "[✓] Kubernetes (kubectl + Minikube) berhasil diinstall!"
echo ""
kubectl version --client
minikube version
echo ""
echo "Untuk memulai cluster Minikube:"
echo "minikube start"
