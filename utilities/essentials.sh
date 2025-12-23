#!/bin/bash

echo "[*] Menginstall essential tools..."
sudo apt-get update
sudo apt-get install -y \
    curl \
    wget \
    unzip \
    zip \
    tar \
    gzip \
    vim \
    nano \
    htop \
    net-tools \
    dnsutils \
    tree \
    jq \
    ncdu \
    rsync \
    screen \
    tmux \
    build-essential \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    gnupg \
    lsb-release

echo "[✓] Essential tools berhasil diinstall!"
echo ""
echo "Tools yang terinstall:"
echo "  - curl, wget        : Download tools"
echo "  - unzip, zip, tar   : Archive tools"
echo "  - vim, nano         : Text editors"
echo "  - htop              : Process viewer"
echo "  - net-tools         : Network tools"
echo "  - tree, ncdu        : File/disk browsers"
echo "  - jq                : JSON processor"
echo "  - screen, tmux      : Terminal multiplexers"
echo "  - build-essential   : Compilers"
