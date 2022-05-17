#!/bin/bash

set -euxo pipefail

# Run with sudo check
if (( EUID != 0 )); then
   echo "Run this script as sudo. Exiting." 1>&2
   exit 100
fi

USR="$(logname)"
HOME_PATH="/home/$(logname)"
DOWNLOADS="$HOME_PATH/Downloads"

# A few commonly used programs on a new computer.

# Download and install VS Code
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

apt update

apt install -y code

# C++, version-control and build systems
apt install -y git build-essential cmake cppcheck clang-format clang-tidy clangd

# General programs that make life easier
apt install -y xpad terminator htop virtualbox tmux gnome-sushi

su - "$USR" -c "code --install-extension ms-azuretools.vscode-docker"
su - "$USR" -c "code --install-extension ms-iot.vscode-ros"
su - "$USR" -c "code --install-extension ms-python.python"
su - "$USR" -c "code --install-extension ms-python.vscode-pylance"
su - "$USR" -c "code --install-extension ms-toolsai.jupyter"
su - "$USR" -c "code --install-extension ms-toolsai.jupyter-keymap"
su - "$USR" -c "code --install-extension ms-toolsai.jupyter-renderers"
su - "$USR" -c "code --install-extension ms-vscode-remote.remote-containers"
su - "$USR" -c "code --install-extension ms-vscode.cmake-tools"
su - "$USR" -c "code --install-extension llvm-vs-code-extensions.vscode-clangd"
su - "$USR" -c "code --install-extension cheshirekow.cmake-format"
su - "$USR" -c "code --install-extension ms-vscode.cpptools"
su - "$USR" -c "code --install-extension tomoki1207.pdf"
su - "$USR" -c "code --install-extension twxs.cmake"