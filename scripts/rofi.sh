#!/bin/bash
#source /etc/profile.d/apps-bin-path.sh
export PATH=${PATH}:/home/luis/bin
rofi -m $(expr $(swaymsg -t get_tree | jq '.nodes | map([recurse(.nodes[]?, .floating_nodes[]?) | .focused] | any) | index(true)') - 1) -show drun -show-icons -drun-icon-theme Yaru -run-command 'swaymsg exec -- {cmd}'
#wofi --show drun --allow-images
