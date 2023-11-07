#!/bin/env bash

if [ $# -eq 0 ]; then
	echo "Missing argument: partition label"
	exit 1
else
	drivepath="/run/media/$USER/$1/homebackup"
	if [ ! -d "$drivepath" ]; then
	  mkdir -p $drivepath
	fi
	cp -r /home/user $drivepath
fi
