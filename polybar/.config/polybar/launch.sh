#!/bin/bash

# Terminate already running bar instances
kill -9 `pgrep polybar`


# wait for pulseaudio 
until pid=$(pidof pulseaudio)
do
  sleep 1 
done

# Launch Polybar, using default config location ~/.config/polybar/config
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d " " -f1); do
    MONITOR=$m polybar -q top 2>~/.config/polybar/poly.log &
  done
else
  polybar -q top 2>~/.config/polybar/poly.log &
fi

echo "Polybar launched..."
