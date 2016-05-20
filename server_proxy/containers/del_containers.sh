#!/bin/bash

DIRECTORY=/root/scripts/server_proxy/containers

while [ option != "0" ]
do
  clear;echo
  echo -e "\e[31mSELECT CONTAINER TYPE TO DELETE MENU"; tput sgr0
  echo ""
  echo "1         Delete Single Server Container"
  echo "2         Delete Container from Load-Balancing"
  echo ""
  read -p "Option: " option
 	case $option in
    1)
      echo "Delete Single Container..."
      /bin/bash $DIRECTORY/single_container_del.sh
      break;;
    2)
      echo "Delete Container from Load-Balancing..."
      /bin/bash $DIRECTORY/container_balancing_del.sh
      break;;
    *)
      echo "Not a valid selection in CONTAINER TYPE TO DELETE MENU"
      break;;
  esac
  echo "Press ENTER to go back to MENU";
done
