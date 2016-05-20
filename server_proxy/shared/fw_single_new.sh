#!/bin/bash

DIRECTORY=/root/scripts/firewall

### GET SENT VARIABLES
server_name=$1
new_server_ip=$2

echo ""
echo -e "\e[1;33m ADDING TO /firewall/servers/servers_singles: $server_name=$new_server_ip"; tput sgr0
server_name_ip=${server_name}"_ip"
echo -e "$server_name_ip=$new_server_ip" >> $DIRECTORY/servers/servers_singles

echo -e "\e[1;33m ADDING RULES TO /firewall/7_servers_singles.sh"; tput sgr0
echo "### BEGIN: $server_name" >> $DIRECTORY/7_servers_singles.sh

echo "\$fw -A INPUT -p icmp --icmp-type 8 -i \$to_server_adapter -s \$lanB -d \$$server_name_ip -j ACCEPT" >> $DIRECTORY/7_servers_singles.sh
echo "\$fw -A INPUT -p icmp --icmp-type 8 -i \$to_server_adapter -s \$lanC -d \$$server_name_ip -j ACCEPT" >> $DIRECTORY/7_servers_singles.sh

echo "\$fw -A INPUT -p tcp --dport \$port_http -i \$to_server_adapter -s \$lanB -d \$$server_name_ip -j ACCEPT" >> $DIRECTORY/7_servers_singles.sh
echo "\$fw -A INPUT -p tcp --dport \$port_http -i \$to_server_adapter -s \$lanC -d \$$server_name_ip -j ACCEPT" >> $DIRECTORY/7_servers_singles.sh

echo "### END: $server_name" >> $DIRECTORY/7_servers_singles.sh

echo -e "\e[1;32m RESTARTING FIREWALL"; tput sgr0
/bin/bash /root/scripts/fw_up.sh
