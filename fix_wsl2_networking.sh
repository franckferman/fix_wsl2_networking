#!/usr/bin/env bash
#: fix_wsl2_networking.sh

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

error=77

Check_AdminRights()
{
uid_root=0

    if [ "$UID" -ne "$uid_root" ]
        then
        echo "${red}Error, please run the script with sudo.${reset}"
        exit $error
    
    elif [ "$UID" -eq "$uid_root" ]
        then
        main

    else
        echo
        echo "${red}An unexpected error was caused.${reset}"
        exit $error

    fi
}

main()
{
wslConfDir="/etc/wsl.conf"
resolvConfDir="/etc/resolv.conf"
success=0

clear
echo "Which DNS servers do you want to choose?"
echo 
echo "1 - Cloudflare."
echo "2 - Google."
echo "3 - FDN (French Data Network)."
echo "4 - Quad9."
echo
read -p "Your choice: " userChoice

    if [ "$userChoice" -eq "1" ]
        then
        primDNS="1.1.1.1"
        secDNS="1.0.0.1"
    
    elif [ "$userChoice" -eq "2" ]
        then
        primDNS="8.8.8.8"
        secDNS="8.8.4.4"
    
    elif [ "$userChoice" -eq "3" ]
        then
        primDNS="80.67.169.12"
        secDNS="80.67.169.40"
    
    elif [ "$userChoice" -eq "4" ]
        then
        primDNS="9.9.9.9"
        secDNS="149.112.112.112"
    
    elif [ "$userChoice" -ge "5" ]
        then
        echo
        echo "${red}Error, please select a valid choice: Only a number (from the list of choices) is expected as an answer.${reset}"
        exit $error
    
    elif [ "$userChoice" -le "0" ]
        then
        echo
        echo "${red}Error, please select a valid choice: Only a number (from the list of choices) is expected as an answer.${reset}"
        exit $error
    
    else
        echo
        echo "${red}An unexpected error was caused.${reset}"
        exit $error

    fi

    if [ -f "$wslConfDir" ]; then
        sudo chattr -i "$wslConfDir"&>"/dev/null"
        sudo rm -f "$wslConfDir"
    fi

sudo echo "[network]">"$wslConfDir"
sudo echo "generateResolvConf=false">>"$wslConfDir"
sudo chattr +i "$wslConfDir"&>"/dev/null"

    if [ -f "$resolvConfDir" ]; then
        sudo chattr -i "$resolvConfDir"&>"/dev/null"
        sudo rm -f "$resolvConfDir"
    fi

sudo touch "$resolvConfDir"
sudo echo "nameserver $primDNS">"$resolvConfDir"
sudo echo "nameserver $secDNS">>"$resolvConfDir"
sudo chattr +i "$resolvConfDir"&>"/dev/null"

exit $success
}

Check_AdminRights
