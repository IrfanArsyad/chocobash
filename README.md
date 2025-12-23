# ChocoBash

Linux Server Installer & Manager

[![Bahasa Indonesia](https://img.shields.io/badge/Bahasa-Indonesia-red)](README.id.md)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Shell Script](https://img.shields.io/badge/Shell-Bash-green.svg)](https://www.gnu.org/software/bash/)

Interactive bash script for installing and configuring various tools on Linux servers. Simplify your server setup with an easy-to-use menu-driven interface.

## Compatibility

### Supported Operating Systems

| OS | Version | Status |
|----|---------|--------|
| Ubuntu | 20.04 LTS (Focal) | Fully Supported |
| Ubuntu | 22.04 LTS (Jammy) | Fully Supported |
| Ubuntu | 24.04 LTS (Noble) | Fully Supported |
| Debian | 10 (Buster) | Supported |
| Debian | 11 (Bullseye) | Fully Supported |
| Debian | 12 (Bookworm) | Fully Supported |

### Supported Architectures

| Architecture | Status |
|--------------|--------|
| x86_64 (AMD64) | Fully Supported |
| ARM64 (aarch64) | Supported |
| ARMv7 (armhf) | Partial Support |

### Where You Can Run ChocoBash

| Platform | Examples | Compatibility |
|----------|----------|---------------|
| **Cloud VPS** | DigitalOcean, Linode, Vultr, AWS EC2, Google Cloud, Azure | Excellent |
| **Dedicated Server** | OVH, Hetzner, Contabo | Excellent |
| **Home Server / Homelab** | Raspberry Pi 4+, Intel NUC, Mini PC | Excellent |
| **Virtual Machine** | VirtualBox, VMware, Proxmox, Hyper-V | Excellent |
| **Container** | LXC/LXD, Docker (with systemd) | Good |
| **WSL2** | Windows Subsystem for Linux 2 | Good (limited systemd) |

## Quick Start

```bash
bash -c "$(wget -qLO - https://raw.githubusercontent.com/IrfanArsyad/chocobash/main/main.sh)"
```

or

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
  - Production mode (with domain)
  - Self-hosted mode (IP:port, no domain required)
  - Automatic PHP-FPM integration
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

- **OS**: Ubuntu 20.04+ / Debian 10+ (see compatibility table above)
- **Access**: Root or sudo privileges
- **Network**: wget or curl for remote installation
- **RAM**: Minimum 512MB (1GB+ recommended)
- **Disk**: Minimum 1GB free space

### Optional Requirements

- `systemd` for service management (most features require this)
- Internet connection for package installation

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
