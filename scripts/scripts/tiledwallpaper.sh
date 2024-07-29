#!/bin/sh

bordersize=1
tileSize=$(($2-2*bordersize))
echo $tileSize
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
	tomorrow-day)
		bgColour="#FAFAFA"
		borderColour="#4D4D4C"
		;;
	gruvbox|*)
		bgColour="#1D2021"
		borderColour="#3C3836"
		;;
esac

magick -size "$((tileSize))x$tileSize" xc:$bgColour -border "$bordersize"x"$bordersize" -bordercolor "$borderColour" tile.png
