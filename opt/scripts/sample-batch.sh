#!/usr/bin/sh

hostname=$(hostname)
dt=$(date +"%Y%m%d_%H%M%S")
pids=( $(pgrep -f "mycommand myargs") )

if [[ -z "$pids" ]]
then
  if [[ $hostname = "devhostpattern"* ]]
  then
    mycommand mydevargs
  elif [[ $hostname = "uathostpattern"* ]]
  then
    mycommand myuatargs
  elif [[ $hostname = "prdhostpattern"* ]]
  then
    mycommand myprdargs
  fi
else
  echo "Another program is currently running, ending this program"
fi
