#!/bin/sh
#
# Reverse SSHFS service 

. /etc/service.subr

prog_dir=`dirname \`realpath $0\``

name="reverse-sshfs"
version="1.0"
pidfile=${prog_dir}/${name}.pid
logfile=${prog_dir}/${name}.log


start()
{
	${prog_dir}/${name}.sh >> ${logfile} 2>&1 &
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