#!/bin/bash

echo ""
echo -e "\e[1;32m Starting Firewall: fw_up.sh"; tput sgr0

fw=/sbin/iptables
# DIRECTORY=$(pwd)/firewall
DIRECTORY=/root/scripts/firewall

####################################
# 1. DISABLE RUNNING RULES
####################################
echo ; echo -e "\e[1;32m 1. DISABLE RUNNING RULES"; tput sgr0

$fw -F
$fw -X

####################################
# 2. TEST FILES EXISTENCE
####################################
echo ; echo -e "\e[1;32m 2. TEST FILES EXISTENCE"; tput sgr0

# /bin/bash test_files.sh $DIRECTORY
files_exist=$(/bin/bash $DIRECTORY/2_test_files.sh $DIRECTORY)

if [ "$files_exist" ]
then
  echo ; echo -e "\e[1;31m File not found: $files_exist"; tput sgr0
  exit
else
  echo "All dependency files found"
fi

###################################
# 3. OPEN ALL RULES
###################################
echo ; echo -e "\e[1;32m 3. OPEN ALL RULES"; tput sgr0

# Eigehend Offen
$fw -P INPUT DROP

# Ausgehend Offen
$fw -P OUTPUT DROP

# Routing erlauben
$fw -P FORWARD DROP

###################################
# 4. SPI - STATE PACKET INSPEKTION
###################################
echo ; echo -e "\e[1;32m 4. SPI - STATE PACKET INSPEKTION"; tput sgr0

/bin/bash $DIRECTORY/4_SPI.sh $DIRECTORY

###################################
# 5. LOG ACTIONS
###################################
echo ; echo -e "\e[1;32m 5. LOG ACTIONS"; tput sgr0

/bin/bash $DIRECTORY/5_log.sh

###################################
# 6. FILTERS
###################################
echo ; echo -e "\e[1;32m 6. FILTERS"; tput sgr0

/bin/bash $DIRECTORY/6_filters.sh $DIRECTORY

###################################
# 7. PROXY SERVERS SINGLES
###################################
echo ; echo -e "\e[1;32m 7. PROXY SERVERS SINGLES"; tput sgr0

/bin/bash $DIRECTORY/7_servers_singles.sh $DIRECTORY

###################################
# 8. PROXY SERVERS BALANCING
###################################
echo ; echo -e "\e[1;32m 8. PROXY SERVERS BALANCING"; tput sgr0

/bin/bash $DIRECTORY/8_servers_balancing.sh $DIRECTORY

###################################
# 9. PROXY CONTAINERS PORTS
###################################
echo ; echo -e "\e[1;32m 9. PROXY CONTAINERS PORTS"; tput sgr0

/bin/bash $DIRECTORY/9_containers_ports.sh $DIRECTORY

###################################
# 10. PROXY CONTAINERS SINGLES
###################################
echo ; echo -e "\e[1;32m 10. PROXY CONTAINERS SINGLES"; tput sgr0

/bin/bash $DIRECTORY/10_containers_singles.sh $DIRECTORY

###################################
# 11. PROXY CONTAINERS BALANCING
###################################
echo ; echo -e "\e[1;32m 11. PROXY CONTAINERS BALANCING"; tput sgr0

/bin/bash $DIRECTORY/11_containers_balancing.sh $DIRECTORY
