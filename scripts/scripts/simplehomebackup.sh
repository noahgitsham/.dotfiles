#!/bin/env bash

if [ $# -eq 0 ]; then
	echo "Missing argument: partition label"
	exit 1
else
	drivePath="/run/media/$USER/$1/homebackup"
	if [ ! -d "$drivepath" ]; then
	  echo "Drive \"$1\" does not exist"
	  exit 1
	fi
	backupPath="$drivePath/homebackup"
	if [ ! -d "$backupPath" ]; then
		mkdir -p $backupPath
	fi

	rsync -avxP $HOME $drivePath --exclude={".local",".cache",".ollama",".rustup",".cargo",".stremio-server"}
fi
