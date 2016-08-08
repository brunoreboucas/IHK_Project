#!/bin/bash

###################################
# 9.1- GET VARIABLES
####################################
echo -e "\e[1;33m 9.1- GET VARIABLES"; tput sgr0

fw=/sbin/iptables

DIRECTORY=$1
source $DIRECTORY/variables/adapters
source $DIRECTORY/variables/networks
source $DIRECTORY/variables/containers_ports

###################################
# 9.2- SET CONTAINERS PORTS RULES
####################################
# echo -e "\e[1;33m 9.2- SET CONTAINERS RULES"; tput sgr0

### CONTAINER 1
echo -e "\e[1;33m 9.2.1- PORTS CONTAINER 1"; tput sgr0
$fw -A INPUT -p tcp --dport $container1_port -i $proxy_adapter -s $lanA -d $proxy_ip -j ACCEPT
$fw -A OUTPUT -p tcp --dport $container1_port -o $proxy_adapter -s $proxy_ip -j ACCEPT

### CONTAINER 2
echo -e "\e[1;33m 9.2.2- PORTS CONTAINER 2"; tput sgr0
$fw -A INPUT -p tcp --dport $container2_port -i $proxy_adapter -s $lanA -d $proxy_ip -j ACCEPT
$fw -A OUTPUT -p tcp --dport $container2_port -o $proxy_adapter -s $proxy_ip -j ACCEPT

### CONTAINER 3
echo -e "\e[1;33m 9.2.3- PORTS CONTAINER 3"; tput sgr0
$fw -A INPUT -p tcp --dport $container3_port -i $proxy_adapter -s $lanA -d $proxy_ip -j ACCEPT
$fw -A OUTPUT -p tcp --dport $container3_port -o $proxy_adapter -s $proxy_ip -j ACCEPT

###################################
# 9.3- END DEFAULT CONFIG
###################################
