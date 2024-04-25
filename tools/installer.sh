#!/bin/bash

echo "Silahkan pilih versi PHP yang anda inginkan : "
echo "1. Nginx"

read pilihan

case $pilihan in 
1) bash -c "$(wget -qLO - https://raw.githubusercontent.com/IrfanArsyad/chocobash/main/tools/nginx.sh)" ;;