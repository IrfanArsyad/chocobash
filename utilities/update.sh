#!/bin/bash

BASE_URL="https://raw.githubusercontent.com/IrfanArsyad/chocobash/main"
CHOCO_LANG="${CHOCO_LANG:-id}"
eval "$(wget -qLO - ${BASE_URL}/lang/${CHOCO_LANG}.sh)"

echo "[*] ${MSG_UPDATING}"
sudo apt-get update

echo "[*] ${MSG_UPGRADE_PACKAGES}"
sudo apt-get upgrade -y

echo "[*] ${MSG_UPGRADE_DIST}"
sudo apt-get dist-upgrade -y

echo "[*] ${MSG_REMOVE_UNUSED}"
sudo apt-get autoremove -y
sudo apt-get autoclean

echo "[✓] ${MSG_UPDATE_DONE}"
