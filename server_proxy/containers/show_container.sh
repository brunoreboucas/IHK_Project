#!/bin/bash

DIRECTORY=/root/scripts/server_proxy/added_containers

echo ""
if [ "$(ls -A $DIRECTORY)" ]
then
     for entry in "$DIRECTORY"/*
     do
       source $entry
       echo -e "CONTAINER_NAME: \e[1;33m$server_name"; tput sgr0
       echo -e "           TYPE: \e[1;32m$type"; tput sgr0
       echo "           IP: $new_server_ip"
       echo "           CONTAINER SERVER IP: $container_server_ip"
       echo "           PORT: $new_server_port"
       if [ $type == single_container ]
       then
         echo "           ADAPTER: $adapter_name"
       else
         echo "           ADDRESS: $proxy_address"
       fi
     done
else
    echo "No added containers found..."
fi
