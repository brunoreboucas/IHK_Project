#!/bin/bash

### GET SENT VARIABLES
adapter_name=$1

echo "" ; echo -e "\e[1;33m BRING INTERFACE DOWN: $adapter_name"; tput sgr0
ifdown $adapter_name

echo -e "\e[1;33m UPDATE: /etc/network/interfaces"; tput sgr0
sed -i "/auto $adapter_name/,/255.255.255.0/d" /etc/network/interfaces

echo -e "\e[1;32m RESTART NETWORKING"; tput sgr0
service networking restart
