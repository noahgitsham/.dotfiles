#!/usr/bin/env bash

echo "$2" | $1 "/dev/stdin"

#$1 <(cat <<< "$2")
