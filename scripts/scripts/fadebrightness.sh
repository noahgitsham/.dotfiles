#!/bin/sh

s=$(light -G | awk '{print int($1+0.5)}')
t=$1
d=$((t-s))
echo $d

steps=15

for step in $(seq 0 $steps); do
	#b=$((s+d*(step/steps)))
	b=$(echo "scale = 1; $s+$d*($step/$steps)" | bc)
	echo "Setting: $b"
	light -S "$b"
	sleep 0.02
done

#light -S 35
#sleep 0.2
#light -S 26
#sleep 0.2
#light -S 17
#sleep 0.2
#light -S 08
