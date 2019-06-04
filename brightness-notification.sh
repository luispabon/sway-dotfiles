#!/bin/bash

# Get the brightness percentage:
MAX_BRIGHTNESS=$(cat /sys/class/backlight/intel_backlight/max_brightness);
BRIGHTNESS=$(cat /sys/class/backlight/intel_backlight/actual_brightness);
PCT=$(echo $BRIGHTNESS $MAX_BRIGHTNESS  | awk '{printf "%4.0f\n",($1/$2)*100}' | tr -d '[:space:]')

# Round the brightness percentage:
LC_ALL=C

# Send the notification with the icon:
notify-send.sh "Brightness ${PCT}%" \
    --replace-file=/tmp/brightness-notification \
    -t 2000 \
    --icon ~/.config/icons/brightness-icon.png \
    -h int:value:${PCT} \
    -h string:synchronous:brightness-change
