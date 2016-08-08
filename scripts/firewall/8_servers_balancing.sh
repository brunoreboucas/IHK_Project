#!/bin/bash

###################################
# 8.1- GET VARIABLES
####################################
echo -e "\e[1;33m 8.1- GET VARIABLES"; tput sgr0

fw=/sbin/iptables

DIRECTORY=$1
source $DIRECTORY/variables/adapters
source $DIRECTORY/variables/networks
source $DIRECTORY/variables/servers
source $DIRECTORY/variables/used_ports
source $DIRECTORY/servers/servers_balancing

###################################
# 8.2- SET PROXY SERVERS RULES
####################################
# echo ; echo -e "\e[1;33m    8.2- SET PROXY SERVERS RULES"; tput sgr0

###
### ROUND-ROBIN
###

### PING
echo -e "\e[1;33m 8.2.1- ROUND-ROBIN: PING"; tput sgr0
$fw -A INPUT -p icmp --icmp-type 8 -i $to_server_adapter -s $lanB -d $round_ip -j ACCEPT
$fw -A INPUT -p icmp --icmp-type 8 -i $to_server_adapter -s $lanC -d $round_ip -j ACCEPT

### HTTP
echo -e "\e[1;33m 8.2.2- ROUND-ROBIN: HTTP"; tput sgr0
$fw -A INPUT -p tcp --dport $port_http -i $to_server_adapter -s $lanB -d $round_ip -j ACCEPT
$fw -A INPUT -p tcp --dport $port_http -i $to_server_adapter -s $lanC -d $round_ip -j ACCEPT

###
### WEIGHTED
###

### PING
echo -e "\e[1;33m 8.3.1- WEIGHTED: PING"; tput sgr0
$fw -A INPUT -p icmp --icmp-type 8 -i $to_server_adapter -s $lanB -d $weighted_ip -j ACCEPT
$fw -A INPUT -p icmp --icmp-type 8 -i $to_server_adapter -s $lanC -d $weighted_ip -j ACCEPT

### HTTP
echo -e "\e[1;33m 8.3.2- WEIGHTED: HTTP"; tput sgr0
$fw -A INPUT -p tcp --dport $port_http -i $to_server_adapter -s $lanB -d $weighted_ip -j ACCEPT
$fw -A INPUT -p tcp --dport $port_http -i $to_server_adapter -s $lanC -d $weighted_ip -j ACCEPT

###
### PERSISTENT
###

### PING
echo -e "\e[1;33m 8.4.1- PERSISTENT: PING"; tput sgr0
$fw -A INPUT -p icmp --icmp-type 8 -i $to_server_adapter -s $lanB -d $persistent_ip -j ACCEPT
$fw -A INPUT -p icmp --icmp-type 8 -i $to_server_adapter -s $lanC -d $persistent_ip -j ACCEPT

### HTTP
echo -e "\e[1;33m 8.4.1- PERSISTENT: HTTP"; tput sgr0
$fw -A INPUT -p tcp --dport $port_http -i $to_server_adapter -s $lanB -d $persistent_ip -j ACCEPT
$fw -A INPUT -p tcp --dport $port_http -i $to_server_adapter -s $lanC -d $persistent_ip -j ACCEPT

###
### LEAST-CONNECTED
###

### PING
echo -e "\e[1;33m 8.5.1- LEAST-CONNECTED: PING"; tput sgr0
$fw -A INPUT -p icmp --icmp-type 8 -i $to_server_adapter -s $lanB -d $least_conn_ip -j ACCEPT
$fw -A INPUT -p icmp --icmp-type 8 -i $to_server_adapter -s $lanC -d $least_conn_ip -j ACCEPT

### HTTP
echo -e "\e[1;33m 8.5.2- LEAST-CONNECTED: HTTP"; tput sgr0
$fw -A INPUT -p tcp --dport $port_http -i $to_server_adapter -s $lanB -d $least_conn_ip -j ACCEPT
$fw -A INPUT -p tcp --dport $port_http -i $to_server_adapter -s $lanC -d $least_conn_ip -j ACCEPT

###################################
# 8.6- END DEFAULT CONFIG
###################################
