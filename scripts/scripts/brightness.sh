#!/bin/sh

brightness=$(light -G)
brightness=$(echo "$brightness" | awk '{print int($1+0.5)}')

case $1 in
	"+5")
		brightness=$((brightness + 5))
		if [ "$brightness" -gt 100 ]; then
			brightness=100
		fi
		;;
	"-5")
		brightness=$((brightness - 5))
		if [ "$brightness" -lt 0 ]; then
			brightness=0
		fi
		;;
esac

notify-send -r 1 -u low -t 1250 -i "" "Brightness | $brightness%" -h int:value:"$brightness"

ddcutil setvcp 10 "$brightness" &
light -S "$brightness" &
