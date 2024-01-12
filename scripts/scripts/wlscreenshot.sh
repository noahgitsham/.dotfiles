#!/bin/sh
time="$(date +%y-%m-%d-%T)"

sspath="/home/noah/pictures/screenshots/${time}-screenshot.png"
success=true

if [ $# -eq 0 ]; then
	grim "$sspath"
else
	case $1 in
		"window") hyprctl -j activewindow | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' | grim -g - "$sspath";;
		"select")
			if output=$(slurp); then
				grim -g "$output" "$sspath"
			else
				success=false
			fi
			;;
	esac
fi

if [ $success = true ]; then
	# Copy image to clipboard
	wl-copy < "$sspath"

	# Send notification
	notify-send -r 3 -i "$sspath" "Screenshot taken"
fi
