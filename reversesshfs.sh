#!/bin/sh
echo $$ > reverse-sshfs.pid

remote_server=$1
remote_port=$2
remote_mountpoint=$3
share_name=$4
drobo_user=$5

while true ; do
  ssh -R $remote_port:localhost:22 $remote_server \
    "sshfs -p $remote_port $drobo_user@localhost:/mnt/DroboFS/Shares/$share_name $remote_mountpoint"
  sleep 10
done
