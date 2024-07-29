#!/bin/sh

if [ -n "$1" ]; then
	nohup "$@" > /dev/null 2>&1 &
	echo "$(ps -p $! -o comm=) launched with PID: $!"
else
	echo "Provide a command to run"
fi
