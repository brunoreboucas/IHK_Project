#!/bin/bash

DIRECTORY=/root/scripts/server_proxy/users

while [ option != "0" ]
do
  clear;echo
  echo -e "\e[31mUSERS MENU"; tput sgr0
  echo ""
  echo "1         Show Users"
  echo "2         Add User"
  echo "3         Update User"
  echo "4         Delete User"
  echo ""
  read -p "Option: " option
 	case $option in
    1)
      echo "Show Users..."
      /bin/bash $DIRECTORY/show_users.sh
      break;;
    2)
      echo "Adding User..."
      /bin/bash $DIRECTORY/new_users.sh
      break;;
    3)
      echo "Updating User..."
      /bin/bash $DIRECTORY/update_users.sh
      break;;
    4)
      echo "Deleting User..."
      /bin/bash $DIRECTORY/del_users.sh
      break;;
    *)
      echo "Not a Valid Selection at USERS Menu"
      break;;
  esac
  echo "Press ENTER to go back to MENU";
done
