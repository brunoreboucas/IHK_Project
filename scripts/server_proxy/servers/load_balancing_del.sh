#!/bin/bash

DIRECTORY=/root/scripts/server_proxy

### LOAD FROM VARIABLES
source $DIRECTORY/variables/domain_name
source $DIRECTORY/variables/balancing_counters

### READ SERVER NAME
read -p "Load-Balancing Server name to be deleted: " server_name
echo -e "Server name: \e[1;31m$server_name"; tput sgr0
read -p "Is that correct(Y/N): " option_server_name

if [ $option_server_name == "Y" ] || [ $option_server_name == "y" ]
then

  entry=$DIRECTORY/added_servers/$server_name

  if [ -f $entry ]
  then
    source $entry

    if [ $type == load-balancing ]
    then
      echo ""; echo -e "\e[1;31m REMOVE SERVER FROM BALANCING"; tput sgr0
      ### STRIP
      proxy_file="${proxy_address%.$domain_name}"
      ### UPDATE
      sed -i "/server $new_server_ip:80/d" /etc/nginx/sites-available/$proxy_file

      echo ""; echo -e "\e[1;31m UPDATE BALANCING VARIABLE FILE"; tput sgr0
      ### GET VALUES
      counter_name=${proxy_file}"_count"
      new_counter=$((counter_name-1))
      ### UPDATE
      sed -i "/$counter_name/ c $counter_name=$new_counter" $DIRECTORY/variables/balancing_counters

      echo "" ; echo -e "\e[1;31m DELETE SERVER CONFIG FILE"; tput sgr0
      rm -rfv $DIRECTORY/added_servers/$server_name

      echo "" ; echo -e "\e[1;33m RESTART PROXY"; tput sgr0
      service nginx restart
    else
      echo "Server chosen is not Load-Balancing..."
    fi
  else
    echo "server_name not found :("
  fi
else
  echo "Aborted by choosing single server name..."
fi
