#!/bin/sh

case $1 in
	"+5") light -A 5 ;;
	"-5") light -U 5 ;;
esac

brightness=$(light -G)
dunstify -r 1 -t 1250 -i "" "Brightness | $brightness%" -h int:value:"$brightness"
