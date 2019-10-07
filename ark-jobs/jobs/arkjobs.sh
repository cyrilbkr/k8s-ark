#!/bin/bash

dir="/opt/arkjobs"
server="localhost"
password="admin"
port="32330"
cmd=$1


if ! [ -x "$(command -v rcon-cli)" ]; then
  echo 'Error: rcon-cli is not installed.' >&2
  exit 1
fi


#exec=`rcon-cli --host $server  --port $port --password "$password" $cmd `
#echo "$exec"


echo "- - - - - - - - - -"

numberofplayer=`rcon-cli --host $server  --port $port --password $password ListPlayers  | awk 'NF' |  wc -l`
echo "$numberofplayer survivors online : "
listplayers=`rcon-cli --host $server  --port $port --password $password ListPlayers  | awk 'NF' | awk {'print $2'} | sed -e 's/,//g' `
echo "$listplayers"

echo "- - - - - - - - - -"

