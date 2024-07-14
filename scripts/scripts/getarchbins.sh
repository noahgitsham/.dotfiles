#!/bin/sh

pacman -Fx "^usr/bin/[^/]+$" | sed 's/usr\/bin\/\([^ ]*\).*/\1/'
