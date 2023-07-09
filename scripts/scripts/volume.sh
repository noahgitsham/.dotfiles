#!/usr/bin/env bash

case $1 in
	"mute")
		pactl set-sink-mute 0 toggle ;;
	"-5") pactl set-sink-volume 0 -5% ;;
	"+5") pactl set-sink-volume 0 +5% ;;
esac

#echo $(pactl get-sink-volume 0) | sed -e 's,\\d\\d(?=%),\1,'
#volume=$(pactl get-sink-volume 0) | grep -e '\\d\\d(?=%)'

volume=$(pactl list sinks | grep '^[[:space:]]Volume:' | \
	head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')

dunstify -r 1 -t 1250 "Volume | $volume%" -h int:value:$(($volume))
