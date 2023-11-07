#!/bin/env bash

if [ $# -eq 0 ]; then
	echo "Missing argument: partition label"
	exit 1
else
	## Backup system data to home ##
	backuppath="~/backups/"
	if [ ! -d $backuppath ]; then
		mkdir -p $backuppath
	fi

	# Backup list of explicitly installed packages
	pacman -Qqe > "$backuppath/pkglist.txt"

	# Backup pacman config
	cp /etc/pacman.conf "$backuppath"

	# Backup grub config
	cp /etc/default/grub "$backuppath"


	## Backup home to external drive ##
	partitionlabel="$1"
	backupdrivepath="/run/media/$USER/$partitionlabel/homebackup"
	if [ ! -d $backupdrivepath ]; then
		mkdir -p $backupdrivepath
	fi
	# Perform home backup
###	rsync
fi
