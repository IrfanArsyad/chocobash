#!/bin/bash

echo "[*] Menginstall dependencies..."
sudo apt-get update
sudo apt-get install -y curl

echo "[*] Menginstall NVM (Node Version Manager)..."
# Install NVM menggunakan official install script (versi terbaru)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

echo "[*] Menambahkan NVM ke PATH..."
# NVM biasanya otomatis menambahkan ke ~/.bashrc, tapi kita pastikan
NVM_DIR_EXPORT='export NVM_DIR="$HOME/.nvm"'
NVM_SCRIPT='[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm'
NVM_BASH_COMPLETION='[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion'

if ! grep -q "NVM_DIR" ~/.bashrc; then
    echo "$NVM_DIR_EXPORT" >> ~/.bashrc
    echo "$NVM_SCRIPT" >> ~/.bashrc
    echo "$NVM_BASH_COMPLETION" >> ~/.bashrc
fi

# Load NVM untuk session saat ini
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

echo ""
echo "[✓] NVM berhasil diinstall!"
echo ""
echo "Jalankan: source ~/.bashrc"
echo ""
echo "Perintah berguna:"
echo "  nvm install node           # Install Node.js versi terbaru"
echo "  nvm install --lts          # Install Node.js LTS"
echo "  nvm install 20             # Install Node.js versi 20"
echo "  nvm use node               # Gunakan versi terbaru"
echo "  nvm use --lts              # Gunakan versi LTS"
echo "  nvm use 20                 # Gunakan versi 20"
echo "  nvm ls                     # Lihat versi yang terinstall"
echo "  nvm ls-remote              # Lihat semua versi tersedia"
echo "  nvm current                # Lihat versi yang sedang digunakan"
echo "  nvm alias default node     # Set default ke versi terbaru"
echo "  nvm alias default --lts    # Set default ke LTS"
echo ""
