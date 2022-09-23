#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Terminate already running bar instances
killall -9 polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

export MONITOR=$(polybar -m|head -1|sed -e 's/:.*$//g')
# export MONITOR=DP-0

# Launch bar1 and bar2
exec polybar main >$DIR/polybar.log 2>&1
