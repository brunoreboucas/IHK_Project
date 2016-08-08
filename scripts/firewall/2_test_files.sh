#!/bin/bash

# GET DIRECTORY
DIRECTORY=$1

# REGULAR FILES
files[0]=$DIRECTORY/4_SPI.sh
files[1]=$DIRECTORY/5_log.sh
files[2]=$DIRECTORY/6_filters.sh
files[3]=$DIRECTORY/7_servers_singles.sh
files[4]=$DIRECTORY/8_servers_balancing.sh
files[5]=$DIRECTORY/9_containers_ports.sh
files[6]=$DIRECTORY/10_containers_singles.sh
files[7]=$DIRECTORY/11_containers_balancing.sh

# VARIABLE FILES
files[8]=$DIRECTORY/variables/adapters
files[9]=$DIRECTORY/variables/networks
files[10]=$DIRECTORY/variables/servers
files[11]=$DIRECTORY/variables/used_ports

# SERVERS
files[12]=$DIRECTORY/servers/servers_singles
files[13]=$DIRECTORY/servers/servers_balancing

# CONTAINERS
files[14]=$DIRECTORY/containers/containers_singles
files[15]=$DIRECTORY/containers/containers_balancing

# TEST FILES
for i in "${files[@]}"
do
  file=(${i//;/ })
  if ! [ -f ${file[0]} ];
  then
    echo "${file[0]}"
  fi
done
