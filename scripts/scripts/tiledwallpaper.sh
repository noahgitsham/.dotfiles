#!/bin/sh

tileSize=$(($1-2))
bgColour="#1D2021"
borderColour="#3C3836"

magick convert -size "$tileSize"x"$tileSize" -border 1x1 -bordercolor "$borderColour" xc:$bgColour tile.png
