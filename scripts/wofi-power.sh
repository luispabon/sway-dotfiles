#!/bin/sh

# if rofi >= 1.5.2 "Lock \x00icon\x1ffile-browser," works

entries="Logout\nSuspend\nReboot\nShutdown"

# selected=$(echo $entries | rofi -show-icons -m 0 -dmenu -sep ',' -p "power" -i | awk '{print tolower($1)}')
selected=$(echo $entries|wofi --width 300 --height 190 --dmenu --cache-file /dev/null | awk '{print tolower($1)}')

case $selected in
  logout)
    swaymsg exit;;
  suspend)
    exec systemctl suspend;;
  reboot)
    exec systemctl reboot;;
  shutdown)
    exec systemctl poweroff -i;;
esac
