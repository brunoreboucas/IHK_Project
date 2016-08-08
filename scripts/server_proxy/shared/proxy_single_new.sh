#!/bin/bash

DIRECTORY=/root/scripts/server_proxy

### GET SENT VARIABLES
server_name=$1
new_server_ip=$2
proxy_server_ip=$3
full_name=$4
proxy_server_port=$5

### CHECK IF PORT NUMBER WAS SENT: THIS WORKS FOR SINGLE AND CONTAINER
if [ -z "$proxy_server_port" ]
then
  proxy_server_port=80
fi
echo "" ; echo -e "\e[1;33m ADDING TO /etc/nginx/sites-available/$server_name"; tput sgr0
echo "server {
        listen $new_server_ip:80;
        server_name $full_name;

        location / {
                proxy_pass http://$proxy_server_ip:$proxy_server_port;
                proxy_redirect default;
                proxy_read_timeout 900;
                proxy_send_timeout 900;

                ### HTACCESS: Enable User Login
                auth_basic 'Restricted';
                auth_basic_user_file /etc/nginx/htaccess/.htpasswd;
        }
}" > /etc/nginx/sites-available/$server_name

echo -e "\e[1;33m ENABLE PROXY: $full_name"; tput sgr0
ln -s /etc/nginx/sites-available/$server_name /etc/nginx/sites-enabled/$server_name

echo -e "\e[1;32m RESTARTING PROXY..."; tput sgr0
service nginx restart
