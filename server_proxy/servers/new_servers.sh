#!/bin/bash

DIRECTORY=/root/scripts/server_proxy/servers

while [ option != "0" ]
do
  clear;echo
  echo -e "\e[31mSELECT SERVER TYPE MENU"; tput sgr0
  echo ""
  echo "1         Add as Single Server"
  echo "2         Add Server to Load-Balancing"
  echo ""
  read -p "Option: " option
 	case $option in
    1)
      echo "Adding as Single Server..."
      /bin/bash $DIRECTORY/single_server_new.sh
      break;;
    2)
      echo "Adding Server to Load-Balancing..."
      /bin/bash $DIRECTORY/load_balancing_menu.sh
      break;;
    *)
      echo "Not a Valid Selection at SERVER TYPE MENU"
      break;;
  esac
  echo "Press ENTER to go back to MENU";
done
