#!/bin/bash
start_green="\033[92m"
end_green="\033[39m"

echo -e "\n${start_green} Installing dependencies and fonts...${end_green}"

sudo apt install brightnessctl j4-dmenu-desktop
cp monaco.ttf ~/.local/share/fonts

echo -e "\n${start_green} Fixing brightness controls for ${USER}...${end_green}"

sudo cp 90-brightnessctl.rules /etc/udev/rules.d/
sudo usermod -a -G video $(whoami)

echo -e "\n${start_green} Fixing snap apps in menu... ${end_green}"

snap_apps_fix=/etc/profile.d/apps-bin-path.sh
if [[ ! -f "${snap_apps_fix}" ]]; then
    sudo cp snap-apps-fix.sh ${snap_apps_fix}
fi
