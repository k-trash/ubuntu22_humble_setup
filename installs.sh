#!/bin/sh

#remove games
sudo apt remove -y gnome-sudoku gnome-mines gnome-mahjongg aisleriot

#update & uprade
sudo apt -y update
sudo apt -y upgrade

#remove firefox
sudo apt remove -y firefox*
sudo snap remove -y firefox*
sudo apt autoremove -y

#install firefox-esr
sudo add-apt-repository -y ppa:mozillateam/ppa
sudo apt install -y firefox-esr

#install gufw
sudo apt install -y gufw
sudo ufw enable

#install chrome
mkdir -p $HOME/Download/install_file
wget -P $HOME/Download/install_file https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y $HOME/Download/install_file/google-chrome-stable_current_amd64.deb

#install utilities
sudo apt install -y vim gnome-tweaks curl apt-transport-https
sudo apt install -y git build-essential cmake python3-venv

#install vscode
wget -P $HOME/Download/install_file -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 $HOME/Download/install_file/packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg
sudo apt update
sudo apt install code
echo {\r\n\t"keyboard.dispatch": "keyCode"\r\n} > $HOME/.config/Code/User/setting.json

#install mozc
sudo apt install -y ibus-mozc mozc-util-gui

#install ROS
sudo add-apt-repository -y universe
sudo apt -y update
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
sudo apt -y update
sudo apt install -y ros-humble-desktop
sudo apt install -y ros-dev-tools
echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
