#!/bin/sh

driveID="$(blkid -L "$1")"
if [ -z "$driveID" ]; then
	echo "No drive with label \"$1\" found."
	exit 1
fi

umount "$driveID"
