#!/bin/bash

echo "[*] Mengupdate package list..."
sudo apt-get update

echo "[*] Mengupgrade packages..."
sudo apt-get upgrade -y

echo "[*] Mengupgrade distribusi..."
sudo apt-get dist-upgrade -y

echo "[*] Membersihkan package yang tidak diperlukan..."
sudo apt-get autoremove -y
sudo apt-get autoclean

echo "[✓] System berhasil diupdate!"
