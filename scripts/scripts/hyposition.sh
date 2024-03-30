#!/usr/bin/sh

if [ -z "$1" ]; then
	leftr="
	┌───┐
	│   │
	│   ├──────┐
	│   │ Main │
	└───┴──────┘"
	echo "left:$left"

	left="
	┌──────┬──────┐
	│      │ Main │
	└──────┴──────┘"
	echo "leftr:$above"

	above="
	┌──────┐
	│      │
	├──────┤
	│ Main │
	└──────┘"
	echo "above:$above"

	exit 1
fi

case "$1" in
	"left")
		hyprctl keyword monitor eDP-1,1920x1200@60,1920x0,1
		hyprctl keyword monitor HDMI-A-1,1920x1080,0x0,1,transform,0
		;;
	"leftr")
		hyprctl keyword monitor eDP-1,1920x1200@60,1080x720,1
		hyprctl keyword monitor HDMI-A-1,1920x1080,0x0,1,transform,1
		;;
	"above")
		hyprctl keyword monitor eDP-1,1920x1200@60,0x1080,1
		hyprctl keyword monitor HDMI-A-1,1920x1080,0x0,1,transform,0
		;;
	*)
		;;
esac

# Reset wallpaper
killall swaybg
~/scripts/headless.sh ~/scripts/wallpaper.sh

monitor=eDP-1,1920x1200@60,1080x720,1
monitor=HDMI-A-1,1920x1080,0x0,1,transform,1
