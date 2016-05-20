#!/bin/bash

DIRECTORY=/root/scripts/server_proxy

### GET SENT VARIABLES
new_server_ip=$1
adapter_name=$2

### LOAD FROM FILES
source $DIRECTORY/variables/new_ip
source $DIRECTORY/variables/adapter_number

echo ""
echo -e "\e[1;33m UPDATING single_ip IN: variables/single_ip"; tput sgr0
new_single_ip=$((server_ip+1))
echo server_ip=$new_single_ip > $DIRECTORY/variables/new_ip

echo -e "\e[1;33m UPDATING adapter_number IN: variables/adapter_number"; tput sgr0
new_adapter_number=$((adapter_number+1))
echo adapter_number=$new_adapter_number > $DIRECTORY/variables/adapter_number

echo -e "\e[1;33m ADDING NEW INTERFACE IN: /etc/network/interfaces"; tput sgr0
echo "auto $adapter_name
iface $adapter_name inet static
	address $new_server_ip
	netmask 255.255.255.0" >> /etc/network/interfaces

echo -e "\e[1;32m BRING UP NEW ADAPTER"; tput sgr0
ifup $adapter_name

echo -e "\e[1;32m RESTART NETWORKING"; tput sgr0
service networking restart
