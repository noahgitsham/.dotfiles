#!/usr/bin/env bash

nohup $@ >&/dev/null &
echo "Pid: $!"
#disown "%nohup"
