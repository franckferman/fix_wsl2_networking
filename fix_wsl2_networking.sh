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
        echo -n ${red}Error, please run the script with the command ${green}sudo ./fix_wsl2_networking.sh${reset}
        exit $error
    else
        main
    fi
}

main()
{
success=0

sudo echo [network]>/etc/wsl.conf
sudo echo -n generateResolvConf=false>>/etc/wsl.conf
sudo chattr +i /etc/wsl.conf

sudo rm /etc/resolv.conf
sudo touch /etc/resolv.conf
sudo echo "nameserver 1.1.1.1">/etc/resolv.conf
sudo echo "nameserver 1.0.0.1">>/etc/resolv.conf
sudo chattr +i /etc/resolv.conf

exit $success
}

Check_AdminRights