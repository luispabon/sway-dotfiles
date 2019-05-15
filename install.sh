#!/bin/bash
start_green="\033[92m"
end_green="\033[39m"

echo -e "\n${start_green} Installing dependencies and fonts...${end_green}"

sudo apt install \
    brightnessctl \
    j4-dmenu-desktop

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

folders_to_linky=("sway" "i3status" "waybar" )
for folder in ${folders_to_linky[@]}; do
    if [[ ! -f "~/.config/${folder}" ]]; then
        ln -s ${PWD}/${folder}/ "${HOME}/.config/${folder}"
    fi
done
