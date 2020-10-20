#!/bin/bash
start_green="\033[92m"
end_green="\033[39m"

current=${PWD}

# Create home directory folders
mkdir -p ~/.config
mkdir -p ~/bin
mkdir -p ~/Pictures
mkdir -p ~/.local/share/applications
mkdir -p ~/.local/share/fonts
mkdir -p ~/logs

# FF beta ppa (wayland support pre-69 is pretty glitchy)
sudo add-apt-repository ppa:mozillateam/firefox-next

# Ulauncher
sudo add-apt-repository ppa:agornostal/ulauncher

# Azote (wallpaper manager) https://github.com/nwg-piotr/azote
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/Head_on_a_Stick:/azote/xUbuntu_19.04/ /' > /etc/apt/sources.list.d/azote.list"
curl https://download.opensuse.org/repositories/home:/Head_on_a_Stick:/azote/xUbuntu_19.04/Release.key | sudo apt-key add -
touch ~/.azotebg

# Install all the rest of them things
sudo apt install \
    sway \
    sway-backgrounds \
    swaybg \
    swayidle \
    mako-notifier \
    azote \
    bash \
    brightnessctl \
    firefox \
    jq \
    grim \
    libglib2.0-bin \
    libmpdclient2 \
    libnl-3-200 \
    libnotify4 \
    libnotify-bin \
    moreutils \
    playerctl \
    python3-pip \
    gir1.2-playerctl-2.0 \
    units \
    rofi \
    slurp \
    tlp \
    ulauncher \
    wl-clipboard \
    wmctrl \
    xdg-desktop-portal-wlr \
    xdotool

echo -e "\n${start_green} Fixing brightness controls for ${USER}...${end_green}"

sudo cp assets/90-brightnessctl.rules /etc/udev/rules.d/
sudo usermod -a -G video $(whoami)

echo -e "\n${start_green} Libinput festures for ${USER}...${end_green}"
sudo usermod -a -G input $(whoami)

echo -e "\n${start_green} Setting longid config...${end_green}"

sudo cp /etc/systemd/logind.conf /etc/systemd/logind.conf-bak
sudo cp assets/logind.conf /etc/systemd/logind.conf
sudo cp /etc/pulse/daemon.conf /etc/pulse/daemon.conf-bak
sudo cp assets/etc-pulse-daemon.conf /etc/pulse/daemon.conf
sudo cp assets/etc-sysctl.d-jetbrains-inotify.conf /etc/sysctl.d/99-jetbrains-inotify.conf
sudo cp assets/etc-modprobe-d-audio-powersave.conf /etc/modprobe.d/audio-powersave.conf

echo -e "\n${start_green} Fixing snap apps in menu... ${end_green}"

snap_apps_fix=/etc/profile.d/apps-bin-path.sh
if [[ ! -f "${snap_apps_fix}" ]]; then
    sudo cp scripts/snap-apps-fix.sh ${snap_apps_fix}
fi

echo -e "\n${start_green} Linking sway config folders into ~/.config... ${end_green}"

folders_to_linky=("configs/sway" "configs/waybar" "configs/kanshi" "configs/rofi" "configs/mako" "assets/icons" "configs/swaylock")
for folder in ${folders_to_linky[@]}; do
    if [[ ! -e "${HOME}/.config/${folder}" ]]; then
        ln -sf ${PWD}/${folder}/ "${HOME}/.config/"
    fi
done

ln -sf ${current}/configs/libinput-gestures.conf ~/.config/

echo -e "\n${start_green} Installing assets (backgrounds, fonts, app desktop files... ${end_green}"

ln -sf ${current}/assets/backgrounds ~/Pictures/
ln -sf ${current}/assets/fonts/* ~/.local/share/fonts/

# Install Scripts in bin folder
ln -sf ${current}/scripts/notifications/brightness-notification.sh ~/bin/
ln -sf ${current}/scripts/notifications/audio-notification.sh      ~/bin/
ln -sf ${current}/scripts/notifications/button.sh                  ~/bin/
ln -sf ${current}/scripts/notifications/network-manager            ~/bin/
ln -sf ${current}/scripts/docker                                   ~/bin/
ln -sf ${current}/scripts/screenshots.sh                           ~/bin/
ln -sf ${current}/notify-send.sh/notify-*.sh                       ~/bin/
ln -sf ${current}/ssway                                            ~/bin/

# Install login session
sudo cp ${current}/ssway /usr/bin/ssway
sudo cp ${current}/swayfire /usr/bin/swayfire
sudo cp ${current}/assets/ubuntu-wayfire.desktop /usr/share/wayland-sessions/

# Enable mpd to connect to pulseaudio
mkdir -p ~/.config/pulse
cp /etc/pulse/default.pa ~/.config/pulse/
sed -i 's/^#load-module module-native-protocol-tcp$/load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1/g' ~/.config/pulse/default.pa

# For autotiling git@github.com:nwg-piotr/autotiling.git
pip3 install i3ipc
ln -sf ${current}/scripts/autotiling/autotiling.py ~/bin/
