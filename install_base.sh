#!/bin/bash

# Install the absolute basics on a DE-less ubuntu system
sudo apt install \
    software-properties-common \
    docker.io \
    fish

sudo service docker restart

sudo usermod -a -G docker $(whoami)
chsh $(whoami) -s /usr/bin/fish
