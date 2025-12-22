# ChocoBash

Linux Server Installer & Manager

[![English](https://img.shields.io/badge/Language-English-blue)](README.md)

Script bash interaktif untuk menginstall dan mengkonfigurasi berbagai tools di server Linux (Ubuntu/Debian).

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

- Ubuntu 20.04+ / Debian 10+
- Akses sudo
- wget atau curl

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
