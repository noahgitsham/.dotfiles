#!/bin/env bash

if [ $# -eq 0 ]; then
	echo "Missing argument: partition label"
	exit 1
else
	partition=$1
	pacman -Qqe > ~/backups/pkglist.txt
	cp -r ~/backups /run/media/$USER/$partition/
fi
