#!/bin/sh

#remove games
apt remove -y gnome-ku gnome-mines gnome-mahjongg aisleriot

#update & uprade
apt -y update
apt -y upgrade

#remove firefox
apt remove -y firefox* thunderbird
snap remove firefox

#install gufw
apt install -y gufw
ufw enable

#install chrome
#mkdir -p $HOME/Downloads/install_file
#wget -P $HOME/Downloads/install_file https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
#apt install -y $HOME/Downloads/install_file/google-chrome-stable_current_amd64.deb
#rm -f $HOME/Downloads/install_file/google-chrome-stable_current_amd64.deb

#install utilities
apt install -y gnome-tweaks
apt install -y curl apt-transport-https ca-certificates gnupg ssh
apt install -y git build-essential cmake vim

#install docker
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

#install vscode
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > $HOME/Downloads/install_file/microsoft.gpg
install -D -o root -g root -m 644 $HOME/Downloads/install_file/microsoft.gpg /etc/apt/keyrings/microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f $HOME/Downloads/install_file/microsoft.gpg
sudo apt update
sudo apt install code
#echo -e '{\n\t"keyboard.dispatch": "keyCode"\n}' > $HOME/.config/Code/User/settings.json

#install nvidia driver
nvidia-smi
if [ $? -gt 0 ]; then
	read -p 'Remove all exist nvidia-driver and cuda-toolkit. (y/N): ' yn
	case "$yn" in
		[yY]*) 
			apt remove --purge nvidia-* cuda-*
			apt install -y ubuntu-drivers-common
			driver=$(ubuntu-drivers devices | grep recommended | awk '{print $3}')
			apt install -y --no-install-recommends ${driver}
			echo 'please reboot and continue installing cuda-toolkit by running setup_after.bash';;
		*)
			echo 'abort installing nvidia-drivers';;
	esac
fi
