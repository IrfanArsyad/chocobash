#!/bin/bash

echo "[*] Mengupdate package list..."
sudo apt-get update

echo "[*] Menginstall Podman..."
sudo apt-get install -y podman

echo "[✓] Podman berhasil diinstall!"
echo ""
podman --version
echo ""
echo "Podman adalah alternatif Docker yang rootless."
echo "Gunakan seperti Docker: podman run, podman build, dll."
