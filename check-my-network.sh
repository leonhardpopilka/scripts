#!/bin/bash

# This script looks at my local network and tells me things about it.

if [[ $OSTYPE =~ ^linux ]]; then
    echo "Hello from linux."
    echo "INSTALLING STUFF..."
    echo "Do you want to update stuff? (y/n)"
    read update
    if [[ $update == 'y' ]]; then
        sudo apt-get update
        sudo apt update
        sudo apt upgrade
        sudo apt autoremove
        sudo apt install net-tools
        sudo apt-get install nmap -y
        echo "INSTALLATION DONE."
        echo "Press ENTER to continue ..."
        read pause
        clear
    fi
else
# [[ $OSTYPE =~ ^msys ]]; then
    echo "Hello, you are on WINDOWS or MAC"
    echo "This script doesn't work here :("
    exit
fi

# check my ip adresses
echo "NETWORK:"
# get maschine ip adress and dissect it in triplets.
ipadress=$(ifconfig | grep broadcast | awk '{print $2}')
echo "Machine IP: $ipadress"
read A B C D <<<"${ipadress//./ }"
echo ""
# quick check if machine is online. command below recieves 0 or 1 where 1 = online.
online=$(ping -q -c 1 8.8.8.8 | grep transmitted | awk '{print $1}')
if [[ $online == 1 ]]
	then echo "We are online!"
else
	echo "No internet connection."
fi
echo ""
echo "running arp -a ..."
arp -a
echo ""
echo "running nmap -sP $A.$B.$C.0/24..."
nmap -sP $A.$B.$C.0/24
echo ""
echo "running ifconfig..."
ifconfig

exit
