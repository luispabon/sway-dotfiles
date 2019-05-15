FROM ubuntu:disco

RUN apt-get update && \
    apt-get install -y build-essential meson ninja-build git pkg-config libinput10 libinput-dev wayland-protocols libwayland-client0 libwayland-cursor0 libwayland-dev libegl1-mesa-dev libgles2-mesa-dev libgbm-dev libxkbcommon-dev libudev-dev libpixman-1-dev libgtkmm-3.0-dev libjsoncpp-dev && \
    apt-get clean

RUN apt install -y libwlroots-dev \
    checkinstall \
    libpulse-dev \
    libmpdclient-dev \
    libdbusmenu-gtk3-dev \
    libnl-genl-3-dev \
    libmpdclient-dev \
    clang-tidy

RUN apt install -y \
    wayland-protocols \
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
    devscripts
