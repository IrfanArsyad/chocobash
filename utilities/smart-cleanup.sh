#!/bin/bash

BASE_URL="https://raw.githubusercontent.com/IrfanArsyad/chocobash/main"

# Load language
CHOCO_LANG="${CHOCO_LANG:-id}"
eval "$(wget -qLO - ${BASE_URL}/lang/${CHOCO_LANG}.sh)"

# Colors
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
    TITLE="SMART CLEANUP - INTERACTIVE"
    MSG_SCANNING="Scanning for cleanable items..."
    MSG_FOUND="Found cleanable items"
    MSG_SELECT="Select items to clean (space to toggle, enter to confirm)"
    MSG_CONFIRM="Are you sure you want to delete selected items?"
    MSG_CLEANING="Cleaning"
    MSG_FREED="Space freed"
    MSG_CANCELLED="Cleanup cancelled"
    MSG_COMPLETE="Cleanup complete!"
    MSG_NO_ITEMS="No cleanable items found"
    CAT_LOGS="Large Log Files"
    CAT_CACHE="Cache Files"
    CAT_TEMP="Temporary Files"
    CAT_JOURNAL="Journal Logs"
    CAT_DOCKER="Docker Unused Data"
    CAT_APT="APT Cache"
    CAT_KERNELS="Old Kernels"
    MSG_SPACE_BEFORE="Space before cleanup"
    MSG_SPACE_AFTER="Space after cleanup"
    MSG_ITEM="item"
    MSG_ITEMS="items"
else
    TITLE="SMART CLEANUP - INTERAKTIF"
    MSG_SCANNING="Scanning item yang bisa dibersihkan..."
    MSG_FOUND="Ditemukan item yang bisa dibersihkan"
    MSG_SELECT="Pilih item untuk dibersihkan"
    MSG_CONFIRM="Yakin ingin menghapus item yang dipilih?"
    MSG_CLEANING="Membersihkan"
    MSG_FREED="Space yang dibebaskan"
    MSG_CANCELLED="Cleanup dibatalkan"
    MSG_COMPLETE="Cleanup selesai!"
    MSG_NO_ITEMS="Tidak ada item yang bisa dibersihkan"
    CAT_LOGS="File Log Besar"
    CAT_CACHE="File Cache"
    CAT_TEMP="File Temporary"
    CAT_JOURNAL="Journal Logs"
    CAT_DOCKER="Data Docker Tidak Terpakai"
    CAT_APT="APT Cache"
    CAT_KERNELS="Kernel Lama"
    MSG_SPACE_BEFORE="Space sebelum cleanup"
    MSG_SPACE_AFTER="Space setelah cleanup"
    MSG_ITEM="item"
    MSG_ITEMS="item"
fi

clear
echo -e "${CYAN}"
echo "╔═══════════════════════════════════════════════════════════════════════╗"
echo "║                       ${TITLE}                        ║"
echo "╚═══════════════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Get disk space before
space_before=$(df / | tail -1 | awk '{print $4}')

echo -e "${GREEN}[*]${NC} ${MSG_SCANNING}"
echo ""

# Array to store cleanup items
declare -a cleanup_items=()
declare -a cleanup_sizes=()
declare -a cleanup_commands=()
declare -a cleanup_categories=()

# Function to add cleanup item
add_item() {
    local category="$1"
    local description="$2"
    local size="$3"
    local command="$4"

    cleanup_categories+=("$category")
    cleanup_items+=("$description")
    cleanup_sizes+=("$size")
    cleanup_commands+=("$command")
}

# 1. Check for large log files (>100MB)
echo -e "${YELLOW}[*]${NC} Checking large log files..."
while IFS= read -r line; do
    size=$(echo "$line" | awk '{print $1}')
    file=$(echo "$line" | awk '{print $2}')
    add_item "$CAT_LOGS" "$file" "$size" "sudo rm -f \"$file\""
done < <(sudo find /var/log -type f -size +100M -exec du -h {} + 2>/dev/null | sort -rh | head -10)

# 2. Check APT cache
echo -e "${YELLOW}[*]${NC} Checking APT cache..."
if [ -d /var/cache/apt ]; then
    apt_size=$(sudo du -sh /var/cache/apt 2>/dev/null | awk '{print $1}')
    # Only add if size is more than 100MB
    apt_size_bytes=$(sudo du -sb /var/cache/apt 2>/dev/null | awk '{print $1}')
    if [ "$apt_size_bytes" -gt 104857600 ]; then
        add_item "$CAT_APT" "/var/cache/apt/*" "$apt_size" "sudo apt-get clean && sudo apt-get autoclean"
    fi
fi

# 3. Check journal logs
echo -e "${YELLOW}[*]${NC} Checking journal logs..."
if command -v journalctl &> /dev/null; then
    journal_size=$(sudo journalctl --disk-usage 2>/dev/null | grep -oP '\d+\.\d+[GM]' || echo "0M")
    journal_bytes=$(sudo du -sb /var/log/journal 2>/dev/null | awk '{print $1}')
    if [ "$journal_bytes" -gt 104857600 ]; then
        add_item "$CAT_JOURNAL" "Journal logs (>7 days old)" "$journal_size" "sudo journalctl --vacuum-time=7d"
    fi
fi

# 4. Check temp files
echo -e "${YELLOW}[*]${NC} Checking temporary files..."
tmp_size=$(sudo du -sh /tmp 2>/dev/null | awk '{print $1}')
tmp_bytes=$(sudo du -sb /tmp 2>/dev/null | awk '{print $1}')
if [ "$tmp_bytes" -gt 104857600 ]; then
    add_item "$CAT_TEMP" "/tmp/*" "$tmp_size" "sudo rm -rf /tmp/* 2>/dev/null"
fi

var_tmp_size=$(sudo du -sh /var/tmp 2>/dev/null | awk '{print $1}')
var_tmp_bytes=$(sudo du -sb /var/tmp 2>/dev/null | awk '{print $1}')
if [ "$var_tmp_bytes" -gt 104857600 ]; then
    add_item "$CAT_TEMP" "/var/tmp/*" "$var_tmp_size" "sudo rm -rf /var/tmp/* 2>/dev/null"
fi

# 5. Check thumbnail cache
echo -e "${YELLOW}[*]${NC} Checking thumbnail cache..."
if [ -d ~/.cache/thumbnails ]; then
    thumb_size=$(du -sh ~/.cache/thumbnails 2>/dev/null | awk '{print $1}')
    thumb_bytes=$(du -sb ~/.cache/thumbnails 2>/dev/null | awk '{print $1}')
    if [ "$thumb_bytes" -gt 10485760 ]; then  # >10MB
        add_item "$CAT_CACHE" "~/.cache/thumbnails/*" "$thumb_size" "rm -rf ~/.cache/thumbnails/*"
    fi
fi

# 6. Check Docker (if installed)
echo -e "${YELLOW}[*]${NC} Checking Docker..."
if command -v docker &> /dev/null; then
    docker_reclaimable=$(docker system df 2>/dev/null | grep "Reclaimable" | head -1 | awk '{print $4}' || echo "0B")
    docker_bytes=$(docker system df 2>/dev/null | grep "Reclaimable" | head -1 | awk '{print $3}' | grep -oP '\d+\.\d+' | awk '{print int($1*1024*1024*1024)}')
    if [ ! -z "$docker_bytes" ] && [ "$docker_bytes" -gt 104857600 ]; then
        add_item "$CAT_DOCKER" "Docker unused data" "$docker_reclaimable" "docker system prune -af"
    fi
fi

# 7. Check old kernels
echo -e "${YELLOW}[*]${NC} Checking old kernels..."
old_kernels=$(dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' 2>/dev/null | wc -l)
if [ "$old_kernels" -gt 0 ]; then
    kernel_size=$(dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' 2>/dev/null | xargs dpkg -L 2>/dev/null | xargs du -ch 2>/dev/null | tail -1 | awk '{print $1}')
    add_item "$CAT_KERNELS" "Old kernels ($old_kernels kernel(s))" "$kernel_size" "sudo apt-get purge -y \$(dpkg -l 'linux-*' | sed '/^ii/!d;/'\"\$(uname -r | sed \"s/\(.*\)-\([^0-9]\+\)/\1/\")\"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d')"
fi

echo ""

# Check if we found any items
total_items=${#cleanup_items[@]}
if [ $total_items -eq 0 ]; then
    echo -e "${GREEN}[✓]${NC} ${MSG_NO_ITEMS}"
    echo ""
    exit 0
fi

echo -e "${GREEN}[✓]${NC} ${MSG_FOUND}: ${WHITE}${total_items}${NC} $MSG_ITEMS"
echo ""

# Display items with selection
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${WHITE}${MSG_SELECT}:${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Display all items
for i in "${!cleanup_items[@]}"; do
    printf "${GREEN}[%2d]${NC} %-25s ${YELLOW}%-10s${NC} %s\n" \
        "$((i+1))" \
        "[${cleanup_categories[$i]}]" \
        "${cleanup_sizes[$i]}" \
        "${cleanup_items[$i]}"
done

echo ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Interactive selection
if [ "$CHOCO_LANG" = "en" ]; then
    echo -e "${YELLOW}Select items to clean:${NC}"
    echo -e "  - Enter numbers separated by space (e.g., ${WHITE}1 3 5${NC})"
    echo -e "  - Enter ${WHITE}all${NC} to select all items"
    echo -e "  - Enter ${WHITE}0${NC} or press Enter to cancel"
else
    echo -e "${YELLOW}Pilih item untuk dibersihkan:${NC}"
    echo -e "  - Masukkan nomor dipisah spasi (contoh: ${WHITE}1 3 5${NC})"
    echo -e "  - Masukkan ${WHITE}all${NC} untuk pilih semua"
    echo -e "  - Masukkan ${WHITE}0${NC} atau tekan Enter untuk batal"
fi

echo ""
echo -ne "${CYAN}>>> ${NC}"
read selection

# Handle empty or 0 selection
if [ -z "$selection" ] || [ "$selection" = "0" ]; then
    echo ""
    echo -e "${YELLOW}${MSG_CANCELLED}${NC}"
    exit 0
fi

# Build list of selected indices
declare -a selected_indices=()

if [ "$selection" = "all" ]; then
    for i in "${!cleanup_items[@]}"; do
        selected_indices+=($i)
    done
else
    # Parse space-separated numbers
    for num in $selection; do
        if [[ "$num" =~ ^[0-9]+$ ]] && [ "$num" -ge 1 ] && [ "$num" -le "$total_items" ]; then
            selected_indices+=($((num-1)))
        fi
    done
fi

# Check if any valid items selected
if [ ${#selected_indices[@]} -eq 0 ]; then
    echo ""
    echo -e "${RED}No valid items selected${NC}"
    exit 1
fi

# Show confirmation
echo ""
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${WHITE}Selected items for cleanup:${NC}"
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

for idx in "${selected_indices[@]}"; do
    echo -e "${RED}[✗]${NC} ${cleanup_items[$idx]} ${YELLOW}(${cleanup_sizes[$idx]})${NC}"
done

echo ""
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Final confirmation
if [ "$CHOCO_LANG" = "en" ]; then
    echo -ne "${RED}${MSG_CONFIRM} (yes/no): ${NC}"
else
    echo -ne "${RED}${MSG_CONFIRM} (ya/tidak): ${NC}"
fi

read confirm

if [[ ! "$confirm" =~ ^([Yy][Ee][Ss]|[Yy][Aa]|[Yy])$ ]]; then
    echo ""
    echo -e "${YELLOW}${MSG_CANCELLED}${NC}"
    exit 0
fi

# Execute cleanup
echo ""
echo -e "${GREEN}[*]${NC} ${MSG_CLEANING}..."
echo ""

for idx in "${selected_indices[@]}"; do
    echo -e "${CYAN}[*]${NC} ${MSG_CLEANING} ${cleanup_items[$idx]}..."
    eval "${cleanup_commands[$idx]}" 2>/dev/null
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}  ✓ Success${NC}"
    else
        echo -e "${YELLOW}  ⚠ Completed with warnings${NC}"
    fi
done

# Get disk space after
space_after=$(df / | tail -1 | awk '{print $4}')
space_freed=$((space_after - space_before))

echo ""
echo -e "${CYAN}═══════════════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}✓ ${MSG_COMPLETE}${NC}"
echo -e "${CYAN}═══════════════════════════════════════════════════════════════════════${NC}"
echo ""
echo -e "${WHITE}${MSG_SPACE_BEFORE}:${NC} $(numfmt --to=iec-i --suffix=B $((space_before * 1024)))"
echo -e "${WHITE}${MSG_SPACE_AFTER}:${NC}  $(numfmt --to=iec-i --suffix=B $((space_after * 1024)))"

if [ $space_freed -gt 0 ]; then
    echo -e "${GREEN}${MSG_FREED}:${NC}      $(numfmt --to=iec-i --suffix=B $((space_freed * 1024)))"
fi

echo ""
