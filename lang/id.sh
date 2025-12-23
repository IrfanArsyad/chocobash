#!/bin/bash
# Indonesian Language File - ChocoBash
# Bahasa Indonesia

# Main Menu
MSG_WELCOME="Selamat Datang di ChocoBash!"
MSG_SELECT_CATEGORY="Pilih kategori instalasi:"
MSG_EXIT="Keluar"
MSG_ENTER_CHOICE="Masukkan pilihan"
MSG_INVALID_CHOICE="Pilihan tidak valid!"
MSG_PRESS_ENTER="Tekan Enter untuk kembali ke menu..."
MSG_GOODBYE="Terima kasih telah menggunakan ChocoBash!"
MSG_SEE_YOU="Sampai jumpa lagi!"

# Language Selection
MSG_SELECT_LANG="Pilih Bahasa / Select Language:"
MSG_LANG_ID="Bahasa Indonesia"
MSG_LANG_EN="English"

# Categories Description
DESC_PHP="Install PHP (7.4 - 8.4)"
DESC_WEBSERVER="Nginx, Apache2, Caddy"
DESC_DATABASE="MySQL, MariaDB, PostgreSQL, Redis, MongoDB"
DESC_DEVTOOLS="Git, Composer, Node.js, Yarn, NPM"
DESC_CONTAINER="Docker, Docker Compose, Portainer"
DESC_SECURITY="UFW Firewall, Fail2Ban, SSL/Certbot"
DESC_MONITORING="htop, netdata, Grafana"
DESC_UTILITIES="System Info, Cleanup, Update System"

# Installer Menus
MSG_BACK_MAIN="Kembali ke Menu Utama"
MSG_SELECT_VERSION="Pilih versi yang ingin diinstall:"
MSG_SELECT_INSTALL="Pilih yang ingin diinstall:"

# PHP Installer
TITLE_PHP="PHP INSTALLER"
MSG_SELECT_PHP="Pilih versi PHP yang ingin diinstall:"

# Web Server Installer
TITLE_WEBSERVER="WEB SERVER INSTALLER"
MSG_SELECT_WEBSERVER="Pilih web server yang ingin diinstall:"

# Database Installer
TITLE_DATABASE="DATABASE INSTALLER"
MSG_SELECT_DATABASE="Pilih database yang ingin diinstall:"
CAT_SQL="SQL Database"
CAT_NOSQL="NoSQL Database"

# DevTools Installer
TITLE_DEVTOOLS="DEV TOOLS INSTALLER"
MSG_SELECT_DEVTOOLS="Pilih development tool yang ingin diinstall:"
CAT_VERSION_CONTROL="Version Control"
CAT_PHP_TOOLS="PHP Tools"
CAT_JAVASCRIPT="JavaScript Runtime & Package Managers"
CAT_PYTHON="Python"

# Container Installer
TITLE_CONTAINER="CONTAINER INSTALLER"
MSG_SELECT_CONTAINER="Pilih container tool yang ingin diinstall:"
CAT_DOCKER="Docker Ecosystem"
CAT_ALTERNATIVES="Alternatives"
CAT_ORCHESTRATION="Container Orchestration"

# Security Installer
TITLE_SECURITY="SECURITY TOOLS INSTALLER"
MSG_SELECT_SECURITY="Pilih security tool yang ingin diinstall:"
CAT_FIREWALL="Firewall"
CAT_INTRUSION="Intrusion Prevention"
CAT_SSL="SSL/TLS Certificates"
CAT_AUDIT="Security Audit"

# Monitoring Installer
TITLE_MONITORING="MONITORING TOOLS INSTALLER"
MSG_SELECT_MONITORING="Pilih monitoring tool yang ingin diinstall:"
CAT_SYSTEM_MONITOR="System Monitoring"
CAT_WEB_MONITOR="Web Monitoring"
CAT_METRICS="Metrics & Visualization"
CAT_LOGGING="Log Management"

# Utilities Installer
TITLE_UTILITIES="SYSTEM UTILITIES"
MSG_SELECT_UTILITIES="Pilih utility yang ingin dijalankan:"
CAT_SYSTEM_INFO="System Information"
CAT_MAINTENANCE="System Maintenance"
CAT_CONFIGURATION="System Configuration"

# Installation Messages
MSG_UPDATING="Mengupdate package list..."
MSG_INSTALLING="Menginstall"
MSG_ENABLING="Mengaktifkan"
MSG_CONFIGURING="Mengkonfigurasi"
MSG_CREATING="Membuat"
MSG_SUCCESS="berhasil diinstall!"
MSG_START_INSTALL="Memulai instalasi"
MSG_CLEANUP="Membersihkan"
MSG_REMOVING="Menghapus"

# Utility Messages
MSG_CURRENT="Saat ini:"
MSG_ENTER_VALUE="Masukkan nilai:"
MSG_ENTER_PATH="Masukkan path:"
MSG_PERMISSION_FIXED="Permissions berhasil diperbaiki untuk:"
MSG_DISK_AFTER="Disk usage setelah cleanup:"

# Status Labels
LBL_LEGACY="Legacy Support"
LBL_EOL="End of Life"
LBL_SECURITY="Security Support"
LBL_STABLE="Stable"
LBL_RECOMMENDED="Stable - Recommended"
LBL_LATEST="Latest"
LBL_POPULAR="Popular"
LBL_ALTERNATIVE="Alternative"
LBL_MODERN="Modern"
LBL_ENTERPRISE="Enterprise"
LBL_LIGHTWEIGHT="Lightweight"
LBL_FAST="Fast"

# System Info Labels
LBL_OS_INFO="Informasi OS"
LBL_HARDWARE="Informasi Hardware"
LBL_DISK_INFO="Informasi Disk"
LBL_NETWORK_INFO="Informasi Network"
LBL_UPTIME="Uptime"
LBL_HOSTNAME="Hostname:"
LBL_OS="OS:"
LBL_KERNEL="Kernel:"
LBL_CPU="CPU:"
LBL_TOTAL_RAM="Total RAM:"
LBL_USED_RAM="RAM Terpakai:"
LBL_FREE_RAM="RAM Tersedia:"
LBL_IP_ADDRESS="Alamat IP:"
LBL_PUBLIC_IP="IP Publik:"

# Cleanup Messages
MSG_CLEAN_APT="Membersihkan apt cache..."
MSG_REMOVE_UNUSED="Menghapus package yang tidak diperlukan..."
MSG_CLEAN_KERNELS="Membersihkan old kernels..."
MSG_CLEAN_JOURNAL="Membersihkan journal logs..."
MSG_CLEAN_TEMP="Membersihkan temporary files..."
MSG_CLEAN_THUMB="Membersihkan thumbnail cache..."
MSG_CLEANUP_DONE="Cleanup selesai!"

# Update Messages
MSG_UPGRADE_PACKAGES="Mengupgrade packages..."
MSG_UPGRADE_DIST="Mengupgrade distribusi..."
MSG_UPDATE_DONE="Update selesai!"

# Swap Messages
MSG_CURRENT_SWAP="Swap saat ini:"
MSG_ENTER_SWAP="Masukkan ukuran swap (contoh: 2G, 4G, 8G)"
MSG_CREATING_SWAP="Membuat swap file..."
MSG_SWAP_CREATED="Swap berhasil dibuat!"

# Timezone Messages
MSG_CURRENT_TZ="Timezone saat ini:"
MSG_SELECT_TZ="Pilih timezone:"
MSG_TZ_SET="Timezone berhasil diatur!"

# Fix Permissions
MSG_FIX_PERM="Memperbaiki permissions untuk web directory..."
MSG_ENTER_WEBDIR="Masukkan path web directory"

# Essential Tools
MSG_INSTALL_ESSENTIALS="Menginstall essential tools..."
MSG_ESSENTIALS_DONE="Essential tools berhasil diinstall!"

# Docker specific
MSG_DOCKER_NOTE="PENTING: Logout dan login kembali agar group docker aktif"
MSG_DOCKER_ALT="Atau jalankan: newgrp docker"

# MySQL specific
MSG_MYSQL_SECURE="Untuk mengamankan instalasi MySQL, jalankan:"

# UFW specific
MSG_UFW_CMDS="Perintah berguna:"
MSG_UFW_ALLOW_HTTP="Izinkan HTTP"
MSG_UFW_ALLOW_HTTPS="Izinkan HTTPS"
MSG_UFW_ALLOW_SSH="Izinkan SSH"

# Nginx Config Messages
MSG_NOT_INSTALLED="tidak terinstall"
MSG_INSTALL_FIRST="Install terlebih dahulu"
MSG_SELECT_PHP_VERSION="Pilih versi PHP:"
MSG_CREATING_SYMLINK="Membuat symlink"
MSG_CREATED="dibuat"
MSG_FAILED="Gagal"
MSG_TESTING="Testing"
MSG_RELOADING="Reloading"
MSG_RELOADED="berhasil direload"
MSG_INVALID="tidak valid"
MSG_CHECK_CONFIG="Periksa konfigurasi"
MSG_SETUP_COMPLETE="Setup selesai"
MSG_SUMMARY="Ringkasan"
MSG_NEXT_STEPS="Langkah selanjutnya"
MSG_ADD_HOSTS="Tambahkan ke /etc/hosts jika testing lokal"
MSG_TEST_PHP="Test PHP"
MSG_REMOVE_PHPINFO="Hapus info.php setelah testing (keamanan)"
MSG_AVAILABLE_SITES="Sites tersedia"
MSG_ENABLED="aktif"
MSG_DISABLED="nonaktif"
MSG_NOT_FOUND="tidak ditemukan"
MSG_ALREADY_ENABLED="sudah aktif"
MSG_NOT_ENABLED="tidak aktif"
MSG_SELECT_ACTION="Pilih aksi"
MSG_CREATE_NEW="Buat virtual host baru"
MSG_LIST_SITES="Lihat daftar sites"
MSG_ENABLE_SITE="Aktifkan site"
MSG_DISABLE_SITE="Nonaktifkan site"
MSG_NO_PHP="Tidak ada PHP-FPM yang terinstall"
MSG_INSTALL_PHP_FIRST="Install PHP-FPM terlebih dahulu"
MSG_REQUIRED="diperlukan"
MSG_CONFIRM="Konfirmasi"
MSG_CONTINUE="Lanjutkan"
