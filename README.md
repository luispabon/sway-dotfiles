# Sway dotfiles

This is my sway configuration, together with scripts and assets required to make it work.

## Install scripts

I use ubuntu 19.04, and as such any package installation stuff on the scripts are for ubuntu 19.04.
  * [install_base.sh](install_base.sh) will install the minimum requirements to build sway from my repo https://github.com/luispabon/sway-ubuntu-build
  * [install_base.sh](install_exclusive.sh) is meant to be used on an ubuntu minimal ISO install, and will install the minimum requirements to run sway with a native wayland file manager, terminal, connection manager and pulseaudio
  * [install.sh](install.sh) does a number of things. Adds a ppa with sway which is reasonably recent (if you don't compile from the repo above), installs stuff like grim, and rofi, fonts, notifications, icons for the notifications, configs for sway, swaylock, mako etc.

To make it all work you need to add `~/bin` to your path as some of the scripts install in there. You also need a build of waybar (again you can compile by yourself from the repo above).

## Notifications

Make sure you pull submodules as you'll need https://github.com/vlevit/notify-send.sh to make notifications work.

There are notification scripts for volume and brightness, and sway bindings for these on fn keys (but not waybar).
