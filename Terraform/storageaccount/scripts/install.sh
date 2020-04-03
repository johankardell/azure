#! /bin/bash
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get autoremove -y


wget https://aka.ms/downloadazcopy-v10-linux
tar -xvf downloadazcopy-v10-linux
sudo rm /usr/bin/azcopy
sudo cp ./azcopy_linux_amd64_*/azcopy /usr/bin/

sudo chmod a+x /usr/bin/azcopy
