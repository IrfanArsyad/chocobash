#!/bin/bash

BASE_URL="https://raw.githubusercontent.com/IrfanArsyad/chocobash/main"
CHOCO_LANG="${CHOCO_LANG:-id}"
eval "$(wget -qLO - ${BASE_URL}/lang/${CHOCO_LANG}.sh)"

echo "[*] ${MSG_CLEAN_APT}"
sudo apt-get clean
sudo apt-get autoclean

echo "[*] ${MSG_REMOVE_UNUSED}"
sudo apt-get autoremove -y

echo "[*] ${MSG_CLEAN_KERNELS}"
sudo apt-get purge -y $(dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d') 2>/dev/null || true

echo "[*] ${MSG_CLEAN_JOURNAL}"
sudo journalctl --vacuum-time=7d

echo "[*] ${MSG_CLEAN_TEMP}"
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*

echo "[*] ${MSG_CLEAN_THUMB}"
rm -rf ~/.cache/thumbnails/*

echo "[✓] ${MSG_CLEANUP_DONE}"
echo ""
echo "${MSG_DISK_AFTER}"
df -h /
