#!/bin/bash

###################################
# 4.1- GET VARIABLES
####################################
echo -e "\e[1;33m 4.1- GET VARIABLES"; tput sgr0

fw=/sbin/iptables

DIRECTORY=$1
source $DIRECTORY/variables/adapters

###################################
# 4.2- SET SPI RULES
####################################
# echo -e "\e[1;33m 4.2- SET SPI RULES"; tput sgr0

###
### Lokale Prozesse über localhost erlauben --> lo == localhost(127.0.0.1)
###
echo -e "\e[1;33m 4.2.1- SET SPI RULES: lo"; tput sgr0
$fw -A INPUT -i lo -j ACCEPT
$fw -A OUTPUT -o lo -j ACCEPT

### INPUT
echo -e "\e[1;33m 4.2.2- SET SPI RULES: INPUT"; tput sgr0
$fw -A INPUT -i $host_adapter -p tcp -m state --state ESTABLISHED,RELATED -j ACCEPT
$fw -A INPUT -i $to_server_adapter -p tcp -m state --state ESTABLISHED,RELATED -j ACCEPT
$fw -A INPUT -i $proxy_adapter -p tcp -m state --state ESTABLISHED,RELATED -j ACCEPT

### OUTPUT
echo -e "\e[1;33m 4.2.3- SET SPI RULES: OUTPUT"; tput sgr0
$fw -A OUTPUT -o $host_adapter -m state --state ESTABLISHED,RELATED -j ACCEPT
$fw -A OUTPUT -o $to_server_adapter -m state --state ESTABLISHED,RELATED -j ACCEPT
$fw -A OUTPUT -o $proxy_adapter -m state --state ESTABLISHED,RELATED -j ACCEPT

###################################
# 4.3- END DEFAULT CONFIG
###################################
