#!/bin/bash

DIRECTORY=/root/scripts/firewall

### GET SENT VARIABLES
server_name=$1
new_server_ip=$2

server_name_ip=${server_name}"_ip"
echo "" ; echo -e "\e[1;33m REMOVING FROM: /firewall/servers/servers_singles: $server_name_ip=$new_server_ip"; tput sgr0
sed -i "/$server_name_ip=$new_server_ip/d" $DIRECTORY/servers/servers_singles

echo -e "\e[1;33m REMOVING RULES FROM: /firewall/7_servers_singles.sh"; tput sgr0
sed -i "/### BEGIN: $server_name/,/### END: $server_name/d" $DIRECTORY/7_servers_singles.sh

echo -e "\e[1;32m RESTARTING FIREWALL"; tput sgr0
/bin/bash /root/scripts/fw_up.sh
