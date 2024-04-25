#!/bin/bash

echo "Silahkan pilih versi PHP yang anda inginkan : "
echo "1. PHP Fpm 7.4"
echo "2. PHP Fpm 8.0"
echo "3. PHP Fpm 8.1"
echo "4. PHP Fpm 8.2"

read pilihan

case $pilihan in 
    1) bash -c "$(wget -qLO - https://raw.githubusercontent.com/IrfanArsyad/chocobash/main/php/7.4-fpm.sh)" ;;
    2) bash -c "$(wget -qLO - https://raw.githubusercontent.com/IrfanArsyad/chocobash/main/php/8.0-fpm.sh)" ;;
    3) bash -c "$(wget -qLO - https://raw.githubusercontent.com/IrfanArsyad/chocobash/main/php/8.1-fpm.sh)" ;;
    4) bash -c "$(wget -qLO - https://raw.githubusercontent.com/IrfanArsyad/chocobash/main/php/8.2-fpm.sh)" ;;
    *) echo "Pilihan tidak valid. Silakan pilih nomor yang valid." ;;
esac