#!/bin/bash

# Services
sudo pip3 install undervolt
sudo cp assets/nvidia-power.service /etc/systemd/system/
sudo cp assets/undervolt.service /etc/systemd/system/
sudo cp assets/undervolt.timer /etc/systemd/system/
sudo systemctl enable undervolt
sudo systemctl enable nvidia-power

# Disable dell TB16 dock audio autosuspend in tlp
sudo sed -i 's/#USB_BLACKLIST="1111:2222 3333:4444"/USB_BLACKLIST="0bda:4014"/g' /etc/default/tlp

# Installing crontabs
cat ${current}/assets/crontab-root | sudo crontab -
cat ${current}/assets/crontab-luis | crontab -
