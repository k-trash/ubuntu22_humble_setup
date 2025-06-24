#!/bin/sh

wget -P $HOME/Download/install_files https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i $HOME/Download/install_files/cuda-keyring_1.1-1_all.deb
sudo apt-get update

cudav=$(nvidia-smi | grep CUDA | awk {'print $4'})
sudo apt install cuda-$($4 | sed s/./-/)
