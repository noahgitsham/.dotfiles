#!/bin/sh

export WINEARCH=win64
export WINEPREFIX=~/software/wine/Ableton

if [ -z "$1" ]; then
wine64 "$WINEPREFIX/drive_c/ProgramData/Ableton/Live 11 Suite/Program/Ableton Live 11 Suite.exe"
fi
