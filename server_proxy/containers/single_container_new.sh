#!/bin/bash

DIRECTORY=/root/scripts/server_proxy

### LOAD FROM FILES
source $DIRECTORY/variables/domain_name

### READ SERVER NAME
read -p "Single Container name to be added: " container_name
full_name=${container_name}".$domain_name"
echo -e "New server name: \e[1;31m$full_name"; tput sgr0
read -p "Is that correct(Y/N): " option_container_name

if [ $option_container_name == "Y" ] || [ $option_container_name == "y" ]
then
  read -p "Please enter the Container-Server IP adress: " container_server_ip
  echo -e "Container-Server IP: \e[1;31m$container_server_ip"; tput sgr0
  read -p "Is that correct(Y/N): " option_container_server_ip

  if [ $option_container_server_ip == "Y" ] || [ $option_container_server_ip == "y" ]
  then
    read -p "Please enter the Container port number: " container_port
    echo -e "Container port: \e[1;31m$container_port"; tput sgr0
    read -p "Is that correct(Y/N): " option_container_port

    if [ $option_container_port == "Y" ] || [ $option_container_port == "y" ]
    then
      /bin/bash $DIRECTORY/containers/single_container_set.sh $container_name $container_server_ip $container_port $domain_name $full_name
    else
      echo "Aborted by choosing Container port..."
    fi
  else
    echo "Aborted by choosing Container-Server ip..."
  fi
else
  echo "Aborted by choosing container server name..."
fi
