#!/bin/bash

DIRECTORY=/root/scripts/server_proxy

while [ option != "0" ]
do
  clear;echo
  echo -e "\e[31mPROXY SERVER MENU"; tput sgr0
  echo ""
  echo "1         Users"
  echo "2         Servers"
  echo "3         Containers"
  echo ""
  read -p "Option: " option

 	case $option in
    1)
      /bin/bash $DIRECTORY/users/menu_users.sh
      break;;
    2)
      /bin/bash $DIRECTORY/servers/menu_servers.sh
      break;;
    3)
      /bin/bash $DIRECTORY/containers/menu_containers.sh
      break;;
    *)
      echo "Not a valid selection in PROXY SERVER MENU"
      break;;
  esac

  echo "Press ENTER to go back to MENU";
done
