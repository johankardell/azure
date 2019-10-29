#/bin/bash

sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y

sudo apt install inetutils-traceroute -y
sudo apt install tcptraceroute -y
sudo apt install tcpdump -y