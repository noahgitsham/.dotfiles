#!/bin/env bash

secondMonitor = $(xrander -q | grep "HDMI")

if [[$secondMonitor = *connected*]]; then
	xrandr --output
