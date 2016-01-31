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
	$prog_dir/tunnel.sh &
}

kill_ssh()
{
	sshpid=`ps -w | grep "ssh .*:$local_port $remote_server" | grep -v grep | awk '{print $1}'`
	if [ -n "$sshpid" ] ; then
		echo "Killing $sshpid"
		kill $sshpid
	fi
}

case "$1" in
start)
	start_service
	;;
stop)
	stop_service
	kill_ssh
	;;
restart)
	stop_service
	kill_ssh
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
