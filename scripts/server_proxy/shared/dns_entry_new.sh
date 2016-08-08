#!/bin/bash

### GET SENT VARIABLES
server_name=$1
new_server_ip=$2
server_ip=$3
domain_name=$4
full_name=$5

forward_name="db.${domain_name}.forward"
rev_name="db.${domain_name}.rev"

echo "" ; echo -e "\e[1;33m ADDING TO: /etc/bind/$forward_name"; tput sgr0
echo "$server_name IN A $new_server_ip"  >> /etc/bind/$forward_name

echo -e "\e[1;33m ADDING TO: /etc/bind/$rev_name"; tput sgr0
echo "$server_ip IN PTR $full_name"  >> /etc/bind/$rev_name

echo -e "\e[1;32m RESTARTING DNS..."; tput sgr0
service bind9 restart
