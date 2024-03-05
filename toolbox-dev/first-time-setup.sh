#!/bin/sh

sudo mkdir /opt/.cargo
sudo mkdir /opt/.cargo/bin
sudo mkdir /opt/.rustup

sudo chown -R $USER:$USER /opt/.cargo
sudo chown -R $USER:$USER /opt/.rustup

sudo dnf install python3 python3-pip python3-devel
sudo dnf install libtool gcc-c++ libXi-devel freetype-devel libunwind-devel mesa-libGL-devel mesa-libEGL-devel glib2-devel libX11-devel libXrandr-devel gperf fontconfig-devel cabextract ttmkfdir expat-devel rpm-build cmake libXcursor-devel libXmu-devel dbus-devel ncurses-devel harfbuzz-devel ccache clang clang-libs llvm python3-devel gstreamer1-devel gstreamer1-plugins-base-devel gstreamer1-plugins-bad-free-devel libjpeg-turbo-devel zlib libjpeg vulkan-loader openssl-devel

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# consider??
# sudo dnf install rustup

rustup default nightly
rustup target add wasm32-unknown-unknown

# should install full + npm
sudo dnf install nodejs