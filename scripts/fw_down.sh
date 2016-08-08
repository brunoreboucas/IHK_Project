#!/bin/bash

echo ""
echo -e "\e[1;33m skripte: fw_aus.sh"; tput sgr0
####################################
# 1. SET VARIABLES
####################################
echo -e "\e[1;32m 1. SET VARIABLES"; tput sgr0

fw=/sbin/iptables

####################################
# 1. DISABLE RUNNING RULES
####################################
echo -e "\e[1;32m 2. DISABLE RUNNING RULES"; tput sgr0
$fw -F
$fw -X

####################################
# 3. ENABLE CONNECTIONS
####################################
echo -e "\e[1;32m 3. ENABLE CONNECTIONS"; tput sgr0

# Eigehend Offen
$fw -P INPUT ACCEPT

# Ausgehend Offen
$fw -P OUTPUT ACCEPT

# Routing erlauben
$fw -P FORWARD ACCEPT

echo ""
