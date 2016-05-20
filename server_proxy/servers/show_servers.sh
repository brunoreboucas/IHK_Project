#!/bin/bash

DIRECTORY=/root/scripts/server_proxy/added_servers

echo ""
if [ "$(ls -A $DIRECTORY)" ]
then
     for entry in "$DIRECTORY"/*
     do
       source $entry
       echo -e "SERVER_NAME: \e[1;33m$server_name"; tput sgr0
       echo -e "           TYPE: \e[1;32m$type"; tput sgr0
       echo "           IP: $new_server_ip"
       echo "           PROXY: $proxy_server_ip"
       if [ $type == single_server ]
       then
         echo "           ADAPTER: $adapter_name"
       else
         echo "           ADDRESS: $proxy_address"
       fi
     done
else
    echo "No added servers found..."
fi
