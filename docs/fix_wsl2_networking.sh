#!/usr/bin/env bash

set -euo pipefail

readonly PATH=/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin

readonly WSL_CONF="/etc/wsl.conf"
readonly RESOLV_CONF="/etc/resolv.conf"
readonly LOG_FILE="/var/log/fix_wsl2_networking.log"
SCRIPT_NAME="$(basename "$0")"
readonly SCRIPT_NAME
readonly VERSION="2.0.0"

if [[ -t 1 ]]; then
    RED=$'\033[0;31m'
    GREEN=$'\033[0;32m'
    YELLOW=$'\033[1;33m'
    CYAN=$'\033[0;36m'
    BOLD=$'\033[1m'
    RESET=$'\033[0m'
else
    RED='' GREEN='' YELLOW='' CYAN='' BOLD='' RESET=''
fi

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

declare -g PRIM_DNS="" SEC_DNS="" SELECTED_PROVIDER=""
DRY_RUN=false

_log() {
    local level="$1"; shift
    local timestamp
    timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    echo "${timestamp} [${level}] $*" >> "$LOG_FILE"
}

info()    { echo -e "${GREEN}[+]${RESET} $*";    _log INFO  "$*"; }
warn()    { echo -e "${YELLOW}[!]${RESET} $*";   _log WARN  "$*"; }
error()   { echo -e "${RED}[✗]${RESET} $*" >&2; _log ERROR "$*"; }
success() { echo -e "${GREEN}[✓]${RESET} $*";    _log INFO  "$*"; }

is_wsl2() {
    [[ -f /proc/sys/fs/binfmt_misc/WSLInterop ]] \
        || grep -qi "microsoft" /proc/version 2>/dev/null
}

immutable_on() {
    if ! chattr +i "$1" 2>/dev/null; then
        warn "Could not set immutable flag on $1 (filesystem may not support chattr)."
    fi
}

immutable_off() {
    chattr -i "$1" 2>/dev/null || true
}

backup_file() {
    local file="$1"
    if [[ -f "$file" ]]; then
        local backup
        backup="${file}.bak.$(date +%Y%m%d_%H%M%S)"
        cp "$file" "$backup"
        info "Backup saved: ${BOLD}${backup}${RESET}"
    fi
}

usage() {
    cat <<EOF

${BOLD}Usage:${RESET} sudo ${SCRIPT_NAME} [OPTIONS]

Permanently fix WSL2 DNS networking issues by setting static DNS servers.

${BOLD}Options:${RESET}
  --dns <provider>   Use a specific DNS provider (non-interactive)
  -y, --yes          Skip confirmation prompt
  --undo             Remove immutable flags and delete config files
  --dry-run          Preview changes without modifying anything
  -h, --help         Show this help message
  --version          Show version number

${BOLD}Available DNS providers:${RESET}
$(printf '%s\n' "${!DNS_SERVERS[@]}" | sort | while read -r key; do
    printf "  %-18s %s\n" "$key" "${DNS_SERVERS[$key]}"
done)

${BOLD}Examples:${RESET}
  sudo ${SCRIPT_NAME}
  sudo ${SCRIPT_NAME} --dns Cloudflare
  sudo ${SCRIPT_NAME} --dns Quad9 --yes
  sudo ${SCRIPT_NAME} --dry-run
  sudo ${SCRIPT_NAME} --undo

EOF
}

select_dns_servers() {
    local preset="${1:-}"

    local sorted_keys=()
    while IFS= read -r key; do
        sorted_keys+=("$key")
    done < <(printf '%s\n' "${!DNS_SERVERS[@]}" | sort)

    if [[ -n "$preset" ]]; then
        if [[ -z "${DNS_SERVERS[$preset]+_}" ]]; then
            error "Unknown DNS provider: '${preset}'"
            echo -e "  Available: ${sorted_keys[*]}" >&2
            exit 1
        fi
        SELECTED_PROVIDER="$preset"
    else
        echo -e "  ${BOLD}Available DNS providers:${RESET}"
        echo -e "  ${CYAN}$(printf '─%.0s' {1..44})${RESET}"

        local index=1
        local choices=()

        for key in "${sorted_keys[@]}"; do
            printf "  ${CYAN}%2d)${RESET}  %-18s ${YELLOW}%s${RESET}\n" \
                "$index" "$key" "${DNS_SERVERS[$key]}"
            choices[index]="$key"
            ((index++))
        done

        echo -e "  ${CYAN}$(printf '─%.0s' {1..44})${RESET}"
        echo
        read -rp "  Your choice [1-$((index - 1))]: " user_choice
        echo

        if ! [[ "$user_choice" =~ ^[1-9][0-9]*$ ]] \
            || (( user_choice < 1 || user_choice >= index )); then
            error "Invalid input: '${user_choice}'. Enter a number between 1 and $((index - 1))."
            exit 1
        fi

        SELECTED_PROVIDER="${choices[user_choice]}"
    fi

    read -r PRIM_DNS SEC_DNS <<< "${DNS_SERVERS[$SELECTED_PROVIDER]}"
    info "Selected: ${BOLD}${SELECTED_PROVIDER}${RESET} — primary ${PRIM_DNS}, secondary ${SEC_DNS}"
}

confirm() {
    echo -e "  ${YELLOW}The following changes will be made:${RESET}"
    echo -e "  • ${BOLD}${WSL_CONF}${RESET}   → [network] generateResolvConf=false  ${CYAN}(immutable)${RESET}"
    echo -e "  • ${BOLD}${RESOLV_CONF}${RESET} → nameserver ${PRIM_DNS} / ${SEC_DNS}  ${CYAN}(immutable)${RESET}"
    echo -e "  • Existing files will be backed up before modification."
    echo
    read -rp "  Proceed? [y/N] " answer
    echo
    [[ "${answer,,}" =~ ^(y|yes)$ ]]
}

setup_wsl_conf() {
    info "Configuring ${BOLD}${WSL_CONF}${RESET}..."

    if $DRY_RUN; then
        warn "[dry-run] Would write [network] generateResolvConf=false to ${WSL_CONF}"
        return
    fi

    backup_file "$WSL_CONF"
    immutable_off "$WSL_CONF"
    rm -f "$WSL_CONF"

    cat > "$WSL_CONF" << 'EOF'
[network]
generateResolvConf=false
EOF

    immutable_on "$WSL_CONF"
    success "${WSL_CONF} configured."
}

setup_resolv_conf() {
    info "Configuring ${BOLD}${RESOLV_CONF}${RESET}..."

    if $DRY_RUN; then
        warn "[dry-run] Would write nameserver ${PRIM_DNS} / ${SEC_DNS} to ${RESOLV_CONF}"
        return
    fi

    backup_file "$RESOLV_CONF"
    immutable_off "$RESOLV_CONF"
    rm -f "$RESOLV_CONF"

    cat > "$RESOLV_CONF" << EOF
nameserver ${PRIM_DNS}
nameserver ${SEC_DNS}
EOF

    immutable_on "$RESOLV_CONF"
    success "${RESOLV_CONF} configured."
}

undo() {
    warn "Removing immutable flags and deleting DNS configuration..."
    immutable_off "$WSL_CONF"
    immutable_off "$RESOLV_CONF"
    rm -f "$WSL_CONF" "$RESOLV_CONF"
    success "Done. WSL2 will regenerate DNS configuration on next restart."
    _log INFO "Undo performed."
}

validate_dns() {
    $DRY_RUN && return
    info "Testing DNS resolution..."
    if command -v nslookup &>/dev/null \
        && nslookup google.com "$PRIM_DNS" &>/dev/null; then
        success "DNS resolution working via ${PRIM_DNS}."
    elif ping -c1 -W2 "$PRIM_DNS" &>/dev/null; then
        success "DNS server ${PRIM_DNS} is reachable."
        warn "nslookup not available — run 'nslookup google.com' after restart to confirm."
    else
        warn "Could not verify DNS resolution. Test manually after restarting WSL2."
    fi
}

main() {
    local dns_preset=""
    local do_undo=false
    local assume_yes=false

    while [[ $# -gt 0 ]]; do
        case "$1" in
            --clear)    clear ;;
            -h|--help)  usage; exit 0 ;;
            --version)  echo "${SCRIPT_NAME} v${VERSION}"; exit 0 ;;
            --dry-run)  DRY_RUN=true ;;
            --undo)     do_undo=true ;;
            -y|--yes)   assume_yes=true ;;
            --dns)
                [[ $# -lt 2 ]] && { error "--dns requires a provider name."; exit 1; }
                dns_preset="$2"
                shift
                ;;
            *) error "Unknown option: $1"; usage; exit 1 ;;
        esac
        shift
    done

    echo
    echo -e "  ${BOLD}fix_wsl2_networking${RESET} ${CYAN}v${VERSION}${RESET}"
    echo -e "  Permanent WSL2 DNS fix"
    echo

    if ! is_wsl2; then
        warn "This system does not appear to be running WSL2. Proceeding anyway."
        echo
    fi

    $DRY_RUN && warn "Dry-run mode enabled — no changes will be made."

    if $do_undo; then
        undo
        exit 0
    fi

    select_dns_servers "$dns_preset"
    echo

    if ! $DRY_RUN && ! $assume_yes; then
        confirm || { warn "Aborted."; exit 0; }
    fi

    setup_wsl_conf
    setup_resolv_conf
    validate_dns

    echo
    echo -e "  ${BOLD}${GREEN}All done!${RESET} Restart WSL2 for changes to take full effect:"
    echo -e "  ${CYAN}  wsl --shutdown${RESET}   (run from PowerShell or CMD)"
    echo
}

for arg in "$@"; do
    case "$arg" in
        -h|--help)  main --help ;;
        --version)  main --version ;;
    esac
done

if [[ $EUID -ne 0 ]]; then
    echo "Error: This script requires administrator privileges. Please run with sudo or as root." >&2
    exit 1
fi

main "$@"
