#!/bin/bash

echo "[*] Mengupdate package list..."
sudo apt-get update

echo "[*] Menginstall Python 3 dan Pip..."
sudo apt-get install -y python3 python3-pip python3-venv python3-dev

echo "[*] Mengupgrade Pip..."
python3 -m pip install --upgrade pip

echo "[✓] Python 3 berhasil diinstall!"
echo ""
python3 --version
pip3 --version
echo ""
echo "Untuk membuat virtual environment:"
echo "python3 -m venv nama-venv"
echo "source nama-venv/bin/activate"
