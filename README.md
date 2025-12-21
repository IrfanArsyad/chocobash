# ChocoBash

Linux Server Installer & Manager - Interactive bash script for installing and configuring various tools on Linux servers (Ubuntu/Debian).

Script bash interaktif untuk menginstall dan mengkonfigurasi berbagai tools di server Linux (Ubuntu/Debian).

## Quick Start

```bash
bash -c "$(wget -qLO - https://raw.githubusercontent.com/IrfanArsyad/chocobash/main/main.sh)"
```

atau / or

```bash
git clone https://github.com/IrfanArsyad/chocobash.git
cd chocobash
bash main.sh
```

## Language Support

ChocoBash supports **English** and **Bahasa Indonesia**.

- On first run, you will be prompted to select your language
- Press `[L]` in the main menu to change language anytime
- Language preference is saved in `~/.chocobash_lang`

## Features

### 1. PHP Installer
- PHP 7.4 FPM (Legacy Support)
- PHP 8.0 FPM (End of Life)
- PHP 8.1 FPM (Security Support)
- PHP 8.2 FPM (Stable)
- PHP 8.3 FPM (Stable - Recommended)
- PHP 8.4 FPM (Latest)

### 2. Web Server
- Nginx (High Performance)
- Apache2 (Classic & Flexible)
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
- Lynis (Security Audit)
- ClamAV

### 7. Monitoring
- htop, btop, glances
- Netdata
- Grafana
- Prometheus
- GoAccess
- Loki

### 8. Utilities
- System Info
- Disk Usage
- Network Info
- Update System
- Cleanup
- Fix Permissions
- Essential Tools
- Create Swap
- Set Timezone

## Requirements

- Ubuntu 20.04+ / Debian 10+
- sudo access
- wget or curl

## Structure

```
chocobash/
├── main.sh                 # Main menu
├── lang/                   # Language files
│   ├── en.sh              # English
│   └── id.sh              # Bahasa Indonesia
├── php/                    # PHP installers
├── webserver/              # Web server installers
├── database/               # Database installers
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
