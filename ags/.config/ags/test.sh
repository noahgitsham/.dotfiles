#!/bin/sh

while inotifywait -q -e close_write config.js || true; do echo "config change"; ags -q; ags & done
#inotifywait -q -m -e close_write ./config.js |
#while read -r filename event; do
#	echo "Hi"
#	ags -q; ags
#done
