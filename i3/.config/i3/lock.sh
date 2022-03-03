#!/bin/bash

# set the icon and a temporary location for the screenshot to be stored
icon="$HOME/wallpapers/lock.png"
orig=/home/amos/wallpapers/screen_saver.png

#convert -scale $(xdpyinfo | grep dimensions | cut -d\  -f7) $orig $orig
#convert -resize 1920X2000 $orig $orig

# lock the screen with the blurred screenshot
#i3lock -i "$orig" --ignore-empty-password 



i3lock --ignore-empty-password --color=000000
LOCK_PID=$!
(while pidof i3lock ; do
  if (fprintd-verify $USER | grep verify-match); then 
    killall i3lock
  fi
done) & 
