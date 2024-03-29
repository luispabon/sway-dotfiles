#!/bin/bash

laptop_speakers=`pactl list short sinks | grep pci | grep analog-stereo | awk 'BEGIN {FS="\t"}; {print $2}'`
bose_headphones="bluez_output.78_2B_64_16_45_95.1"

current_sink=`pactl get-default-sink`

echo "Audio switcher :: current audio sink: $current_sink"

next_sink=$laptop_speakers
if [[ "$current_sink" == "$laptop_speakers" ]]; then
    next_sink=$bose_headphones
fi

echo "Audio switcher :: switching to: $next_sink"

exec pactl set-default-sink $next_sink

echo "Audio switcher :: done"
