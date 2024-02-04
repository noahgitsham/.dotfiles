#!/bin/sh

fc-list | grep -i "$1" | awk -F':|: ' '{print $2}' | awk -F',' '{print $NF}' | sort
