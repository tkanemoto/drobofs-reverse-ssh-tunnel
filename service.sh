#!/bin/sh
#
# Reverse SSH tunnel service 

. /etc/service.subr

prog_dir=`dirname \`realpath $0\``
name=`basename $prog_dir`

version="1.0"
export pidfile=$prog_dir/$name.pid
export logfile=$prog_dir/$name.log

. $prog_dir/config.source

start()
{
	start-stop-daemon -S \
		-p $pidfile -m \
		-b \
		-v \
		-x /mnt/DroboFS/Shares/DroboApps/openssh/bin/ssh -- \
			-vvvv -C -nNT -R $remote_port:localhost:$local_port $remote_server
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
