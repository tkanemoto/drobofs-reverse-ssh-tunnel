#!/bin/sh
echo $$ > reverse-sshfs.pid

remote_server=$1
remote_port=$2
remote_mountpoint=$3
share_name=$4
drobo_user=$5

[ -n "$remote_server ] || exit 1
[ -n "$remote_port" ] || remote_port=14443
[ -n "remote_mountpoint" ] || remote_mountpoint=share/
[ -n "share_name" ] || share_name=share
[ -n "drobo_user" ] || drobo_user=root

while true ; do
  ssh -R $remote_port:localhost:22 $remote_server \
    "sshfs -p $remote_port $drobo_user@localhost:/mnt/DroboFS/Shares/$share_name $remote_mountpoint"
  sleep 10
done
