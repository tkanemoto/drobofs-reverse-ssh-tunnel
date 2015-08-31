#!/bin/sh
#
# Reverse SSHFS service 

. /etc/service.subr

prog_dir=`dirname \`realpath $0\``

name="reversesshfs"
version="1.0"
pidfile=$prog_dir/$name.pid
logfile=$prog_dir/$name.log

. $prog_dir/config.source

start()
{
	$prog_dir/$name.sh \
	  $remote_server \
	  $remote_port \
	  $remote_mountpoint \
	  $share_name \
	  $drobo_user \
	  >> ${logfile} 2>&1 &
}

case "$1" in
start)
	start_service
	;;
stop)
	stop_service
	;;
restart)
	stop_service
	sleep 3
	start_service
	;;
status)
	status
	;;
*)
	echo "Usage: $0 [start|stop|restart|status]"
	exit 1
	;;
esac
