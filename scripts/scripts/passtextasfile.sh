#!/bin/sh

echo "$2" | $1 "/dev/stdin"

#$1 <(cat <<< "$2")
