#!/bin/bash

###################################
# 5.1- GET VARIABLES
####################################
echo -e "\e[1;33m 5.1- GET VARIABLES"; tput sgr0

fw=/sbin/iptables

###################################
# 5.2- CREATE LOG
####################################
echo -e "\e[1;33m 5.2- CREATE LOG"; tput sgr0
$fw -N DROPLOG

###################################
# 5.3- LOGGING
####################################
# echo -e "\e[1;33m 5.3- LOGGING"; tput sgr0

echo -e "\e[1;33m 5.3.1- LOGGING ICMP:PING"; tput sgr0
$fw -A DROPLOG -p icmp -m limit --limit 5/minute -j LOG --log-prefix "icmp-paket: "

echo -e "\e[1;33m 5.3.2- LOGGING UDP"; tput sgr0
$fw -A DROPLOG -p udp -m limit --limit 25/minute -j LOG --log-prefix "udp-paket: "

echo -e "\e[1;33m 5.3.3- LOGGING TCP"; tput sgr0
$fw -A DROPLOG -p tcp -m limit --limit 50/minute -j LOG --log-prefix "tcp-paket: "

echo -e "\e[1;33m 5.3.4- NOT LOGGING WITHOUT COMMENTS"; tput sgr0
$fw -A DROPLOG -j DROP

# PORTSCANS BLOCK
#$fw -A INPUT -m limit --limit 5/minute -m state --state INVALID -j DROPLOG

###################################
# 5.4- END DEFAULT CONFIG
###################################
