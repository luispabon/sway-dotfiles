#!/bin/bash

class=$(playerctl metadata --player=spotify --format '{{lc(status)}}')
icon=""

info=$(playerctl metadata --player=spotify --format '{{artist}} - {{title}}')
if [[ ${#info} > 40 ]]; then
  info=$(echo $info | cut -c1-40)"..."
fi

if [[ "${class}" == "playing" ]]; then
  text=$icon" "$info" ""[playing]"
elif [[ "${class}" == "paused" ]]; then
  text=$icon" "$info" ""[paused]"
elif [[ "${class}" == "stopped" ]]; then
  text=$icon
fi

echo -e "{\"text\":\""$text"\", \"class\":\""$class"\"}"
