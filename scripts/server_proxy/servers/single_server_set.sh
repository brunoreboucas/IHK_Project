#!/bin/bash

DIRECTORY=/root/scripts/server_proxy

### GET SENT VARIABLES
server_name=$1
proxy_server_ip=$2
domain_name=$3
full_name=$4

### LOAD FROM FILES
source $DIRECTORY/variables/new_ip
source $DIRECTORY/variables/adapter_number

### SET VARIABLES
new_server_ip=172.16.2.$server_ip
adapter_name=eth1:added$adapter_number

echo "" ; echo -e "\e[1;31m NEW NETWORK INTERFACE"; tput sgr0
/bin/bash $DIRECTORY/shared/interface_new.sh $new_server_ip $adapter_name

echo "" ; echo -e "\e[1;31m UPDATE DNS"; tput sgr0
/bin/bash $DIRECTORY/shared/dns_entry_new.sh $server_name $new_server_ip $server_ip $domain_name $full_name

echo "" ; echo -e "\e[1;31m UPDATE PROXY"; tput sgr0
/bin/bash $DIRECTORY/shared/proxy_single_new.sh $server_name $new_server_ip $proxy_server_ip $full_name

echo "" ; echo -e "\e[1;31m UPDATE FIREWALL"; tput sgr0
/bin/bash $DIRECTORY/shared/fw_single_new.sh $server_name $new_server_ip

echo ""; echo -e "\e[1;31m CREATE SERVER CONFIG FILE"; tput sgr0
echo "server_name=$server_name
type=single_server
new_server_ip=$new_server_ip
proxy_server_ip=$proxy_server_ip
adapter_name=$adapter_name" > $DIRECTORY/added_servers/$server_name
