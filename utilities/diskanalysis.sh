#!/bin/bash

BASE_URL="https://raw.githubusercontent.com/IrfanArsyad/chocobash/main"

# Load language
CHOCO_LANG="${CHOCO_LANG:-id}"
eval "$(wget -qLO - ${BASE_URL}/lang/${CHOCO_LANG}.sh)"

# Warna
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
MAGENTA='\033[0;35m'
NC='\033[0m'

# Language-specific messages
if [ "$CHOCO_LANG" = "en" ]; then
    TITLE="COMPREHENSIVE DISK ANALYSIS"
    MSG_ANALYZING="Analyzing disk usage..."
    MSG_FINDING_FILES="Finding largest files..."
    MSG_FINDING_DIRS="Finding largest directories..."
    MSG_FINDING_CACHE="Finding cache and temporary files..."
    MSG_MOUNTED_FS="Mounted Filesystems"
    MSG_LARGEST_FILES="Top 20 Largest Files"
    MSG_LARGEST_DIRS_HOME="Top 10 Largest Directories in /home"
    MSG_LARGEST_DIRS_VAR="Top 10 Largest Directories in /var"
    MSG_LARGEST_DIRS_ROOT="Top 10 Largest Directories from Root"
    MSG_CACHE_FILES="Cache and Temporary Files"
    MSG_DOCKER_USAGE="Docker Space Usage"
    MSG_PACKAGE_CACHE="Package Manager Cache"
    MSG_LOG_FILES="Large Log Files (>100MB)"
    MSG_RECOMMENDATIONS="Recommendations"
    MSG_TOTAL_SIZE="Total Size"
    MSG_LOCATION="Location"
    MSG_NO_DOCKER="Docker is not installed"
    MSG_ANALYZING_DONE="Analysis completed!"
    MSG_INODE_USAGE="Inode Usage"
    REC_1="Clean package cache with: sudo apt clean"
    REC_2="Remove old logs with: sudo journalctl --vacuum-time=7d"
    REC_3="Clean Docker unused data with: docker system prune -a"
    REC_4="Check and remove unnecessary files in large directories"
else
    TITLE="ANALISIS DISK KOMPREHENSIF"
    MSG_ANALYZING="Menganalisis penggunaan disk..."
    MSG_FINDING_FILES="Mencari file terbesar..."
    MSG_FINDING_DIRS="Mencari direktori terbesar..."
    MSG_FINDING_CACHE="Mencari file cache dan temporary..."
    MSG_MOUNTED_FS="Sistem File yang Terpasang"
    MSG_LARGEST_FILES="20 File Terbesar"
    MSG_LARGEST_DIRS_HOME="10 Direktori Terbesar di /home"
    MSG_LARGEST_DIRS_VAR="10 Direktori Terbesar di /var"
    MSG_LARGEST_DIRS_ROOT="10 Direktori Terbesar dari Root"
    MSG_CACHE_FILES="File Cache dan Temporary"
    MSG_DOCKER_USAGE="Penggunaan Space Docker"
    MSG_PACKAGE_CACHE="Cache Package Manager"
    MSG_LOG_FILES="File Log Besar (>100MB)"
    MSG_RECOMMENDATIONS="Rekomendasi"
    MSG_TOTAL_SIZE="Total Ukuran"
    MSG_LOCATION="Lokasi"
    MSG_NO_DOCKER="Docker tidak terinstall"
    MSG_ANALYZING_DONE="Analisis selesai!"
    MSG_INODE_USAGE="Penggunaan Inode"
    REC_1="Bersihkan cache package dengan: sudo apt clean"
    REC_2="Hapus log lama dengan: sudo journalctl --vacuum-time=7d"
    REC_3="Bersihkan data Docker yang tidak terpakai: docker system prune -a"
    REC_4="Periksa dan hapus file yang tidak diperlukan di direktori besar"
fi

clear
echo -e "${CYAN}"
echo "╔═══════════════════════════════════════════════════════════════════════╗"
echo "║                    ${TITLE}                    ║"
echo "╚═══════════════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

echo -e "${GREEN}[*]${NC} ${MSG_ANALYZING}"
echo ""

# 1. Mounted Filesystems
echo -e "${YELLOW}━━━ ${MSG_MOUNTED_FS} ━━━${NC}"
echo ""
df -h | head -1
echo "───────────────────────────────────────────────────────────────────────"
df -h | tail -n +2 | while read line; do
    usage=$(echo $line | awk '{print $5}' | tr -d '%')
    if [ "$usage" -ge 90 ]; then
        echo -e "${RED}$line ⚠ CRITICAL${NC}"
    elif [ "$usage" -ge 80 ]; then
        echo -e "${YELLOW}$line ⚠ WARNING${NC}"
    elif [ "$usage" -ge 70 ]; then
        echo -e "${MAGENTA}$line${NC}"
    else
        echo -e "${GREEN}$line${NC}"
    fi
done
echo ""

# 2. Inode Usage
echo -e "${YELLOW}━━━ ${MSG_INODE_USAGE} ━━━${NC}"
echo ""
df -i | head -1
echo "───────────────────────────────────────────────────────────────────────"
df -i | tail -n +2 | grep -v "tmpfs\|devtmpfs" | while read line; do
    usage=$(echo $line | awk '{print $5}' | tr -d '%')
    if [ "$usage" -ge 90 ]; then
        echo -e "${RED}$line ⚠ CRITICAL${NC}"
    elif [ "$usage" -ge 80 ]; then
        echo -e "${YELLOW}$line ⚠ WARNING${NC}"
    else
        echo -e "${GREEN}$line${NC}"
    fi
done
echo ""

# 3. Top 20 Largest Files
echo -e "${GREEN}[*]${NC} ${MSG_FINDING_FILES}"
echo ""
echo -e "${YELLOW}━━━ ${MSG_LARGEST_FILES} ━━━${NC}"
echo ""
printf "%-10s %-s\n" "SIZE" "LOCATION"
echo "───────────────────────────────────────────────────────────────────────"
sudo find / -type f -not -path "/proc/*" -not -path "/sys/*" -not -path "/dev/*" -not -path "/run/*" -exec du -h {} + 2>/dev/null | sort -rh | head -20 | awk '{printf "%-10s %s\n", $1, $2}'
echo ""

# 4. Top 10 Largest Directories in /home
echo -e "${GREEN}[*]${NC} ${MSG_FINDING_DIRS}"
echo ""
echo -e "${YELLOW}━━━ ${MSG_LARGEST_DIRS_HOME} ━━━${NC}"
echo ""
if [ -d /home ]; then
    printf "%-10s %-s\n" "SIZE" "DIRECTORY"
    echo "───────────────────────────────────────────────────────────────────────"
    sudo du -sh /home/* 2>/dev/null | sort -rh | head -10 | awk '{printf "%-10s %s\n", $1, $2}'
else
    echo -e "${RED}Directory /home not found${NC}"
fi
echo ""

# 5. Top 10 Largest Directories in /var
echo -e "${YELLOW}━━━ ${MSG_LARGEST_DIRS_VAR} ━━━${NC}"
echo ""
if [ -d /var ]; then
    printf "%-10s %-s\n" "SIZE" "DIRECTORY"
    echo "───────────────────────────────────────────────────────────────────────"
    sudo du -sh /var/* 2>/dev/null | sort -rh | head -10 | awk '{printf "%-10s %s\n", $1, $2}'
else
    echo -e "${RED}Directory /var not found${NC}"
fi
echo ""

# 6. Top 10 Largest Directories from Root
echo -e "${YELLOW}━━━ ${MSG_LARGEST_DIRS_ROOT} ━━━${NC}"
echo ""
printf "%-10s %-s\n" "SIZE" "DIRECTORY"
echo "───────────────────────────────────────────────────────────────────────"
sudo du -shx /* 2>/dev/null | sort -rh | head -10 | awk '{printf "%-10s %s\n", $1, $2}'
echo ""

# 7. Package Manager Cache
echo -e "${GREEN}[*]${NC} ${MSG_FINDING_CACHE}"
echo ""
echo -e "${YELLOW}━━━ ${MSG_PACKAGE_CACHE} ━━━${NC}"
echo ""
printf "%-15s %-10s\n" "CACHE TYPE" "SIZE"
echo "───────────────────────────────────────────────────────────────────────"

# APT Cache
if [ -d /var/cache/apt ]; then
    apt_cache=$(sudo du -sh /var/cache/apt 2>/dev/null | awk '{print $1}')
    printf "%-15s %-10s\n" "APT Cache" "$apt_cache"
fi

# Snap Cache
if [ -d /var/lib/snapd/cache ]; then
    snap_cache=$(sudo du -sh /var/lib/snapd/cache 2>/dev/null | awk '{print $1}')
    printf "%-15s %-10s\n" "Snap Cache" "$snap_cache"
fi

# Thumbnail Cache
if [ -d ~/.cache/thumbnails ]; then
    thumb_cache=$(du -sh ~/.cache/thumbnails 2>/dev/null | awk '{print $1}')
    printf "%-15s %-10s\n" "Thumbnails" "$thumb_cache"
fi

# Temp files
if [ -d /tmp ]; then
    temp_size=$(sudo du -sh /tmp 2>/dev/null | awk '{print $1}')
    printf "%-15s %-10s\n" "/tmp" "$temp_size"
fi

# Var tmp
if [ -d /var/tmp ]; then
    var_tmp_size=$(sudo du -sh /var/tmp 2>/dev/null | awk '{print $1}')
    printf "%-15s %-10s\n" "/var/tmp" "$var_tmp_size"
fi

echo ""

# 8. Large Log Files
echo -e "${YELLOW}━━━ ${MSG_LOG_FILES} ━━━${NC}"
echo ""
printf "%-10s %-s\n" "SIZE" "LOG FILE"
echo "───────────────────────────────────────────────────────────────────────"
sudo find /var/log -type f -size +100M -exec du -h {} + 2>/dev/null | sort -rh | awk '{printf "%-10s %s\n", $1, $2}'
if [ $? -ne 0 ] || [ -z "$(sudo find /var/log -type f -size +100M 2>/dev/null)" ]; then
    echo -e "${GREEN}No large log files found (>100MB)${NC}"
fi
echo ""

# 9. Docker Usage (if installed)
if command -v docker &> /dev/null; then
    echo -e "${YELLOW}━━━ ${MSG_DOCKER_USAGE} ━━━${NC}"
    echo ""
    docker system df 2>/dev/null || echo -e "${RED}Unable to get Docker information${NC}"
    echo ""
fi

# 10. Journal Logs Size
echo -e "${YELLOW}━━━ Systemd Journal Logs ━━━${NC}"
echo ""
if command -v journalctl &> /dev/null; then
    journal_size=$(sudo journalctl --disk-usage 2>/dev/null | grep -oP '\d+\.\d+[GM]')
    echo -e "Journal logs size: ${YELLOW}${journal_size}${NC}"
else
    echo -e "${RED}journalctl not available${NC}"
fi
echo ""

# Recommendations
echo -e "${CYAN}═══════════════════════════════════════════════════════════════════════${NC}"
echo -e "${WHITE}${MSG_RECOMMENDATIONS}:${NC}"
echo -e "${CYAN}═══════════════════════════════════════════════════════════════════════${NC}"
echo ""
echo -e "${GREEN}1.${NC} ${REC_1}"
echo -e "${GREEN}2.${NC} ${REC_2}"
if command -v docker &> /dev/null; then
    echo -e "${GREEN}3.${NC} ${REC_3}"
fi
echo -e "${GREEN}4.${NC} ${REC_4}"
echo ""
echo -e "${CYAN}═══════════════════════════════════════════════════════════════════════${NC}"
echo ""
echo -e "${GREEN}✓${NC} ${MSG_ANALYZING_DONE}"
echo ""
