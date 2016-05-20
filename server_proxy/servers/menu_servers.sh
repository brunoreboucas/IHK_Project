#!/bin/bash

DIRECTORY=/root/scripts/server_proxy/servers

while [ option != "0" ]
do
  clear;echo
  echo -e "\e[31mSERVER MENU"; tput sgr0
  echo ""
  echo "1         Show Servers"
  echo "2         Add Server"
  echo "3         Delete Server"
  echo ""
  read -p "Option: " option

 	case $option in
    1)
      echo "Showing Servers..."
      /bin/bash $DIRECTORY/show_servers.sh
      break;;
    2)
      echo "Adding Server..."
      /bin/bash $DIRECTORY/new_servers.sh
      break;;
    3)
      echo "Deleting Server..."
      /bin/bash $DIRECTORY/del_servers.sh
      break;;
    *)
      echo "Not a Valid Selection at SERVER MENU"
      break;;
  esac

  echo "Press ENTER to go back to MENU";
done
