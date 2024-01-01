#!/bin/sh

qrencode -o - -t UTF8 -r "$1"
