#!/bin/bash

### GET SENT VARIABLES
server_name=$1
full_name=$2

echo "" ; echo -e "\e[1;33m DISABLE PROXY: $full_name"; tput sgr0
rm -rfv /etc/nginx/sites-enabled/$server_name

echo -e "\e[1;33m REMOVING: /etc/nginx/sites-available/$server_name"; tput sgr0
rm -rfv /etc/nginx/sites-available/$server_name

echo -e "\e[1;32m RESTARTING PROXY..."; tput sgr0
service nginx restart
