#!/bin/bash

# Terminate already running bar instances
kill -9 `pgrep polybar`

# Launch Polybar, using default config location ~/.config/polybar/config

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar top 2>~/.config/polybar/poly.log &
  done
else
  polybar top 2>~/.config/polybar/poly.log &
fi

echo "Polybar launched..."
