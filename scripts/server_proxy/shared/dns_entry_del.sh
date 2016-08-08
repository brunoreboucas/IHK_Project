#!/bin/bash

### GET SENT VARIABLES
server_name=$1
server_ip=$2
domain_name=$3

forward_name="db.${domain_name}.forward"
rev_name="db.${domain_name}.rev"

echo "" ; echo -e "\e[1;33m REMOVING FROM: /etc/bind/$forward_name"; tput sgr0
sed -i "/$server_name IN A $server_ip/d" /etc/bind/$forward_name

echo -e "\e[1;33m REMOVING FROM: /etc/bind/$rev_name"; tput sgr0
### STRIP
ip_server="${server_ip//172.16.2.}"
### UPDATE
sed -i "/$ip_server IN PTR $server_name.$domain_name/d" /etc/bind/$rev_name

echo -e "\e[1;32m RESTARTING DNS..."; tput sgr0
service bind9 restart
