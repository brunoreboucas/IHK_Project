#!/bin/bash

###################################
# 10.1- GET VARIABLES
####################################
echo -e "\e[1;33m 10.1- GET VARIABLES"; tput sgr0

fw=/sbin/iptables

DIRECTORY=$1
source $DIRECTORY/variables/adapters
source $DIRECTORY/variables/networks
source $DIRECTORY/variables/containers_ports

source $DIRECTORY/containers/containers_singles

###################################
# 10.2- SET CONTAINERS SINGLES RULES
####################################
# echo -e "\e[1;33m 10.2- SET CONTAINERS SINGLES RULES"; tput sgr0

### PING
echo -e "\e[1;33m 10.2.1- SERVER C-SINGLE: PING"; tput sgr0
$fw -A INPUT -p icmp --icmp-type 8 -i $to_server_adapter -s $lanB -d $c_single_ip -j ACCEPT
$fw -A INPUT -p icmp --icmp-type 8 -i $to_server_adapter -s $lanC -d $c_single_ip -j ACCEPT

### HTTP
echo -e "\e[1;33m 10.2.2- SERVER C-SINGLE: HTTP"; tput sgr0
$fw -A INPUT -p tcp --dport 80 -i $to_server_adapter -s $lanB -d $c_single_ip -j ACCEPT
$fw -A INPUT -p tcp --dport 80 -i $to_server_adapter -s $lanC -d $c_single_ip -j ACCEPT

###################################
# 10.3- END DEFAULT CONFIG
###################################
