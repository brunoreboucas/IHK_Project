#!/bin/bash

DIRECTORY=/root/scripts/server_proxy

### GET SENT VARIABLES
balancing_type=$1

### LOAD FROM VARIABLES
source $DIRECTORY/variables/domain_name

### READ BALANCING NAME
proxy_address=${balancing_type}".$domain_name"
echo "" ; echo -e "Server to be added to: \e[1;31m$proxy_address"; tput sgr0
read -p "Is that correct(Y/N): " option_adding

if [ $option_adding == "Y" ] || [ $option_adding == "y" ]
then
  read -p "Please enter the IP adress: " balancing_server_ip
  echo -e "New server IP: \e[1;31m$balancing_server_ip"; tput sgr0
  read -p "Is that correct(Y/N): " option_balancing_ip

  if [ $option_balancing_ip == "Y" ] || [ $option_balancing_ip == "y" ]
  then
    /bin/bash $DIRECTORY/servers/load_balancing_set.sh $balancing_type $balancing_server_ip $proxy_address
  else
    echo "Aborted by choosing load-balancing ip..."
  fi
else
  echo "Aborted by choosing load-balancing server..."
fi
