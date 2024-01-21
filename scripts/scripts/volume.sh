#!/bin/sh

case $1 in
	mute) pamixer -t ;;
	+5) pamixer -i 5 ;;
	-5) pamixer -d 5 ;;
esac

if [ "$(pamixer --get-mute)" = "true" ]; then
	notify-send -r 1 -u low -t 1250 -i "" "Volume | Muted" -h int:value:0
else
	volume=$(pamixer --get-volume)
	notify-send -r 1 -u low -t 1250 -i "" "Volume | $volume%" -h int:value:"$volume"
fi

