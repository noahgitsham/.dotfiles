#!/bin/sh

status=$(warp-cli status | awk '{print $3}')

if [ "$status" = "Connected" ]; then
	warp-cli disconnect > /dev/null
	echo "Disconnected"
else
	warp-cli connect > /dev/null
	echo "Connected"
fi
