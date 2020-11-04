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

echo -e "\n${start_green} Installing base apps...${end_green}"
sudo apt install \
    ack \
    bash \
    blueman \
    brightnessctl \
    curl \
    evolution \
    fish \
    direnv \
    thefuck \
    fonts-noto-core \
    htop \
    jq \
    grim \
    grub-customizer \
    libglib2.0-bin \
    libmpdclient2 \
    libnl-3-200 \
    libnotify4 \
    libnotify-bin \
    moreutils \
    playerctl \
    powertop \
    python3-pip \
    gir1.2-playerctl-2.0 \
    units \
    rofi \
    slurp \
    tlp \
    wl-clipboard \
    wget \
    wmctrl \
    xdotool

sudo apt install --no-install-recommends \
    gnome-tweaks \
    golang-go \
    virtualbox-qt \
    yarnpkg

sudo apt autoremove --purge \
    thunderbird

echo -e "\n${start_green} Installing third party PPAs and apps...${end_green}"
# PPAs
sudo add-apt-repository -y ppa:mozillateam/firefox-next
sudo add-apt-repository -y ppa:ubuntu-mozilla-daily/ppa
sudo add-apt-repository -y ppa:daniruiz/flat-remix
sudo add-apt-repository -y ppa:agornostal/ulauncher
sudo add-apt-repository -y ppa:solaar-unifying/stable

# Install chrome (installs both chrome stable + repository)
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

# Azote (wallpaper manager) https://github.com/nwg-piotr/azote
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/Head_on_a_Stick:/azote/xUbuntu_19.04/ /' > /etc/apt/sources.list.d/azote.list"
curl https://download.opensuse.org/repositories/home:/Head_on_a_Stick:/azote/xUbuntu_19.04/Release.key | sudo apt-key add -
touch ~/.azotebg

# Install all the rest of them things
sudo apt install \
    azote \
    google-chrome-unstable \
    flat-remix \
    firefox \
    firefox-trunk \
    solaar \
    ulauncher

# Installing chrome unstable duplicates the same chrome repo created when installing chrome stable, under a difrerent file
sudo rm -f /etc/apt/sources.list.d/google-chrome-unstable.list*

echo -e "\n${start_green} Installing snap apps...${end_green}"
sudo snap install chromium --channel latest/edge --classic
sudo snap install youtube-dl
sudo snap install spotify
sudo snap install insomnia
sudo snap install retroarch
sudo snap install kubectl --classic
sudo snap install google-cloud-sdk --classic
sudo snap install code --classic
sudo snap install phpstorm --classic
sudo snap install pycharm-professional --classic

# Try installing Slack. The snap version is a pain to use as links do not open on the current browser session
# We should be able to revert to it after https://bugs.launchpad.net/snapd/+bug/1835024/ is fixed
slack_link=$(curl -sS https://slack.com/intl/en-gb/downloads/instructions/ubuntu | grep "https://downloads.slack-edge.com/linux_releases/slack-desktop-[0-9.-]*-amd64.deb" -o)
echo -e "\n${start_green} Attempting to install slack from their website...${end_green}"
if [[ "${slack_link}" != "" ]]; then
    echo -e "\n${start_green} Found download link ${slack_link} ${end_green}"

    slack_deb=/tmp/slack.deb
    wget https://downloads.slack-edge.com/linux_releases/slack-desktop-4.10.3-amd64.deb -O "${slack_deb}"
    sudo dpkg -i ${slack_deb}
    rm ${slack_deb}

    echo -e "\n${start_green} Slack installed${end_green}"
else
    echo -e "\n${start_green} Could not find slack link on their website. Try installing by hand from https://slack.com/intl/en-gb/downloads/linux${end_green}"
fi

sudo ln -sf $(which yarnpkg) /usr/bin/yarn

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
ln -sf ${current}/scripts/button.sh                                ~/bin/
ln -sf ${current}/scripts/network-manager                          ~/bin/
ln -sf ${current}/scripts/docker                                   ~/bin/
ln -sf ${current}/scripts/screenshots.sh                           ~/bin/
ln -sf ${current}/notify-send.sh/notify-*.sh                       ~/bin/
ln -sf ${current}/ssway                                            ~/bin/

# Install login session
sudo cp ${current}/ssway /usr/bin/ssway
sudo cp ${current}/swayfire /usr/bin/swayfire
sudo cp ${current}/assets/ubuntu-wayfire.desktop /usr/share/wayland-sessions/
sudo cp ${current}/assets/ubuntu-sway.desktop /usr/share/wayland-sessions/
sudo cp ${current}/assets/ubuntu-sway-debug.desktop /usr/share/wayland-sessions/

# Enable mpd to connect to pulseaudio
mkdir -p ~/.config/pulse
cp /etc/pulse/default.pa ~/.config/pulse/
sed -i 's/^#load-module module-native-protocol-tcp$/load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1/g' ~/.config/pulse/default.pa

# For autotiling git@github.com:nwg-piotr/autotiling.git
pip3 install i3ipc
ln -sf ${current}/scripts/autotiling/autotiling.py ~/bin/
