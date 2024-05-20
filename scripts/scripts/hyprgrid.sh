#!/bin/sh

activewidth=$(hyprctl activewindow -j | jq ".size[0]")
activeheight=$(hyprctl activewindow -j | jq ".size[1]")

if [ "$activewidth" -ge "$activeheight" ]; then
	echo "fat"
else
	echo "tall"
fi
