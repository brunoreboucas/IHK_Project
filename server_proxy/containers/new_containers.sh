#!/bin/bash

DIRECTORY=/root/scripts/server_proxy/containers

while [ option != "0" ]
do
  clear;echo
  echo -e "\e[31mSELECT CONTAINER TYPE MENU"; tput sgr0
  echo ""
  echo "1         Add as Single Server"
  echo "2         Add Container to Load-Balancing"
  echo ""
  read -p "Option: " option
 	case $option in
    1)
      echo "Adding as Single Server..."
      /bin/bash $DIRECTORY/single_container_new.sh
      break;;
    2)
      echo "Adding Container to Load-Balancing..."
      /bin/bash $DIRECTORY/container_balancing_menu.sh
      break;;
    *)
      echo "Not a valid selection in CONTAINERS TYPE MENU"
      break;;
  esac
  echo "Press ENTER to go back to MENU";
done
