#!/bin/bash
start_green="\033[92m"
end_green="\033[39m"

current=${PWD}

echo -e "\n${start_green} Installing dependencies and fonts...${end_green}"

sudo add-apt-repository ppa:samoilov-lex/sway

sudo apt install \
    brightnessctl \
    j4-dmenu-desktop \
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
    libnl-3-200

cp monaco.ttf ~/.local/share/fonts

echo -e "\n${start_green} Fixing brightness controls for ${USER}...${end_green}"

sudo cp 90-brightnessctl.rules /etc/udev/rules.d/
sudo usermod -a -G video $(whoami)

echo -e "\n${start_green} Fixing snap apps in menu... ${end_green}"

snap_apps_fix=/etc/profile.d/apps-bin-path.sh
if [[ ! -f "${snap_apps_fix}" ]]; then
    sudo cp snap-apps-fix.sh ${snap_apps_fix}
fi

echo -e "\n${start_green} Linking sway config folders into ~/.config... ${end_green}"

folders_to_linky=("sway" "i3status" "waybar" "kanshi")
for folder in ${folders_to_linky[@]}; do
    if [[ ! -e "${HOME}/.config/${folder}" ]]; then
        ln -s ${PWD}/${folder}/ "${HOME}/.config/${folder}"
    fi
done

# Install kanshi
cd builds/kanshi
make build copy-bin
cd ${current}

# Make FF wayland default (workaround to https://bugzilla.mozilla.org/show_bug.cgi?id=1508803)
cp firefox-wayland.desktop ~/.local/share/applications
xdg-settings set default-web-browser firefox-wayland.desktop
