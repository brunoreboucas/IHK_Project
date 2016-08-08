#!/bin/bash

echo "" ; echo -e "\e[31mDELETE USER"; tput sgr0
read -p "Please user name: " del_user_name
echo -e "User name: \e[1;31m$del_user_name"; tput sgr0
read -p "Is that correct(Y/N): " option_user_name
if [ $option_user_name == "Y" ] || [ $option_user_name == "y" ]
then
  file=/etc/nginx/htaccess/.htpasswd
  search=`grep $del_user_name $file`
  if [ $search ]
  then
    htpasswd -D $file $del_user_name
  else
    echo "User to be deleted not found..."
  fi
else
  echo "Aborted by choosing user name..."
fi
