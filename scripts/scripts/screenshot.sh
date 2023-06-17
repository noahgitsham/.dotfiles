#!/usr/bin/env bash
time="$(date +%T-%y-%m-%d)"

sspath="/home/noah/pictures/screenshots/${time}-screenshot.png"

if [ $# -eq 0 ]; then
	scrot "$sspath"
else
	case $1 in
		"window") scrot "$sspath" -u -b ;;
		"select") scrot "$sspath" -s -l mode=edge ;;
	esac
fi

# Copy image to clipboard
xclip -selection clipboard -t image/png -i $sspath

#Dunst notification
dunstify -r 3 -i $sspath "Screenshot taken"
