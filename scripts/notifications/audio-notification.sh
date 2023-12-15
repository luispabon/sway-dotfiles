#!/bin/bash

# Script to create pop-up notification when volume changes.

# Create a delay so the change in volume can be registered:
sleep 0.05

# Get the volume and check if muted or not (STATE):
VOLUME=`pamixer --get-volume`

# Future: get volume via "wpctl get-volume @DEFAULT_AUDIO_SINK@" and get rid of pulsemixer.

IS_MUTE=`pamixer --get-mute`

# Have a different symbol for varying volume levels:
if [[ $IS_MUTE == 'false' ]]; then
        if [ "${VOLUME}" == "0" ]; then
                ICON=~/.config/icons/vol-mute.png
        elif [ "${VOLUME}" -lt "33" ]; then
                ICON=~/.config/icons/vol-low.png
        elif [ "${VOLUME}" -lt "90" ]; then
                ICON=~/.config/icons/vol-med.png
        else
                ICON=~/.config/icons/vol-high.png
        fi

        ~/sway/notify-send.sh/notify-send.sh "Volume: $VOLUME%" \
            --replace-file=/tmp/audio-notification \
            -t 2000 \
            -i ${ICON} \
            -h int:value:${VOLUME} \
            -h string:synchronous:volume-change

# If volume is muted, display the mute sybol:
else
        ~/sway/notify-send.sh/notify-send.sh "Muted (volume: $VOLUME%)" \
            --replace-file=/tmp/audio-notification \
            -t 2000 \
            -i ~/.config/icons/vol-mute.png \
            -h int:value:${VOLUME} \
            -h string:synchronous:volume-change
fi
