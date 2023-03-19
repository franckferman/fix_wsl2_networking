#!/usr/bin/env bash
# fix_wsl2_networking.sh

red=$(tput setaf 1)
green=$(tput setaf 2)
reset=$(tput sgr0)

error=77

check_admin_rights() {
    uid_root=0

    if [ "$UID" -ne "$uid_root" ]; then
        echo "${red}Error, please run the script with sudo.${reset}"
        exit $error
    else
        main
    fi
}

main() {
    wsl_conf_dir="/etc/wsl.conf"
    resolv_conf_dir="/etc/resolv.conf"
    success=0

    clear
    echo "Which DNS servers do you want to choose?"
    echo 
    echo "1 - Cloudflare."
    echo "2 - Google."
    echo "3 - FDN (French Data Network)."
    echo "4 - Quad9."
    echo
    read -rp "Your choice: " user_choice

    case "$user_choice" in
        1) prim_dns="1.1.1.1"; sec_dns="1.0.0.1" ;;
        2) prim_dns="8.8.8.8"; sec_dns="8.8.4.4" ;;
        3) prim_dns="80.67.169.12"; sec_dns="80.67.169.40" ;;
        4) prim_dns="9.9.9.9"; sec_dns="149.112.112.112" ;;
        *)
            echo "${red}Error, please select a valid choice: Only a number (from the list of choices) is expected as an answer.${reset}"
            exit $error
            ;;
    esac

    [ -f "$wsl_conf_dir" ] && sudo chattr -i "$wsl_conf_dir" &> "/dev/null" && sudo rm -f "$wsl_conf_dir"

    sudo bash -c "cat > \"$wsl_conf_dir\" <<- EOM
[network]
generateResolvConf=false
EOM"
    sudo chattr +i "$wsl_conf_dir" &> "/dev/null"

    [ -f "$resolv_conf_dir" ] && sudo chattr -i "$resolv_conf_dir" &> "/dev/null" && sudo rm -f "$resolv_conf_dir"

    sudo bash -c "cat > \"$resolv_conf_dir\" <<- EOM
nameserver $prim_dns
nameserver $sec_dns
EOM"
    sudo chattr +i "$resolv_conf_dir" &> "/dev/null"

    exit $success
}

check_admin_rights

