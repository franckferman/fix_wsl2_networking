#!/usr/bin/env bash
#: fix_wsl2_networking.sh

Check_AdminRights()
{
uid_root=0
error=77

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

    if [ "$UID" -ne "$uid_root" ]
        then
        echo -n "${red}Error, please run the script with the command ${green}sudo ./fix_wsl2_networking.sh${reset}"
        exit $error
    else
        main
    fi
}

main()
{
success=0
error=77

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

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
    fi

    if [ "$userChoice" -eq "2" ]
        then
        primDNS="8.8.8.8"
        secDNS="8.8.4.4"
    fi

    if [ "$userChoice" -eq "3" ]
        then
        primDNS="80.67.169.12"
        secDNS="80.67.169.40"
    fi

    if [ "$userChoice" -eq "4" ]
        then
        primDNS="9.9.9.9"
        secDNS="149.112.112.112"
    fi

    if [ "$userChoice" -ge "5" ]
        then
        echo
        echo -n "${red}Error, please select a valid choice: Only a number (from the list of choices) is expected as an answer.${reset}"
        exit $error
    fi

    if [ "$userChoice" -le "0" ]
        then
        echo
        echo -n "${red}Error, please select a valid choice: Only a number (from the list of choices) is expected as an answer.${reset}"
        exit $error
    fi

file="/etc/wsl.conf"
    if [ -f "/etc/wsl.conf" ]; then
        sudo chattr -i "$file" &>/dev/null
        sudo rm "$file"
    fi

sudo echo "[network]">$file
sudo echo "generateResolvConf=false">>$file
sudo chattr +i $file &>/dev/null

file="/etc/resolv.conf"
    if [ -f "/etc/resolv.conf" ]; then
        sudo chattr -i "$file" &>/dev/null
        sudo rm "$file"
    fi

sudo touch $file
sudo echo "nameserver $primDNS">$file
sudo echo "nameserver $secDNS">>$file
sudo chattr +i $file &>/dev/null

exit $success
}

Check_AdminRights