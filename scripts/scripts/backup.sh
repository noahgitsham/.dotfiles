#!/bin/env bash

if [ $# -eq 0 ]; then
	echo "Missing argument: partition label"
	exit 1
else
	## Backup system data to home ##
	backuppath="$HOME/.backups/"
	if [ ! -d "$backuppath" ]; then
		mkdir -p "$backuppath"
	fi

	# Backup list of explicitly installed packages
	pacman -Qqe > "$backuppath/pkglist.txt"

	# Backup pacman config
	cp /etc/pacman.conf "$backuppath"

	# Backup grub config
	cp /etc/default/grub "$backuppath"

	# Sync files to external drive
	drivePath="/run/media/$USER/$1/homebackup"
	if [ ! -d "$drivePath" ]; then
	  echo "Drive \"$1\" does not exist."
	  exit 1
	fi

	rsync -avxP --delete "$HOME" "$drivePath" --exclude=".local" --exclude=".cache" --exclude=".ollama" --exclude=".rustup" --exclude=".cargo" --exclude=".stremio-server" --exclude="software/wine"
fi
