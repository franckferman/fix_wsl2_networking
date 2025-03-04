#!/usr/bin/env bash
# fix_wsl2_networking.sh

set -euo pipefail

readonly PATH=/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin

readonly WSL_CONF_DIR="/etc/wsl.conf"
readonly RESOLV_CONF_DIR="/etc/resolv.conf"
readonly LOG_FILE="/var/log/fix_wsl2_networking.log"

declare -A DNS_SERVERS=(
    ["Cloudflare"]="1.1.1.1 1.0.0.1"
    ["Google"]="8.8.8.8 8.8.4.4"
    ["FDN"]="80.67.169.12 80.67.169.40"
    ["Digitalcourage"]="85.214.20.141 46.182.19.48"
    ["Quad9"]="9.9.9.9 149.112.112.112"
    ["OpenDNS"]="208.67.222.222 208.67.220.220"
    ["DNSWatch"]="84.200.69.80 84.200.70.40"
    ["Comodo"]="8.26.56.26 8.20.247.20"
    ["Mullvad"]="194.242.2.9 194.242.2.2"
)

log_error() {
    local message="$1"
    local timestamp
    timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    echo "${timestamp} ERROR: ${message}" >> "$LOG_FILE"
}

select_dns_servers() {
    echo
    echo "Which DNS servers do you want to choose?"
    echo

    local index=1
    local choices=()

    for server in "${!DNS_SERVERS[@]}"; do
        echo "$index - $server (${DNS_SERVERS[$server]})"
        choices[index]="$server"
        ((index++))
    done

    echo
    read -rp "Your choice: " user_choice
    echo

    if ! [[ "$user_choice" =~ ^[1-9][0-9]*$ ]] || (( user_choice < 1 || user_choice >= index )); then
        log_error "Invalid input: $user_choice"
        echo "Error: Invalid input. Please enter a number between 1 and $((index - 1))." >&2
        exit 1
    fi

    local selected_dns="${choices[user_choice]}"
    read -r PRIM_DNS SEC_DNS <<< "${DNS_SERVERS[$selected_dns]}"
}

setup_wsl_conf() {
    chattr -i "$WSL_CONF_DIR" 2>/dev/null || true
    rm -f "$WSL_CONF_DIR"

    cat > "$WSL_CONF_DIR" <<- EOM
[network]
generateResolvConf=false
EOM

    chattr +i "$WSL_CONF_DIR" 2>/dev/null || true
}

setup_resolv_conf() {
    chattr -i "$RESOLV_CONF_DIR" 2>/dev/null || true
    rm -f "$RESOLV_CONF_DIR"

    cat > "$RESOLV_CONF_DIR" <<- EOM
nameserver $PRIM_DNS
nameserver $SEC_DNS
EOM

    chattr +i "$RESOLV_CONF_DIR" 2>/dev/null || true
}

main() {
    [[ "${1:-}" == "--clear" ]] && clear

    select_dns_servers
    setup_wsl_conf
    setup_resolv_conf
    echo "WSL2 networking fixed successfully!"
    echo
}

if [[ $EUID -ne 0 ]]; then
    echo "Error: This script requires administrator privileges. Please run this script with sudo or as root." >&2
    exit 1
fi

main "$@"
