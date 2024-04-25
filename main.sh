#!/bin/bash

echo "Selamat Datang Di ChocoBash"
echo "Silahkan pilih perintah dibawah ini: "
echo "1. Install PHP"
echo "2. Install Server"

read pilihan

case $pilihan in 
    1) bash php/installer.sh ;;
    2) bash tools/installer.sh ;;
    *) echo "Pilihan tidak valid. Silahkan pilih nomo yang valid." ;;
esac