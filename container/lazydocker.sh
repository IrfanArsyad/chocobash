#!/bin/bash

echo "[*] Memastikan Docker terinstall..."
if ! command -v docker &> /dev/null; then
    echo "[!] Docker tidak ditemukan. Menginstall Docker..."
    bash container/docker.sh
fi

echo "[*] Menginstall Lazydocker..."
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

echo "[✓] Lazydocker berhasil diinstall!"
echo ""
echo "Jalankan dengan: lazydocker"
