#!/bin/bash

# This script looks at my local network and tells me things about it.

# install "Nmap" 
echo "INSTALLING STUFF..."
sudo apt install net-tools
# $(sudo apt-get install nmap -y)
echo "INSTALLATION DONE."
echo "---"

# check my ip adresses
echo "NETWORK:"
arp -a

exit