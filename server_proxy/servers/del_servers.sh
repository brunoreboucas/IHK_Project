#!/bin/bash

DIRECTORY=/root/scripts/server_proxy/servers

while [ option != "0" ]
do
  clear;echo
  echo -e "\e[31mSELECT SERVER TYPE MENU TO DELETE"; tput sgr0
  echo ""
  echo "1         Delete Single Server"
  echo "2         Delete Server from Load-Balancing"
  echo ""
  read -p "Option: " option
 	case $option in
    1)
      echo "Delete Single Server..."
      /bin/bash $DIRECTORY/single_server_del.sh
      break;;
    2)
      echo "Delete Server from Load-Balancing..."
      /bin/bash $DIRECTORY/load_balancing_del.sh
      break;;
    *)
      echo "Not a Valid Selection at SERVER TYPE MENU TO DELETE"
      break;;
  esac
  echo "Press ENTER to go back to MENU";
done
