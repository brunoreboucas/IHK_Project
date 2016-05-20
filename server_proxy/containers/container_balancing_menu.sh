#!/bin/bash

DIRECTORY=/root/scripts/server_proxy

while [ option != "0" ]
do
  clear;echo
  echo -e "\e[31mADD CONTAINER TO LOAD-BALANCING MENU"; tput sgr0
  echo ""
  echo "1         Add to Round-Robin"
  echo "2         Add to Weighted"
  echo "3         Add to Persistent"
  echo "4         Add to Least Connected"
  echo ""
  read -p "Option: " option
 	case $option in
    1)
      echo "Adding to Round-Robin..."
      /bin/bash $DIRECTORY/containers/container_balancing_new.sh "c-round"
      break;;
    2)
      echo "Adding to Weighted..."
      /bin/bash $DIRECTORY/containers/container_balancing_new.sh "c-weighted"
      break;;
    3)
      echo "Adding to Persistent..."
      /bin/bash $DIRECTORY/containers/container_balancing_new.sh "c-persistent"
      break;;
    4)
      echo "Adding to Least Connected..."
      /bin/bash $DIRECTORY/containers/container_balancing_new.sh "c-least"
      break;;
    *)
      echo "Not a valid selection in CONTAINER LOAD-BALANCING MENU"
      break;;
  esac
  echo "Press ENTER to go back to MENU";
done
