#!/bin/bash

#install cuda
wget -P $HOME/Download/install_files https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i $HOME/Download/install_files/cuda-keyring_1.1-1_all.deb
sudo apt-get update

cudav=$(nvidia-smi | grep CUDA | awk {'print $9'})
sudo apt install cuda-${cudav/./-}

echo 'export PATH="/usr/local/cuda/bin:$PATH"' >> $HOME/.bashrc
echo 'export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"' >> $HOME/.bashrc

