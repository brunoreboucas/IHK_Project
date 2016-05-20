#!/bin/bash

DIRECTORY=/root/scripts/server_proxy

### LOAD FROM FILES
source $DIRECTORY/variables/domain_name

### READ SERVER NAME
read -p "Single Server name to be added: " server_name
full_name=${server_name}".$domain_name"
echo -e "New server name: \e[1;31m$full_name"; tput sgr0
read -p "Is that correct(Y/N): " option_server_name

if [ $option_server_name == "Y" ] || [ $option_server_name == "y" ]
then
  read -p "Please enter the IP adress: " proxy_server_ip
  echo -e "New server IP: \e[1;31m$proxy_server_ip"; tput sgr0
  read -p "Is that correct(Y/N): " option_server_ip

  if [ $option_server_ip == "Y" ] || [ $option_server_ip == "y" ]
  then
    /bin/bash $DIRECTORY/servers/single_server_set.sh $server_name $proxy_server_ip $domain_name $full_name
  else
    echo "Aborted by choosing single server ip..."
  fi
else
  echo "Aborted by choosing single server name..."
fi
