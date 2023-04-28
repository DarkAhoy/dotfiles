#!/bin/bash 

echo -e "Copying config files...\n"
cp -R ./dotconfig/dunst ~/.config/
cp -R ./dotconfig/hypr ~/.config/
cp -R ./dotconfig/kitty ~/.config/
cp -R ./dotconfig/pipewire ~/.config/
cp -R ./dotconfig/rofi ~/.config/
cp -R ./dotconfig/swaylock ~/.config/
cp -R ./dotconfig/waybar ~/.config/
cp -R ./dotconfig/wlogout ~/.config/

# Set some files as exacutable 
chmod +x ~/.config/hypr/xdg-portal-hyprland
chmod +x ~/.config/waybar/scripts/waybar-wttr.py
