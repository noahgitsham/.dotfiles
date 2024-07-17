#!/usr/bin/env bash

nohup "$@" >&/dev/null &
echo "$(ps -p $! -o comm=) launched with PID: $!"
