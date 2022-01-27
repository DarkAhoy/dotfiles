#!/bin/bash

# Terminate already running bar instances
kill -9 `pgrep polybar`

# Launch Polybar, using default config location ~/.config/polybar/config
polybar top 2>~/.config/polybar/poly.log &

echo "Polybar launched..."
