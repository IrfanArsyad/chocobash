#!/bin/bash

BASE_URL="https://raw.githubusercontent.com/IrfanArsyad/chocobash/main"

# Load language
CHOCO_LANG="${CHOCO_LANG:-id}"
eval "$(wget -qLO - ${BASE_URL}/lang/${CHOCO_LANG}.sh 2>/dev/null)" || true

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
WHITE='\033[1;37m'
NC='\033[0m'

# Database default ports
declare -A DB_PORTS=(
    ["mysql"]="3306"
    ["postgresql"]="5432"
    ["mongodb"]="27017"
    ["redis"]="6379"
    ["mssql"]="1433"
    ["oracle"]="1521"
    ["mariadb"]="3306"
)

# Function to check requirements
check_requirements() {
    local missing_tools=()

    # Check ping
    if ! command -v ping &> /dev/null; then
        missing_tools+=("iputils-ping")
    fi

    # Check nc (netcat)
    if ! command -v nc &> /dev/null; then
        missing_tools+=("netcat")
    fi

    # Check traceroute
    if ! command -v traceroute &> /dev/null; then
        missing_tools+=("traceroute")
    fi

    # Check dig (DNS lookup)
    if ! command -v dig &> /dev/null; then
        missing_tools+=("dnsutils")
    fi

    # Check bc (calculator for comparison)
    if ! command -v bc &> /dev/null; then
        missing_tools+=("bc")
    fi

    # Install missing tools
    if [ ${#missing_tools[@]} -gt 0 ]; then
        echo -e "${YELLOW}[*] Menginstal tools yang diperlukan...${NC}"
        sudo apt-get update -qq
        for tool in "${missing_tools[@]}"; do
            echo -e "${CYAN}    Installing ${tool}...${NC}"
            sudo apt-get install -y "$tool" -qq
        done
        echo -e "${GREEN}[✓] Semua tools berhasil diinstal${NC}"
        echo ""
    fi
}

# Function for DNS resolution test
dns_resolution_test() {
    local host="$1"

    echo ""
    echo -e "${CYAN}╔═══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${NC}              ${WHITE}DNS RESOLUTION TEST${NC}                       ${CYAN}║${NC}"
    echo -e "${CYAN}╚═══════════════════════════════════════════════════════════╝${NC}"
    echo ""

    # Check if host is already an IP
    if [[ $host =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        echo -e "${YELLOW}[*] Host sudah berupa IP address: ${WHITE}${host}${NC}"
        echo -e "${GREEN}[✓] Skip DNS resolution${NC}"
        return 0
    fi

    echo -e "${YELLOW}[*] Melakukan DNS lookup untuk: ${WHITE}${host}${NC}"
    echo ""

    # Perform DNS lookup
    local dns_result=$(dig +short "$host" A | grep -E '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$' | head -1)

    if [ -n "$dns_result" ]; then
        echo -e "${GREEN}[✓] DNS Resolution berhasil${NC}"
        echo -e "    ${CYAN}Hostname:${NC} ${WHITE}${host}${NC}"
        echo -e "    ${CYAN}IP Address:${NC} ${WHITE}${dns_result}${NC}"

        # Get additional DNS info
        local dns_time_start=$(date +%s%N)
        dig "$host" A +noall +answer +stats &> /tmp/dns_full.txt
        local dns_time_end=$(date +%s%N)
        local dns_time=$((($dns_time_end - $dns_time_start) / 1000000))

        echo -e "    ${CYAN}Query Time:${NC} ${WHITE}${dns_time} ms${NC}"

        # Get all IPs if multiple
        local all_ips=$(dig +short "$host" A | grep -E '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$')
        local ip_count=$(echo "$all_ips" | wc -l)

        if [ "$ip_count" -gt 1 ]; then
            echo -e "    ${CYAN}Multiple IPs found:${NC} ${YELLOW}${ip_count} addresses${NC}"
            echo "$all_ips" | while read ip; do
                echo -e "      - ${WHITE}${ip}${NC}"
            done
        fi

        return 0
    else
        echo -e "${RED}[✗] DNS Resolution gagal${NC}"
        echo -e "    ${YELLOW}Tidak dapat meresolve hostname: ${host}${NC}"
        return 1
    fi
}

# Function for ping test with detailed analysis
ping_test() {
    local host="$1"
    local count="${2:-20}"

    echo ""
    echo -e "${CYAN}╔═══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${NC}           ${WHITE}PING & LATENCY ANALYSIS${NC}                    ${CYAN}║${NC}"
    echo -e "${CYAN}╚═══════════════════════════════════════════════════════════╝${NC}"
    echo ""

    echo -e "${YELLOW}[*] Testing koneksi dengan ${count} packets...${NC}"
    echo ""

    # Initial reachability check
    if ! ping -c 1 -W 3 "$host" &> /dev/null; then
        echo -e "${RED}[✗] Host ${host} tidak dapat dijangkau${NC}"
        echo -e "${YELLOW}    Kemungkinan penyebab:${NC}"
        echo -e "    - Host sedang offline"
        echo -e "    - Firewall memblokir ICMP"
        echo -e "    - Network routing issue"
        return 1
    fi

    # Perform detailed ping test
    local ping_output=$(ping -c "$count" "$host" 2>&1)

    # Extract statistics
    local packet_loss=$(echo "$ping_output" | grep -oP '\d+(?=% packet loss)' | head -1)
    local stats=$(echo "$ping_output" | grep -oP 'min/avg/max/(mdev|stddev) = \K[\d./]+' | head -1)

    if [ -n "$stats" ]; then
        IFS='/' read -r min avg max mdev <<< "$stats"

        echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo -e "${WHITE}  Latency Statistics:${NC}"
        echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo ""
        echo -e "  ${CYAN}Minimum Latency:${NC}  ${GREEN}${min} ms${NC}"
        echo -e "  ${CYAN}Average Latency:${NC}  ${WHITE}${avg} ms${NC}"
        echo -e "  ${CYAN}Maximum Latency:${NC}  ${YELLOW}${max} ms${NC}"
        echo -e "  ${CYAN}Std Deviation:${NC}    ${WHITE}${mdev} ms${NC}"

        # Jitter calculation (approximation using mdev)
        echo -e "  ${CYAN}Jitter (approx):${NC}  ${WHITE}${mdev} ms${NC}"
        echo ""

        # Packet loss analysis
        if [ -n "$packet_loss" ]; then
            if [ "$packet_loss" -eq 0 ]; then
                echo -e "  ${GREEN}[✓] Packet Loss:${NC} ${GREEN}${packet_loss}% (Excellent)${NC}"
            elif [ "$packet_loss" -lt 5 ]; then
                echo -e "  ${YELLOW}[!] Packet Loss:${NC} ${YELLOW}${packet_loss}% (Good - Minor loss)${NC}"
            elif [ "$packet_loss" -lt 15 ]; then
                echo -e "  ${YELLOW}[!] Packet Loss:${NC} ${YELLOW}${packet_loss}% (Fair - Moderate loss)${NC}"
            else
                echo -e "  ${RED}[✗] Packet Loss:${NC} ${RED}${packet_loss}% (Poor - High loss)${NC}"
            fi
        fi

        echo ""
        echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo -e "${WHITE}  Network Quality Assessment:${NC}"
        echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo ""

        # Database connection quality assessment
        if (( $(echo "$avg < 30" | bc -l) )); then
            echo -e "  ${GREEN}★★★★★ EXCELLENT${NC}"
            echo -e "  ${WHITE}Sangat cocok untuk:${NC}"
            echo -e "    ✓ Real-time database queries"
            echo -e "    ✓ High-frequency transactions"
            echo -e "    ✓ Live replication"
            echo -e "    ✓ Gaming servers"
        elif (( $(echo "$avg < 80" | bc -l) )); then
            echo -e "  ${GREEN}★★★★☆ VERY GOOD${NC}"
            echo -e "  ${WHITE}Cocok untuk:${NC}"
            echo -e "    ✓ Standard database operations"
            echo -e "    ✓ Web applications"
            echo -e "    ✓ API calls"
            echo -e "    ⚠ Real-time apps (with minor delay)"
        elif (( $(echo "$avg < 150" | bc -l) )); then
            echo -e "  ${YELLOW}★★★☆☆ GOOD${NC}"
            echo -e "  ${WHITE}Dapat digunakan untuk:${NC}"
            echo -e "    ✓ Standard web apps"
            echo -e "    ✓ Background jobs"
            echo -e "    ⚠ Noticeable delay pada queries"
            echo -e "    ⚠ Tidak ideal untuk real-time"
        elif (( $(echo "$avg < 250" | bc -l) )); then
            echo -e "  ${YELLOW}★★☆☆☆ FAIR${NC}"
            echo -e "  ${YELLOW}Perhatian:${NC}"
            echo -e "    ⚠ Delay terasa pada operations"
            echo -e "    ⚠ Pertimbangkan caching strategy"
            echo -e "    ⚠ Gunakan connection pooling"
            echo -e "    ✗ Tidak untuk real-time apps"
        else
            echo -e "  ${RED}★☆☆☆☆ POOR${NC}"
            echo -e "  ${RED}Masalah:${NC}"
            echo -e "    ✗ Latency sangat tinggi"
            echo -e "    ✗ User experience akan buruk"
            echo -e "    ${YELLOW}Rekomendasi:${NC}"
            echo -e "    • Gunakan database lokal/regional"
            echo -e "    • Implementasi heavy caching"
            echo -e "    • Pertimbangkan CDN/Edge computing"
        fi

        echo ""

        # Specific database recommendations
        echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo -e "${WHITE}  Rekomendasi untuk Laravel Database:${NC}"
        echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo ""

        if (( $(echo "$avg > 100" | bc -l) )); then
            echo -e "  ${YELLOW}[!] Karena latency >100ms, pertimbangkan:${NC}"
            echo ""
            echo -e "  ${CYAN}1. Connection Pooling:${NC}"
            echo -e "     ${WHITE}DB_CONNECTION_POOL_SIZE=20${NC}"
            echo ""
            echo -e "  ${CYAN}2. Query Timeout di config/database.php:${NC}"
            echo -e "     ${WHITE}'options' => [${NC}"
            echo -e "       ${WHITE}PDO::ATTR_TIMEOUT => 30,${NC}"
            echo -e "     ${WHITE}]${NC}"
            echo ""
            echo -e "  ${CYAN}3. Laravel Caching:${NC}"
            echo -e "     ${WHITE}// Cache query results${NC}"
            echo -e "     ${WHITE}Cache::remember('users', 3600, fn() => DB::table('users')->get());${NC}"
            echo ""
            echo -e "  ${CYAN}4. Queue untuk heavy operations:${NC}"
            echo -e "     ${WHITE}dispatch(new ProcessDataJob(\$data));${NC}"
        fi

        if [ "$packet_loss" -gt 5 ]; then
            echo ""
            echo -e "  ${RED}[!] Packet loss detected (${packet_loss}%)${NC}"
            echo -e "  ${YELLOW}Rekomendasi:${NC}"
            echo -e "    • Enable database connection retry"
            echo -e "    • Increase timeout values"
            echo -e "    • Monitor connection stability"
        fi

        echo ""

        return 0
    else
        echo -e "${RED}[✗] Tidak dapat parsing hasil ping${NC}"
        return 1
    fi
}

# Function to test port connectivity
port_connectivity_test() {
    local host="$1"
    local port="$2"
    local db_type="${3:-database}"

    echo ""
    echo -e "${CYAN}╔═══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${NC}          ${WHITE}PORT CONNECTIVITY TEST${NC}                     ${CYAN}║${NC}"
    echo -e "${CYAN}╚═══════════════════════════════════════════════════════════╝${NC}"
    echo ""

    echo -e "${YELLOW}[*] Testing port ${WHITE}${port}${YELLOW} pada ${WHITE}${host}${NC}"
    echo -e "${CYAN}    Database Type: ${WHITE}${db_type^^}${NC}"
    echo ""

    # Test connection with timeout
    local start_time=$(date +%s%N)

    if timeout 5 bash -c "echo >/dev/tcp/$host/$port" 2>/dev/null; then
        local end_time=$(date +%s%N)
        local conn_time=$((($end_time - $start_time) / 1000000))

        echo -e "${GREEN}[✓] Port ${port} TERBUKA${NC}"
        echo -e "    ${CYAN}Connection Time:${NC} ${WHITE}${conn_time} ms${NC}"
        echo ""

        # Additional port tests with nc
        if command -v nc &> /dev/null; then
            echo -e "${YELLOW}[*] Testing dengan netcat untuk detail lebih lanjut...${NC}"

            # Test if port accepts connections
            if nc -zv -w 3 "$host" "$port" 2>&1 | grep -q "succeeded"; then
                echo -e "${GREEN}[✓] Port dapat menerima koneksi${NC}"

                # Try banner grabbing (for some services)
                echo ""
                echo -e "${CYAN}[*] Mencoba banner grabbing...${NC}"
                local banner=$(timeout 2 nc "$host" "$port" < /dev/null 2>/dev/null | head -5)
                if [ -n "$banner" ]; then
                    echo -e "${GREEN}[✓] Server Banner:${NC}"
                    echo "$banner" | while read line; do
                        echo -e "    ${WHITE}${line}${NC}"
                    done
                else
                    echo -e "${YELLOW}[*] No banner received (normal untuk beberapa database)${NC}"
                fi
            fi
        fi

        echo ""
        echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo -e "${GREEN}[✓] Database server dapat dijangkau pada port ${port}${NC}"
        echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

        return 0
    else
        echo -e "${RED}[✗] Port ${port} TERTUTUP atau DIFILTER${NC}"
        echo ""
        echo -e "${YELLOW}Kemungkinan penyebab:${NC}"
        echo -e "  1. Firewall memblokir port ${port}"
        echo -e "  2. Database service tidak running"
        echo -e "  3. Database tidak listen pada ${host}:${port}"
        echo -e "  4. Network ACL/Security Group restrictions"
        echo ""
        echo -e "${CYAN}Troubleshooting steps:${NC}"
        echo -e "  • Cek firewall rules di server database"
        echo -e "  • Pastikan database service running"
        echo -e "  • Verifikasi bind address di config database"
        echo -e "  • Cek security group/network ACL"
        echo ""

        return 1
    fi
}

# Function for traceroute analysis
traceroute_test() {
    local host="$1"

    echo ""
    echo -e "${CYAN}╔═══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${NC}             ${WHITE}NETWORK ROUTE TRACING${NC}                     ${CYAN}║${NC}"
    echo -e "${CYAN}╚═══════════════════════════════════════════════════════════╝${NC}"
    echo ""

    echo -e "${YELLOW}[*] Melacak rute network ke ${WHITE}${host}${NC}"
    echo -e "${CYAN}    Ini akan menunjukkan semua hop dari komputer Anda ke server${NC}"
    echo ""

    if ! command -v traceroute &> /dev/null; then
        echo -e "${RED}[!] traceroute tidak terinstal${NC}"
        return 1
    fi

    # Perform traceroute with max 30 hops
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    local trace_output=$(traceroute -m 30 -w 2 "$host" 2>&1)
    echo "$trace_output"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""

    # Analyze traceroute results
    local hop_count=$(echo "$trace_output" | grep -c "^ *[0-9]")
    local timeouts=$(echo "$trace_output" | grep -c "\* \* \*")

    echo -e "${WHITE}Analysis:${NC}"
    echo -e "  ${CYAN}Total Hops:${NC} ${WHITE}${hop_count}${NC}"

    if [ "$timeouts" -gt 0 ]; then
        echo -e "  ${YELLOW}Timeouts:${NC} ${YELLOW}${timeouts} hops${NC}"
        echo -e "  ${YELLOW}(Beberapa router tidak merespon ICMP, ini normal)${NC}"
    fi

    # Check for high latency hops
    echo ""
    echo -e "${CYAN}High Latency Hops:${NC}"
    echo "$trace_output" | awk '{
        for(i=1; i<=NF; i++) {
            if($i ~ /^[0-9]+\.[0-9]+$/ && $i > 100) {
                print "  ⚠ Hop " $1 ": " $i " ms"
            }
        }
    }'

    echo ""

    return 0
}

# Function for comprehensive database connection test
comprehensive_db_test() {
    local host="$1"
    local port="$2"
    local db_type="${3:-mysql}"

    clear
    echo -e "${MAGENTA}"
    echo "  ╔═══════════════════════════════════════════════════════════╗"
    echo "  ║                                                           ║"
    echo "  ║        DATABASE CONNECTION ANALYZER                       ║"
    echo "  ║        Cross-Country Connection Test                      ║"
    echo "  ║                                                           ║"
    echo "  ╚═══════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    echo ""
    echo -e "${CYAN}Target Database Server:${NC}"
    echo -e "  ${WHITE}Host:${NC} ${YELLOW}${host}${NC}"
    echo -e "  ${WHITE}Port:${NC} ${YELLOW}${port}${NC}"
    echo -e "  ${WHITE}Type:${NC} ${YELLOW}${db_type^^}${NC}"
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""

    # Test sequence
    local test_start=$(date +%s)

    # 1. DNS Resolution
    echo -e "${CYAN}[1/5] DNS Resolution Test${NC}"
    dns_resolution_test "$host"
    local dns_result=$?

    sleep 1

    # 2. Ping & Latency
    echo -e "${CYAN}[2/5] Ping & Latency Test${NC}"
    ping_test "$host" 20
    local ping_result=$?

    sleep 1

    # 3. Port Connectivity
    echo -e "${CYAN}[3/5] Port Connectivity Test${NC}"
    port_connectivity_test "$host" "$port" "$db_type"
    local port_result=$?

    sleep 1

    # 4. Traceroute
    echo -e "${CYAN}[4/5] Network Route Tracing${NC}"
    traceroute_test "$host"

    sleep 1

    # 5. Packet Loss Detail Test
    echo -e "${CYAN}[5/5] Extended Packet Loss Test${NC}"
    packet_loss_detail_test "$host"

    # Summary
    local test_end=$(date +%s)
    local test_duration=$((test_end - test_start))

    echo ""
    echo -e "${CYAN}╔═══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${NC}                  ${WHITE}TEST SUMMARY${NC}                          ${CYAN}║${NC}"
    echo -e "${CYAN}╚═══════════════════════════════════════════════════════════╝${NC}"
    echo ""

    if [ $dns_result -eq 0 ]; then
        echo -e "  ${GREEN}✓${NC} DNS Resolution: ${GREEN}PASSED${NC}"
    else
        echo -e "  ${RED}✗${NC} DNS Resolution: ${RED}FAILED${NC}"
    fi

    if [ $ping_result -eq 0 ]; then
        echo -e "  ${GREEN}✓${NC} Ping Test: ${GREEN}PASSED${NC}"
    else
        echo -e "  ${RED}✗${NC} Ping Test: ${RED}FAILED${NC}"
    fi

    if [ $port_result -eq 0 ]; then
        echo -e "  ${GREEN}✓${NC} Port Connectivity: ${GREEN}PASSED${NC}"
    else
        echo -e "  ${RED}✗${NC} Port Connectivity: ${RED}FAILED${NC}"
    fi

    echo ""
    echo -e "  ${CYAN}Total Test Duration:${NC} ${WHITE}${test_duration} seconds${NC}"
    echo ""

    # Overall verdict
    if [ $dns_result -eq 0 ] && [ $ping_result -eq 0 ] && [ $port_result -eq 0 ]; then
        echo -e "${GREEN}╔═══════════════════════════════════════════════════════════╗${NC}"
        echo -e "${GREEN}║${NC}  ${WHITE}✓ KONEKSI DATABASE DAPAT DIGUNAKAN${NC}                   ${GREEN}║${NC}"
        echo -e "${GREEN}╚═══════════════════════════════════════════════════════════╝${NC}"
    else
        echo -e "${RED}╔═══════════════════════════════════════════════════════════╗${NC}"
        echo -e "${RED}║${NC}  ${WHITE}✗ ADA MASALAH DENGAN KONEKSI DATABASE${NC}                ${RED}║${NC}"
        echo -e "${RED}╚═══════════════════════════════════════════════════════════╝${NC}"
    fi

    echo ""
}

# Function for detailed packet loss test
packet_loss_detail_test() {
    local host="$1"

    echo ""
    echo -e "${CYAN}╔═══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${NC}         ${WHITE}EXTENDED PACKET LOSS ANALYSIS${NC}                ${CYAN}║${NC}"
    echo -e "${CYAN}╚═══════════════════════════════════════════════════════════╝${NC}"
    echo ""

    echo -e "${YELLOW}[*] Testing dengan 50 packets untuk analisis lebih akurat...${NC}"
    echo ""

    local ping_output=$(ping -c 50 -i 0.2 "$host" 2>&1)
    local packet_loss=$(echo "$ping_output" | grep -oP '\d+(?=% packet loss)' | head -1)

    if [ -n "$packet_loss" ]; then
        if [ "$packet_loss" -eq 0 ]; then
            echo -e "${GREEN}[✓] Packet Loss: 0% - EXCELLENT${NC}"
            echo -e "    Koneksi sangat stabil untuk database operations"
        elif [ "$packet_loss" -lt 2 ]; then
            echo -e "${GREEN}[✓] Packet Loss: ${packet_loss}% - VERY GOOD${NC}"
            echo -e "    Koneksi stabil, loss minimal dapat diabaikan"
        elif [ "$packet_loss" -lt 5 ]; then
            echo -e "${YELLOW}[!] Packet Loss: ${packet_loss}% - GOOD${NC}"
            echo -e "    Koneksi cukup stabil, pertimbangkan retry logic"
        elif [ "$packet_loss" -lt 10 ]; then
            echo -e "${YELLOW}[!] Packet Loss: ${packet_loss}% - FAIR${NC}"
            echo -e "    ${YELLOW}Rekomendasi:${NC}"
            echo -e "    • Implementasi connection retry"
            echo -e "    • Increase timeout values"
            echo -e "    • Monitor untuk pattern tertentu"
        else
            echo -e "${RED}[✗] Packet Loss: ${packet_loss}% - POOR${NC}"
            echo -e "    ${RED}Masalah serius:${NC}"
            echo -e "    • Koneksi tidak stabil"
            echo -e "    • Database queries akan sering timeout"
            echo -e "    • Pertimbangkan alternatif routing atau ISP"
        fi
    fi

    echo ""
}

# Check requirements first
check_requirements

# Main menu
clear
echo -e "${CYAN}"
echo "  ╔═══════════════════════════════════════════════════════════╗"
echo "  ║                                                           ║"
echo "  ║        DATABASE CONNECTION ANALYZER                       ║"
echo "  ║        Cross-Country Database Testing Tool                ║"
echo "  ║                                                           ║"
echo "  ╚═══════════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo ""
echo -e "${WHITE}  Tool ini membantu menganalisis koneksi database yang berada${NC}"
echo -e "${WHITE}  di server lain/negara lain untuk Laravel atau aplikasi lainnya${NC}"
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${GREEN}[1]${NC} ${WHITE}Quick Test${NC}"
echo -e "      ${CYAN}Test cepat koneksi database (DNS + Ping + Port)${NC}"
echo ""
echo -e "  ${GREEN}[2]${NC} ${WHITE}Comprehensive Test${NC}"
echo -e "      ${CYAN}Test lengkap dengan traceroute & packet loss analysis${NC}"
echo ""
echo -e "  ${GREEN}[3]${NC} ${WHITE}Latency Only${NC}"
echo -e "      ${CYAN}Test latency saja (ping detailed)${NC}"
echo ""
echo -e "  ${GREEN}[4]${NC} ${WHITE}Port Check Only${NC}"
echo -e "      ${CYAN}Cek apakah port database terbuka${NC}"
echo ""
echo -e "  ${GREEN}[5]${NC} ${WHITE}Traceroute Only${NC}"
echo -e "      ${CYAN}Lihat routing path ke server${NC}"
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "  ${RED}[0]${NC} Kembali ke Main Menu"
echo ""

echo -ne "  ${CYAN}Pilih opsi [0-5]: ${NC}"
read choice

case $choice in
    1|2|3|4|5)
        echo ""
        echo -ne "${CYAN}Masukkan hostname/IP database server: ${NC}"
        read db_host

        if [ -z "$db_host" ]; then
            echo -e "${RED}[!] Host tidak boleh kosong${NC}"
            exit 1
        fi

        echo ""
        echo -e "${CYAN}Pilih tipe database:${NC}"
        echo -e "  ${GREEN}[1]${NC} MySQL/MariaDB (port 3306)"
        echo -e "  ${GREEN}[2]${NC} PostgreSQL (port 5432)"
        echo -e "  ${GREEN}[3]${NC} MongoDB (port 27017)"
        echo -e "  ${GREEN}[4]${NC} Redis (port 6379)"
        echo -e "  ${GREEN}[5]${NC} MSSQL (port 1433)"
        echo -e "  ${GREEN}[6]${NC} Custom port"
        echo ""
        echo -ne "${CYAN}Pilih [1-6]: ${NC}"
        read db_choice

        case $db_choice in
            1) db_type="mysql"; db_port="3306" ;;
            2) db_type="postgresql"; db_port="5432" ;;
            3) db_type="mongodb"; db_port="27017" ;;
            4) db_type="redis"; db_port="6379" ;;
            5) db_type="mssql"; db_port="1433" ;;
            6)
                echo -ne "${CYAN}Masukkan port: ${NC}"
                read db_port
                db_type="custom"
                ;;
            *)
                echo -e "${YELLOW}[*] Menggunakan default MySQL (port 3306)${NC}"
                db_type="mysql"
                db_port="3306"
                ;;
        esac

        case $choice in
            1)
                # Quick test
                dns_resolution_test "$db_host"
                ping_test "$db_host" 10
                port_connectivity_test "$db_host" "$db_port" "$db_type"
                ;;
            2)
                # Comprehensive test
                comprehensive_db_test "$db_host" "$db_port" "$db_type"
                ;;
            3)
                # Latency only
                ping_test "$db_host" 30
                ;;
            4)
                # Port check only
                port_connectivity_test "$db_host" "$db_port" "$db_type"
                ;;
            5)
                # Traceroute only
                traceroute_test "$db_host"
                ;;
        esac
        ;;
    0)
        exit 0
        ;;
    *)
        echo -e "  ${RED}Pilihan tidak valid${NC}"
        exit 1
        ;;
esac

echo ""
echo -e "${YELLOW}Tekan ENTER untuk kembali...${NC}"
read
