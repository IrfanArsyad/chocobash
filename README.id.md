# ChocoBash

Linux Server Installer & Manager

[![English](https://img.shields.io/badge/Language-English-blue)](README.md)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Shell Script](https://img.shields.io/badge/Shell-Bash-green.svg)](https://www.gnu.org/software/bash/)

Script bash interaktif untuk menginstall dan mengkonfigurasi berbagai tools di server Linux. Permudah setup server dengan menu yang mudah digunakan.

## Kompatibilitas

### Sistem Operasi yang Didukung

| OS | Versi | Status |
|----|-------|--------|
| Ubuntu | 20.04 LTS (Focal) | Fully Supported |
| Ubuntu | 22.04 LTS (Jammy) | Fully Supported |
| Ubuntu | 24.04 LTS (Noble) | Fully Supported |
| Debian | 10 (Buster) | Supported |
| Debian | 11 (Bullseye) | Fully Supported |
| Debian | 12 (Bookworm) | Fully Supported |

### Arsitektur yang Didukung

| Arsitektur | Status |
|------------|--------|
| x86_64 (AMD64) | Fully Supported |
| ARM64 (aarch64) | Supported |
| ARMv7 (armhf) | Partial Support |

### Di Mana ChocoBash Bisa Dijalankan

| Platform | Contoh | Kompatibilitas |
|----------|--------|----------------|
| **Cloud VPS** | DigitalOcean, Linode, Vultr, AWS EC2, Google Cloud, Azure | Excellent |
| **Dedicated Server** | OVH, Hetzner, Contabo | Excellent |
| **Home Server / Homelab** | Raspberry Pi 4+, Intel NUC, Mini PC | Excellent |
| **Virtual Machine** | VirtualBox, VMware, Proxmox, Hyper-V | Excellent |
| **Container** | LXC/LXD, Docker (dengan systemd) | Good |
| **WSL2** | Windows Subsystem for Linux 2 | Good (systemd terbatas) |

## Cara Pakai

```bash
bash -c "$(wget -qLO - https://raw.githubusercontent.com/IrfanArsyad/chocobash/main/main.sh)"
```

atau

```bash
git clone https://github.com/IrfanArsyad/chocobash.git
cd chocobash
bash main.sh
```

## Dukungan Bahasa

ChocoBash mendukung **English** dan **Bahasa Indonesia**.

- Saat pertama kali dijalankan, kamu akan diminta memilih bahasa
- Tekan `[L]` di menu utama untuk mengganti bahasa kapanpun
- Preferensi bahasa disimpan di `~/.chocobash_lang`

## Fitur

### 1. PHP Installer
- PHP 7.4 FPM (Legacy Support)
- PHP 8.0 FPM (End of Life)
- PHP 8.1 FPM (Security Support)
- PHP 8.2 FPM (Stable)
- PHP 8.3 FPM (Stable - Recommended)
- PHP 8.4 FPM (Latest)

### 2. Web Server
- Nginx (Performa Tinggi)
  - Mode Production (dengan domain)
  - Mode Self-hosted (IP:port, tanpa domain)
  - Integrasi PHP-FPM otomatis
- Apache2 (Klasik & Fleksibel)
- Caddy (Auto HTTPS)
- OpenLiteSpeed

### 3. Database
**SQL:**
- MySQL 8.0
- MariaDB
- PostgreSQL

**NoSQL:**
- MongoDB
- Redis
- Memcached

### 4. Development Tools
- Git
- Composer (PHP)
- Laravel Installer
- Node.js (LTS & Latest)
- Yarn, PNPM, Bun
- Python 3 + Pip

### 5. Container
- Docker
- Docker Compose
- Portainer (Web UI)
- Podman
- Kubernetes (Minikube)
- Lazydocker

### 6. Security
- UFW Firewall
- Firewalld
- Fail2Ban
- CrowdSec
- Certbot (Let's Encrypt)
- acme.sh
- Lynis (Audit Keamanan)
- ClamAV

### 7. Monitoring
- htop, btop, glances
- Netdata
- Grafana
- Prometheus
- GoAccess
- Loki

### 8. Utilities
- Informasi Sistem
- Penggunaan Disk
- Informasi Jaringan
- Update Sistem
- Cleanup
- Perbaiki Permissions
- Essential Tools
- Buat Swap
- Atur Timezone

## Persyaratan

- **OS**: Ubuntu 20.04+ / Debian 10+ (lihat tabel kompatibilitas di atas)
- **Akses**: Root atau sudo privileges
- **Network**: wget atau curl untuk instalasi remote
- **RAM**: Minimum 512MB (1GB+ direkomendasikan)
- **Disk**: Minimum 1GB ruang kosong

### Persyaratan Opsional

- `systemd` untuk manajemen service (sebagian besar fitur memerlukan ini)
- Koneksi internet untuk instalasi package

## Struktur

```
chocobash/
├── main.sh                 # Menu utama
├── lang/                   # File bahasa
│   ├── en.sh              # English
│   └── id.sh              # Bahasa Indonesia
├── php/                    # Installer PHP
├── webserver/              # Installer web server
├── database/               # Installer database
├── devtools/               # Development tools
├── container/              # Container tools
├── security/               # Security tools
├── monitoring/             # Monitoring tools
└── utilities/              # System utilities
```

## Author

Irfan Arsyad

## License

MIT License
