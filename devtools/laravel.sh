#!/bin/bash

echo "[*] Memastikan Composer terinstall..."
if ! command -v composer &> /dev/null; then
    echo "[!] Composer tidak ditemukan. Menginstall Composer..."
    bash devtools/composer.sh
fi

echo "[*] Menginstall Laravel Installer..."
composer global require laravel/installer

echo "[*] Menambahkan Composer bin ke PATH..."
COMPOSER_PATH='export PATH="$HOME/.config/composer/vendor/bin:$PATH"'

if ! grep -q "composer/vendor/bin" ~/.bashrc; then
    echo "$COMPOSER_PATH" >> ~/.bashrc
fi

if ! grep -q "composer/vendor/bin" ~/.zshrc 2>/dev/null; then
    echo "$COMPOSER_PATH" >> ~/.zshrc 2>/dev/null
fi

echo "[✓] Laravel Installer berhasil diinstall!"
echo ""
echo "Untuk membuat project Laravel baru:"
echo "laravel new nama-project"
echo ""
echo "Atau menggunakan Composer:"
echo "composer create-project laravel/laravel nama-project"
