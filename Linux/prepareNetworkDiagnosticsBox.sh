#/bin/bash

sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y
sudo apt install inetutils-traceroute -y
sudo apt install tcptraceroute -y
sudo apt install tcpdump -y
sudo apt install hping3 -y
sudo apt install nmap -y

