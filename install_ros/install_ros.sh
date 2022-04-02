#!/bin/bash

set -euxo pipefail

# Run with sudo check
if (( EUID != 0 )); then
   echo "Run this script as super user. Exiting." 1>&2
   exit 100
fi

# Set variables
HOME_PATH="/home/$(logname)"
DOWNLOADS="$HOME_PATH/Downloads"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
FILENAME=`basename "$0"`

# Set colors for stdout
RED='\033[0;31m'
NC='\033[0m'

sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

apt install -y curl

curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

apt update

apt install -y ros-noetic-desktop-full

echo "
source /opt/ros/noetic/setup.bash" >> $HOME_PATH/.bashrc

apt install -y python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential

echo -e "\n"
echo -e "Hi ${RED}$(logname)${NC}.\n"
echo -e "Please open a new shell and run ${RED}'sudo rosdep init'${NC} and then run ${RED}'rosdep update'${NC}\n"
echo "Your bashrc has been updated for you to source ROS"