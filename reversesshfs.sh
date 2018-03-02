#!/bin/sh
echo $$ > `dirname \`realpath $0\``/reversesshfs.pid

. `dirname \`realpath $0\``/config.source

ssh $remote_server "sudo mkdir -p $remote_mountpoint"
#ssh $remote_server "sudo chown ubuntu:ubuntu $remote_mountpoint"

while true ; do
  ssh -R $remote_port:localhost:22 $remote_server \
    "sudo sshfs -p $remote_port $extra_args $drobo_user@localhost:/mnt/DroboFS/Shares/$share_name $remote_mountpoint"
  sleep 10
done
