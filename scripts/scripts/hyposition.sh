#!/usr/bin/sh

if [ -z "$1" ]; then
	left="
	┌───┐
	│   │
	│   ├──────┐
	│   │ Main │
	└───┴──────┘"
	echo "left:$left"

	above="
	┌──────┐
	│      │
	├──────┤
	│ Main │
	└──────┘"
	echo "above:$above"
	exit 1
fi

if [ "$1" = "left" ]; then
	hyprctl keyword monitor eDP-1,1920x1200@60,1080x720,1
    hyprctl keyword monitor HDMI-A-1,1920x1080,0x0,1,transform,1
elif [ "$1" = "above" ]; then
	hyprctl keyword monitor eDP-1,1920x1200@60,0x1080,1
    hyprctl keyword monitor HDMI-A-1,1920x1080,0x0,1,transform,0
fi


monitor=eDP-1,1920x1200@60,1080x720,1
monitor=HDMI-A-1,1920x1080,0x0,1,transform,1
