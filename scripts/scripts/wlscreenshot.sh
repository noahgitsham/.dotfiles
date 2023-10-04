#!/usr/bin/env bash
time="$(date +%y-%m-%d-%T)"

sspath="/home/noah/pictures/screenshots/${time}-screenshot.png"

if [ $# -eq 0 ]; then
	grim "$sspath"
else
	case $1 in
		"window") hyprctl -j activewindow | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' | grim -g - $sspath;;
		"select") slurp | grim -g - $sspath;;
	esac
fi

# Copy image to clipboard
wl-copy < $sspath

#Dunst notification
dunstify -r 3 -i $sspath "Screenshot taken"
