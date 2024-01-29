#!/bin/sh

monitors=$(hyprctl monitors -j | jq ". | length")
if [ "$monitors" -gt 1 ]; then
	currentMonitorID=$(hyprctl activeworkspace -j | jq '.["monitorID"]')
	newmonitor=$(((currentMonitorID+$1)%monitors))
	echo "$currentMonitorID+$1%$monitors"
	echo $newmonitor
	hyprctl dispatch movecurrentworkspacetomonitor "$newmonitor"
	hyprctl dispatch focusmonitor "$newmonitor"
fi
