#!/bin/env bash

case $1 in
	mute) pamixer -t ;;
	+5) pamixer -i 5 ;;
	-5) pamixer -d 5 ;;
esac

if $(pamixer --get-mute); then
	dunstify -r 1 -t 1250 -i "" "Volume | Muted" -h int:value:0
else
	volume=$(pamixer --get-volume)
	dunstify -r 1 -t 1250 -i "" "Volume | $volume%" -h int:value:$volume
fi

