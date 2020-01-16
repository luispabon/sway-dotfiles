#!/bin/bash

sudo apt install \
    connman \
    connman-gtk \
    cron \
    snapd \
    curl \
    ca-certificates \
    yaru-theme-icon \
    pulseaudio \
    xwayland \
    libjsoncpp1 \
    libsigc++ \
    libgtkmm-3.0-1v5 \
    pavucontrol \
    ubuntu-restricted-extras \
    ack

sudo apt install --no-install-recommends \
    gnome-terminal \
    gnome-calendar \
    gnome-online-accounts \
    gnome-control-center \
    nautilus \
    libreoffice

folders_to_linky=("gtk-3.0")
for folder in ${folders_to_linky[@]}; do
    if [[ ! -e "${HOME}/.config/${folder}" ]]; then
        ln -s ${PWD}/${folder}/ "${HOME}/.config/${folder}"
    fi
done
