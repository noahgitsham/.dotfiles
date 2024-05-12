#!/bin/sh

bordersize=1
tileSize=$(($1-2*bordersize))
case "$1" in
	purple)
		bgColour="#1D2021"
		borderColour="#3C3836"
		;;
	gob)
		bgColour="#3C3836"
		borderColour="#000000"
		;;
	gow)
		bgColour="#000000"
		borderColour="#FFFFFF"
		;;
	gruvbox|*)
		bgColour="#1D2021"
		borderColour="#3C3836"
		;;
esac

magick convert -size "$((tileSize))x$tileSize" -border "$bordersize"x"$bordersize" -bordercolor "$borderColour" xc:$bgColour tile.png
