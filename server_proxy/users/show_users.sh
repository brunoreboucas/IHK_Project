#!/bin/bash

file=/etc/nginx/htaccess/.htpasswd

echo ""
while read -r line
do
  user=${line%:*}
  echo -e "\e[1;33m $user"; tput sgr0
done < $file
echo ""
