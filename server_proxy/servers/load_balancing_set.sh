#!/bin/bash

DIRECTORY=/root/scripts/server_proxy

### GET SENT VARIABLES
balancing_type=$1
balancing_server_ip=$2
proxy_address=$3

### LOAD FROM VARIABLES
source $DIRECTORY/variables/balancing_counters
source $DIRECTORY/variables/balancing_addresses

### SET VARIABLES
case $balancing_type in
  "round")
      config_file_name=${balancing_type}"_$round_count"
      proxy_ip=$round_address
      new_counter=$((round_count+1))
      counter_name=round_count
    ;;
  "weighted")
      config_file_name=${balancing_type}"_$weighted_count"
      proxy_ip=$weighted_address
      new_counter=$((weighted_count+1))
      counter_name=weighted_count
    ;;
  "persistent")
      config_file_name=${balancing_type}"_$persistent_count"
      proxy_ip=$persistent_address
      new_counter=$((persistent_count+1))
      counter_name=persistent_count
    ;;
  "least")
      config_file_name=${balancing_type}"_$least_count"
      proxy_ip=$least_address
      new_counter=$((least_count+1))
      counter_name=least_count
    ;;
esac

echo ""; echo -e "\e[1;31m ADD SERVER TO BALANCING: $balancing_type"; tput sgr0
/bin/bash $DIRECTORY/shared/proxy_balancing_new.sh $balancing_type $balancing_server_ip

echo ""; echo -e "\e[1;31m UPDATE BALANCING VARIABLE FILE"; tput sgr0
sed -i "/$counter_name/ c $counter_name=$new_counter" $DIRECTORY/variables/balancing_counters

echo ""; echo -e "\e[1;31m CREATE SERVER CONFIG FILE"; tput sgr0
echo "server_name=$config_file_name
type=load-balancing
new_server_ip=$balancing_server_ip
proxy_server_ip=$proxy_ip
proxy_address=$proxy_address" > $DIRECTORY/added_servers/$config_file_name

echo "" ; echo -e "\e[1;33m RESTART PROXY"; tput sgr0
service nginx restart
