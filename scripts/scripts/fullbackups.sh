#!/bin/env bash

if [ $# -eq 0 ]; then
	echo "Missing argument: partition label"
	exit 1
else
	drivepath="/run/media/$USER/$1"
	if [ ! -d "$drivepath/homedir" ]; then
	  mkdir -p $drivepath/homedir
	fi
	cp -r ~/* $drivepath/homedir
fi
