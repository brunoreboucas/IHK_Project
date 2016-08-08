#!/bin/bash

DIRECTORY=/root/scripts/server_proxy

### GET SENT VARIABLES
balancing_type=$1
balancing_server_ip=$2
proxy_address=$3
container_port=$4

### LOAD FROM VARIABLES
source $DIRECTORY/variables/balancing_counters
source $DIRECTORY/variables/balancing_addresses

### SET VARIABLES
case $balancing_type in
  "c-round")
      config_file_name=${balancing_type}"_$c_count_round"
      proxy_ip=$c_round_address
      new_counter=$((c_count_round+1))
      counter_name=c_count_round
    ;;
  "c-weighted")
      config_file_name=${balancing_type}"_$c_count_weighted"
      proxy_ip=$c_weighted_address
      new_counter=$((c_count_weighted+1))
      counter_name=c_count_weighted
    ;;
  "c-persistent")
      config_file_name=${balancing_type}"_$c_count_persistent"
      proxy_ip=$c_persistent_address
      new_counter=$((c_count_persistent+1))
      counter_name=c_count_persistent
    ;;
  "c-least")
      config_file_name=${balancing_type}"_$c_count_least"
      proxy_ip=$c_least_address
      new_counter=$((c_count_least+1))
      counter_name=c_count_least
    ;;
esac

echo ""; echo -e "\e[1;31m ADD SERVER TO BALANCING: $balancing_type"; tput sgr0
/bin/bash $DIRECTORY/shared/proxy_balancing_new.sh $balancing_type $balancing_server_ip $container_port

echo ""; echo -e "\e[1;31m UPDATE BALANCING VARIABLE FILE"; tput sgr0
sed -i "/$counter_name/ c $counter_name=$new_counter" $DIRECTORY/variables/balancing_counters

echo ""; echo -e "\e[1;31m CREATE SERVER CONFIG FILE"; tput sgr0
echo "server_name=$config_file_name
type=load-balancing
new_server_ip=$proxy_ip
new_server_port=$container_port
container_server_ip=$balancing_server_ip
proxy_address=$proxy_address" > $DIRECTORY/added_containers/$config_file_name

echo "" ; echo -e "\e[1;33m RESTART PROXY"; tput sgr0
service nginx restart
