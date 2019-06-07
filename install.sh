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
echo -e "\n${start_green} Fixing brightness controls for ${USER}...${end_green}"

sudo cp assets/90-brightnessctl.rules /etc/udev/rules.d/
sudo usermod -a -G video $(whoami)

echo -e "\n${start_green} Fixing snap apps in menu... ${end_green}"

snap_apps_fix=/etc/profile.d/apps-bin-path.sh
if [[ ! -f "${snap_apps_fix}" ]]; then
    sudo cp scripts/snap-apps-fix.sh ${snap_apps_fix}
fi

echo -e "\n${start_green} Linking sway config folders into ~/.config... ${end_green}"

folders_to_linky=("configs/sway" "configs/waybar" "configs/kanshi" "configs/rofi" "assets/icons" "configs/swaylock")
for folder in ${folders_to_linky[@]}; do
    if [[ ! -e "${HOME}/.config/${folder}" ]]; then
        ln -sf ${PWD}/${folder}/ "${HOME}/.config/"
    fi
done

echo -e "\n${start_green} Installing assets (backgrounds, fonts, app desktop files... ${end_green}"

# Backgrounds
ln -sf ${current}/assets/backgrounds ~/Pictures/

# Fonts
ln -sf ${current}/assets/fonts/* ~/.local/share/fonts/

# Make FF wayland default (workaround to https://bugzilla.mozilla.org/show_bug.cgi?id=1508803)
ln -sf ${current}/assets/firefox-wayland.desktop ~/.local/share/applications
ln -sf ${current}/assets/firefox-nightly.desktop ~/.local/share/applications
xdg-settings set default-web-browser firefox-nightly.desktop

# Install Scripts in bin folder
ln -sf ${current}/scripts/notifications/brightness-notification.sh ~/bin/
ln -sf ${current}/scripts/notifications/audio-notification.sh      ~/bin/
ln -sf ${current}/notify-send.sh/notify-*.sh                       ~/bin/
ln -sf ${current}/ssway                                            ~/bin/
