#!/bin/sh

tileSize=$(($1-2))
case "$1" in
	purple)
		bgColour="#1D2021"
		borderColour="#3C3836"
		;;
	gruvbox|*)
		bgColour="#1D2021"
		borderColour="#3C3836"
		;;
esac

magick convert -size "$((tileSize))x$tileSize" -border 1x1 -bordercolor "$borderColour" xc:$bgColour tile.png
