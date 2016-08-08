#!/bin/bash

echo "" ; echo -e "\e[31mUPDATE USER"; tput sgr0
read -p "Please user name: " user_name
echo -e "User name: \e[1;31m$user_name"; tput sgr0
read -p "Is that correct(Y/N): " option_user_name
if [ $option_user_name == "Y" ] || [ $option_user_name == "y" ]
then
  file=/etc/nginx/.htpasswd
  search=`grep $user_name $file`
  if [ $search ]
  then
    htpasswd $file $user_name
  else
    echo "User to be updated not found..."
  fi
else
  echo "Aborted by choosing user name..."
fi
