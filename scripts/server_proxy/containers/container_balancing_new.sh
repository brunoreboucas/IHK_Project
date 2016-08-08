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
  read -p "Please enter the Container-Server IP adress: " balancing_server_ip
  echo -e "Container-Server server IP: \e[1;31m$balancing_server_ip"; tput sgr0
  read -p "Is that correct(Y/N): " option_balancing_ip

  if [ $option_balancing_ip == "Y" ] || [ $option_balancing_ip == "y" ]
  then
    read -p "Please enter the Container port number: " container_port
    echo -e "Container port: \e[1;31m$container_port"; tput sgr0
    read -p "Is that correct(Y/N): " option_container_port

    if [ $option_container_port == "Y" ] || [ $option_container_port == "y" ]
    then
      /bin/bash $DIRECTORY/containers/container_balancing_set.sh $balancing_type $balancing_server_ip $proxy_address $container_port
    else
      echo "Aborted by choosing Container port..."
    fi
  else
    echo "Aborted by choosing load-balancing ip..."
  fi
else
  echo "Aborted by choosing load-balancing server..."
fi
