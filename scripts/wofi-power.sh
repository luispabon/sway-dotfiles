#!/bin/bash

entries="⇠ Logout\n⏾ Suspend\n⭮ Reboot\n⏻ Shutdown"

export LC_ALL=C
selected=$(echo -e $entries|wofi --width 250 --height 210 --dmenu --cache-file /dev/null | sed 's/[^\x00-\x7F]//g' | awk '{print tolower($1)}')

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
