#!/bin/bash

###################################
# 11.1- GET VARIABLES
####################################
echo -e "\e[1;33m 11.1- GET VARIABLES"; tput sgr0

fw=/sbin/iptables

DIRECTORY=$1
source $DIRECTORY/variables/adapters
source $DIRECTORY/variables/networks
source $DIRECTORY/variables/containers_ports

source $DIRECTORY/containers/containers_balancing

###################################
# 11.2- SET CONTAINERS BALANCING RULES
####################################
# echo -e "\e[1;33m 11.2- SET CONTAINERS BALANCING RULES"; tput sgr0

###
### C-ROUND
###

### PING
echo -e "\e[1;33m 11.2.1- SERVER C-ROUND: PING"; tput sgr0
$fw -A INPUT -p icmp --icmp-type 8 -i $to_server_adapter -s $lanB -d $c_round_ip -j ACCEPT
$fw -A INPUT -p icmp --icmp-type 8 -i $to_server_adapter -s $lanC -d $c_round_ip -j ACCEPT

### HTTP
echo -e "\e[1;33m 11.2.2- SERVER C-ROUND: HTTP"; tput sgr0
$fw -A INPUT -p tcp --dport 80 -i $to_server_adapter -s $lanB -d $c_round_ip -j ACCEPT
$fw -A INPUT -p tcp --dport 80 -i $to_server_adapter -s $lanC -d $c_round_ip -j ACCEPT

###
### D-WEIGHTED
###

### PING
echo -e "\e[1;33m 11.3.1- SERVER C-WEIGHTED: PING"; tput sgr0
$fw -A INPUT -p icmp --icmp-type 8 -i $to_server_adapter -s $lanB -d $c_weighted_ip -j ACCEPT
$fw -A INPUT -p icmp --icmp-type 8 -i $to_server_adapter -s $lanC -d $c_weighted_ip -j ACCEPT

### HTTP
echo -e "\e[1;33m 11.3.2- SERVER C-WEIGHTED: HTTP"; tput sgr0
$fw -A INPUT -p tcp --dport 80 -i $to_server_adapter -s $lanB -d $c_weighted_ip -j ACCEPT
$fw -A INPUT -p tcp --dport 80 -i $to_server_adapter -s $lanC -d $c_weighted_ip -j ACCEPT

###
### D-PERSISTENT
###

### PING
echo -e "\e[1;33m 11.4.1- SERVER C-PERSISTENT: PING"; tput sgr0
$fw -A INPUT -p icmp --icmp-type 8 -i $to_server_adapter -s $lanB -d $c_persistent_ip -j ACCEPT
$fw -A INPUT -p icmp --icmp-type 8 -i $to_server_adapter -s $lanC -d $c_persistent_ip -j ACCEPT

### HTTP
echo -e "\e[1;33m 11.4.2- SERVER C-PERSISTENT: HTTP"; tput sgr0
$fw -A INPUT -p tcp --dport 80 -i $to_server_adapter -s $lanB -d $c_persistent_ip -j ACCEPT
$fw -A INPUT -p tcp --dport 80 -i $to_server_adapter -s $lanC -d $c_persistent_ip -j ACCEPT

###
### D-LEAST
###

### PING
echo -e "\e[1;33m 11.5.1- SERVER C-LEAST: PING"; tput sgr0
$fw -A INPUT -p icmp --icmp-type 8 -i $to_server_adapter -s $lanB -d $c_least_conn_ip -j ACCEPT
$fw -A INPUT -p icmp --icmp-type 8 -i $to_server_adapter -s $lanC -d $c_least_conn_ip -j ACCEPT

### HTTP
echo -e "\e[1;33m 11.5.2- SERVER C-LEAST: HTTP"; tput sgr0
$fw -A INPUT -p tcp --dport 80 -i $to_server_adapter -s $lanB -d $c_least_conn_ip -j ACCEPT
$fw -A INPUT -p tcp --dport 80 -i $to_server_adapter -s $lanC -d $c_least_conn_ip -j ACCEPT

###################################
# 11.6- END DEFAULT CONFIG
###################################
