#!/bin/bash

DIRECTORY=/root/scripts/server_proxy/containers

while [ option != "0" ]
do
  clear;echo
  echo -e "\e[31mCONTAINERS MENU"; tput sgr0
  echo ""
  echo "1         Show Containers"
  echo "2         Add Container"
  echo "3         Delete Container"
  echo ""
  read -p "Option: " option

 	case $option in
    1)
      echo "Show Containers..."
      /bin/bash $DIRECTORY/show_containers.sh
      break;;
    2)
      echo "Adding Container..."
      /bin/bash $DIRECTORY/new_containers.sh
      break;;
    3)
      echo "Deleting Container..."
      /bin/bash $DIRECTORY/del_containers.sh
      break;;
    *)
      echo "Not a valid selection in CONTAINERS MENU"
      break;;
  esac

  echo "Press ENTER to go back to MENU";
done
