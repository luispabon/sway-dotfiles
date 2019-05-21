# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/disco64"

  config.vm.box_check_update = false
  config.vm.synced_folder "/home/luis/.gnupg", "/vagrant/.gnupg"
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "2048"
  end
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update && \
      apt-get install -y \
        build-essential \
        meson \
        ninja-build \
        git \
        pkg-config \
        libinput10 \
        libinput-dev \
        wayland-protocols \
        libwayland-client0 \
        libwayland-cursor0 \
        libwayland-dev \
        libegl1-mesa-dev \
        libgles2-mesa-dev \
        libgbm-dev \
        libxkbcommon-dev \
        libudev-dev \
        libpixman-1-dev \
        libgtkmm-3.0-dev \
        libjsoncpp-dev \
        checkinstall \
        libpulse-dev \
        libmpdclient-dev \
        libdbusmenu-gtk3-dev \
        libnl-genl-3-dev \
        libmpdclient-dev \
        clang-tidy\
        libjson-c-dev \
        debhelper \
        dh-make \
        cmake \
        freerdp2-dev \
        libwinpr2-dev \
        libxcb-xinput-dev \
        libavutil-dev \
        libxcb1-dev \
        libavcodec-dev \
        libavformat-dev \
        libxcb-icccm4-dev \
        devscripts \
        fish \
        libsystemd-dev \
        libxcb-composite0-dev \
        libcap-dev

      chsh vagrant -s /usr/bin/fish
  SHELL
end
