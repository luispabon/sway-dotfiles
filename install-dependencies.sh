#!/bin/bash
source ./colours.sh
current=dirname "$(readlink -f "$0")"

echo -e "\n${start_green} Installing dependencies...${end_green}"

sudo add-apt-repository ppa:samoilov-lex/sway
sudo add-apt-repository ppa:ubuntu-mozilla-daily/ppa

sudo apt install \
    brightnessctl \
    grim \
    slurp \
    sway \
    sway-backgrounds \
    swaybg \
    swayidle \
    swaylock \
    xdg-desktop-portal-wlr \
    wl-clipboard \
    libmpdclient2 \
    libnl-3-200 \
    playerctl \
    rofi \
    firefox-trunk
