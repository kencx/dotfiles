#!/bin/bash

killall -q polybar

# wait until process has stopped
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

polybar bar &

echo "Polybar launched..."
