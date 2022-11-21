#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# MONITOR=$(polybar -m|tail -1|sed -e 's/:.*$//g')
MONITOR=eDP-1-1

# Launch bar1 and bar2
exec polybar main >/tmp/polybar.log 2>&1
