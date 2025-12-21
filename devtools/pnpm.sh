#!/bin/bash

echo "[*] Memastikan Node.js terinstall..."
if ! command -v node &> /dev/null; then
    echo "[!] Node.js tidak ditemukan. Menginstall Node.js LTS..."
    bash devtools/nodejs-lts.sh
fi

echo "[*] Menginstall PNPM..."
npm install -g pnpm

echo "[✓] PNPM berhasil diinstall!"
echo ""
pnpm --version
