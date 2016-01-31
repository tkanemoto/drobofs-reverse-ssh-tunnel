#!/bin/sh

. `dirname \`realpath $0\``/config.source

while true ; do
  if [ -e $logfile ] ; then mv $logfile $logfile.last ; fi
  echo $$ > $pidfile
  /mnt/DroboFS/Shares/DroboApps/openssh/bin/ssh -vvvv -C -nNT -R $remote_port:localhost:$local_port $remote_server > $logfile 2>&1
  if [ $? != 0 ] ; then sleep 3 ; fi
done
