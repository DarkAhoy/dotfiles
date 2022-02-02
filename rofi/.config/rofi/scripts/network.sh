#!/bin/bash


ssid_regex="[A-F0-9]{2}\:[A-F0-9]{2}\:[A-F0-9]{2}\:[A-F0-9]{2}\:[A-F0-9]{2}\:[A-F0-9]{2}" 
networks="$(nmcli dev wifi list)"

list_avail_networks () {
  network_names=$(echo "$networks" | regex_matcher ".*?\s*?\s*($ssid_regex)\s*(\w*)\s*?.*?")
  echo $(echo "$network_names" | rofi -theme $HOME/.config/rofi/style.rasi -i -p "Available networks:" -dmenu)
}

get_password_for_wifi () {
  message="Enter password for $1: "
  echo $(rofi -theme $HOME/.config/rofi/style.rasi -p "$message" -password -dmenu)
}

selected=$(list_avail_networks)
if [[ -z $selected ]]; then 
  exit 0
fi
read ssid network_name <<<$(echo $selected)
password=$(get_password_for_wifi $network_name)
if [[ -z $password ]]; then
  exit 0
fi
echo "Connecting to $(echo $selected | awk '{print $2}')"
 rofi -theme $HOME/.config/rofi/style.rasi -e "$(nmcli dev wifi connect $ssid password $password)" 
