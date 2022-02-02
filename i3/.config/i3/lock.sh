#!/bin/bash

# set the icon and a temporary location for the screenshot to be stored
#icon="$HOME/images/lock-icon-light.png"
tmpbg='/tmp/screen.png'
orig=$HOME/wallpapers/mountain.jpg
BLURTYPE="2x8"

# blur the screenshot by resizing and scaling back up
#convert "$orig" -blur $BLURTYPE "$tmpbg"

# overlay the icon onto the screenshot
#convert "$tmpbg" "$icon" -gravity center -composite "$tmpbg"

# lock the screen with the blurred screenshot
#i3lock -i "$tmpbg"

i3lock -i $orig 2>&1 >> ~/.config/i3/lock.log  &
LOCK_PID=$!
(while pidof i3lock ; do
  if (fprintd-verify $USER | grep verify-match); then 
    killall i3lock
  fi
done) & 
