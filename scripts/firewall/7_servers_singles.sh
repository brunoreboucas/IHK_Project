#!/bin/bash

###################################
# 7.1- GET VARIABLES
####################################
echo -e "\e[1;33m 7.1- GET VARIABLES"; tput sgr0

fw=/sbin/iptables

DIRECTORY=$1
source $DIRECTORY/variables/adapters
source $DIRECTORY/variables/networks
source $DIRECTORY/variables/used_ports
source $DIRECTORY/servers/servers_singles

###################################
# 7.2- SET PROXY SERVERS RULES
####################################
# echo -e "\e[1;33m 7.2- SET PROXY SERVERS RULES"; tput sgr0

### PING
echo -e "\e[1;33m 7.2.1- SERVER SINGLE PING"; tput sgr0
$fw -A INPUT -p icmp --icmp-type 8 -i $to_server_adapter -s $lanB -d $single_ip -j ACCEPT
$fw -A INPUT -p icmp --icmp-type 8 -i $to_server_adapter -s $lanC -d $single_ip -j ACCEPT

### HTTP
echo -e "\e[1;33m 7.2.2- SERVER SINGLE HTTP"; tput sgr0
$fw -A INPUT -p tcp --dport $port_http -i $to_server_adapter -s $lanB -d $single_ip -j ACCEPT
$fw -A INPUT -p tcp --dport $port_http -i $to_server_adapter -s $lanC -d $single_ip -j ACCEPT

###################################
# 7.3- END DEFAULT CONFIG
###################################
