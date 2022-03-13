#!/usr/bin/env bash

Check_AdminRights()
{
UID_ROOT=0
ERROR=77
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

if [ "$UID" -ne "$UID_ROOT" ]
then
  echo "${red}Sorry, you must run this script as root.${reset}"
  exit $ERROR
  else
    main
fi
}

main()
{
SUCCESSFUL=0
sudo chattr -i /etc/wsl.conf>/dev/null
sudo rm /etc/wsl.conf>/dev/null

sudo echo "[network]">/etc/wsl.conf
sudo echo "generateResolvConf=false">>/etc/wsl.conf
sudo chattr +i /etc/wsl.conf

sudo chattr -i /etc/resolv.conf>/dev/null
sudo rm /etc/resolv.conf>/dev/null

sudo echo "nameserver 1.1.1.1">/etc/resolv.conf
sudo echo "nameserver 1.0.0.1">>/etc/resolv.conf
sudo chattr +i /etc/resolv.conf

exit $SUCCESSFUL
}

Check_AdminRights
