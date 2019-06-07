#!/bin/bash
source scripts/colours.sh

current=${PWD}

# Create home directory folders
mkdir -p ~/.config
mkdir -p ~/.local/share/applications
mkdir -p ~/Pictures
mkdir -p ~/.local/share/fonts

scripts/install-dependencies.sh

echo -e "\n${start_green} Fixing brightness controls for ${USER}...${end_green}"

sudo cp assets/90-brightnessctl.rules /etc/udev/rules.d/
sudo usermod -a -G video $(whoami)

echo -e "\n${start_green} Fixing snap apps in menu... ${end_green}"

snap_apps_fix=/etc/profile.d/apps-bin-path.sh
if [[ ! -f "${snap_apps_fix}" ]]; then
    sudo cp scripts/snap-apps-fix.sh ${snap_apps_fix}
fi

echo -e "\n${start_green} Linking sway config folders into ~/.config... ${end_green}"

folders_to_linky=("sway" "waybar" "kanshi" "rofi" "assets/icons" "swaylock")
for folder in ${folders_to_linky[@]}; doQ
    if [[ ! -e "${HOME}/.config/${folder}" ]]; then
        ln -s ${PWD}/${folder}/ "${HOME}/.config/"
    fi
done

echo -e "\n${start_green} Installing assets (backgrounds, fonts, app desktop files... ${end_green}"


# Backgrounds
ln -s ${current}/assets/backgrounds ~/Pictures/

# Fonts
ln -s ${current}/assets/fonts/* ~/.local/share/fonts/

# Make FF wayland default (workaround to https://bugzilla.mozilla.org/show_bug.cgi?id=1508803)
ln -s ${current}/assets/firefox-wayland.desktop ~/.local/share/applications
ln -s ${current}/assets/firefox-nightly.desktop ~/.local/share/applications
xdg-settings set default-web-browser firefox-nightly.desktop

# Install Scripts in bin folder
ln -s ${current}/scripts/brightness-notification.sh ~/bin/
ln -s ${current}/scripts/audio-notification.sh ~/bin/
ln -s ${current}/notify-send.sh/notify-*.sh ~/bin/
