#!/bin/bash


selected=$(echo -e "home\nsingle\noffice" | rofi -theme $HOME/.config/rofi/style.rasi -i -p "Setup: " -dmenu)

case $selected in
  "home")
    home-setup
    ;;
  "single")
    xrandr --auto
    ;;
esac
