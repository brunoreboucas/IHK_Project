#!/bin/bash

echo "" ; echo -e "\e[31mADD NEW USER"; tput sgr0
read -p "Please enter new user name: " new_user_name
echo -e "New user name: \e[1;31m$new_user_name"; tput sgr0
read -p "Is that correct(Y/N): " option_user_name
if [ $option_user_name == "Y" ] || [ $option_user_name == "y" ]
then
  htpasswd /etc/nginx/htaccess/.htpasswd $new_user_name
else
  echo "Aborted by choosing new user name..."
fi
