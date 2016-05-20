#!/bin/bash

### GET SENT VARIABLES
balancing_type=$1
balancing_server_ip=$2
proxy_server_port=$3

if [ -z "$proxy_server_port" ]
then
  proxy_server_port=80
fi

if [ $balancing_type == weighted ] || [ $balancing_type == c-weighted ]
then
  read -p "Want to add weight-value to the server?(Y/N): " option_weight
  if [ $option_weight == "Y" ] || [ $option_weight == "y" ]
  then
    read -p "Enter weight-value: " weight_value
    echo -e "New weight-value: \e[1;31m$weight_value"; tput sgr0
    read -p "Is that correct(Y/N): " option_confirm_weight
    if [ $option_confirm_weight == "Y" ] || [ $option_confirm_weight == "y" ]
    then
      sed -i "/TO ADD/{s/.*/&\n    server $balancing_server_ip:$proxy_server_port weight=$weight_value;/;:a;n;ba}" /etc/nginx/sites-available/$balancing_type
    else
      break
    fi
  else
    echo "Adding without weight-value..."
    sed -i "/TO ADD/{s/.*/&\n    server $balancing_server_ip:$proxy_server_port;/;:a;n;ba}" /etc/nginx/sites-available/$balancing_type
  fi
else
  sed -i "/TO ADD/{s/.*/&\n    server $balancing_server_ip:$proxy_server_port;/;:a;n;ba}" /etc/nginx/sites-available/$balancing_type
fi
