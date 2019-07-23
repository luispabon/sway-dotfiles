#!/bin/bash

# Script to create pop-up notification when volume changes.

# Create a delay so the change in volume can be registered:
sleep 0.05

# Get the volume and check if muted or not (STATE):
VOLUME=`amixer -D pulse sget Master | \
        grep 'Left:' | \
        awk -F'[][]' '{ print $2 }' | \
        sed --expression 's/%//g'`

STATE=`amixer -D pulse sget Master          | \
       egrep -m 1 'Playback.*?\[o' | \
       egrep -o '\[o.+\]'`

# Have a different symbol for varying volume levels:
if [[ $STATE != '[off]' ]]; then
        if [ "${VOLUME}" == "0" ]; then
                ICON=~/.config/icons/vol-mute.png
        elif [ "${VOLUME}" -lt "33" ] && [ $VOLUME -gt "0" ]; then
                ICON=~/.config/icons/vol-low.png
        elif [ "${VOLUME}" -lt "90" ] && [ $VOLUME -ge "33" ]; then
                ICON=~/.config/icons/vol-med.png
        else
                ICON=~/.config/icons/vol-high.png
        fi

        notify-send.sh "Volume: $VOLUME%" \
            --replace-file=/tmp/audio-notification \
            -t 2000 \
            -i ${ICON} \
            -h int:value:${VOLUME} \
            -h string:synchronous:volume-change

# If volume is muted, display the mute sybol:
else
        notify-send.sh "Muted (volume: $VOLUME%)" \
            --replace-file=/tmp/audio-notification \
            -t 2000 \
            -i ~/.config/icons/vol-mute.png \
            -h int:value:${VOLUME} \
            -h string:synchronous:volume-change
fi
