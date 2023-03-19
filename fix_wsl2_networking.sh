#!/usr/bin/env bash
# fix_wsl2_networking.sh

set -euo pipefail

readonly PATH=/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin

set_vars() {
  prim_dns=""
  sec_dns=""
  readonly WSL_CONF_DIR="/etc/wsl.conf"
  readonly RESOLV_CONF_DIR="/etc/resolv.conf"
}

log_error() {
  local message="$1"
  readonly LOG_FILE="/var/log/fix_wsl2_networking.log"
  local timestamp=$(date "+%Y-%m-%d %H:%M:%S")

  echo "${timestamp} ERROR: ${message}" >> "$LOG_FILE"
}

select_dns_servers() {
    declare -A dns_servers=(
        ["Cloudflare"]="1.1.1.1, 1.0.0.1"
        ["Google"]="8.8.8.8, 8.8.4.4"
        ["FDN"]="80.67.169.12, 80.67.169.40"
	["Digitalcourage"]="85.214.20.141, 46.182.19.48"
        ["Quad9"]="9.9.9.9, 149.112.112.112"
        ["OpenDNS"]="208.67.222.222, 208.67.220.220"
	["DNSWatch"]="84.200.69.80, 84.200.70.40"
	["Comodo"]="8.26.56.26, 8.20.247.20"
	["Mullvad"]="100.64.0.31, 100.64.0.30"
    )

    echo "Which DNS servers do you want to choose?"
    echo 
    count=1
    for server in "${!dns_servers[@]}"; do
        echo "${count} - ${server} (${dns_servers[$server]})"
        ((count++))
    done
    echo

	read -rp "Your choice: " user_choice
	if ! [[ "$user_choice" =~ ^[1-9][0-9]*$ ]] || (( user_choice < 1 )) || (( user_choice > ${#dns_servers[@]} )); then
    		log_error "Invalid input: $user_choice"
    		echo "Error: Invalid input. Please enter a number between 1 and ${#dns_servers[@]}." >&2
    		exit 1
	fi

    local selected_dns=(${dns_servers[$(echo "${!dns_servers[@]}" | tr ' ' '\n' | sed -n "${user_choice}p")]//,/ })
    PRIM_DNS="${selected_dns[0]}"
    SEC_DNS="${selected_dns[1]}"
}

setup_wsl_conf() {
  if [[ -f "$WSL_CONF_DIR" ]]; then
  
    if [[ "$(lsattr -d "$WSL_CONF_DIR" | cut -c 5)" == "i" ]]; then
      chattr -i "$WSL_CONF_DIR" &> "/dev/null"
    fi

    rm -f "$WSL_CONF_DIR"
  fi

  bash -c "cat > \"$WSL_CONF_DIR\" <<- EOM
[network]
generateResolvConf=false
EOM"

  chattr +i "$WSL_CONF_DIR" &> "/dev/null"
}

setup_resolv_conf() {
  if [[ -f "$RESOLV_CONF_DIR" ]]; then

    if [[ "$(lsattr -d "$RESOLV_CONF_DIR" | cut -c 5)" == "i" ]]; then
      chattr -i "$RESOLV_CONF_DIR" &> "/dev/null"
    fi

    rm -f "$RESOLV_CONF_DIR"
  fi

  bash -c "cat > \"$RESOLV_CONF_DIR\" <<- EOM
nameserver $PRIM_DNS
nameserver $SEC_DNS
EOM"
  chattr +i "$RESOLV_CONF_DIR" &> "/dev/null"
}

main() {
clear
set_vars
select_dns_servers
setup_wsl_conf
setup_resolv_conf
exit 0
}

if [[ $EUID -ne 0 ]]; then
	echo "Error: This script requires administrator privileges. Please run this script with sudo or as root." >&2
	exit 1
fi

main

