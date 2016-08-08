#!/bin/bash

###################################
# 6.1- GET VARIABLES
###################################
echo -e "\e[1;32m 6.1- GET VARIABLES"; tput sgr0

fw=/sbin/iptables

DIRECTORY=$1
source $DIRECTORY/variables/adapters
source $DIRECTORY/variables/networks
source $DIRECTORY/variables/used_ports

###################################
# 6.2- SET FILTER RULES
###################################
# echo ; echo -e "\e[1;33m    6.2- SET FILTER RULES"; tput sgr0

### SSH
echo -e "\e[1;33m 6.2.1- SET FILTER RULES: SSH"; tput sgr0
$fw -A INPUT -p tcp --dport $port_ssh -i $to_server_adapter -s $lanB -d $to_server_ip -j ACCEPT
# This is used to connect the host to this guest the Virtual-Machine
$fw -A INPUT -p tcp --dport $port_ssh -i $host_adapter -s $host_ip -d $guest_ip -j ACCEPT

### DNS
echo -e "\e[1;33m 6.2.2- SET FILTER RULES: DNS"; tput sgr0
$fw -A INPUT -p udp --dport $port_dns -i $to_server_adapter -s $lanB -d $to_server_ip -j ACCEPT

### PING
echo -e "\e[1;33m 6.2.3- SET FILTER RULES: ICMP-PING"; tput sgr0
$fw -A INPUT -p icmp --icmp-type 8 -i $to_server_adapter -s $lanB -d $to_server_ip -j ACCEPT
$fw -A INPUT -p icmp --icmp-type 8 -i $to_server_adapter -s $lanC -d $to_server_ip -j ACCEPT
# This server can be pinged from lanA
$fw -A INPUT -p icmp --icmp-type 8 -i $proxy_adapter -s $lanA -d $proxy_ip -j ACCEPT

### HTTP
echo -e "\e[1;33m 6.2.4- SET FILTER RULES: HTTP"; tput sgr0
$fw -A INPUT -p tcp --dport $port_http -i $proxy_adapter -s $lanA -d $proxy_ip -j ACCEPT
$fw -A OUTPUT -p tcp --dport $port_http -o $proxy_adapter -s $proxy_ip -j ACCEPT

###################################
# 6.3- END DEFAULT CONFIG
###################################
