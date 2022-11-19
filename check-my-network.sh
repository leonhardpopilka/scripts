#!/bin/bash

# This script looks at my local network and tells me things about it.


if [[ $OSTYPE =~ ^linux ]]; then
    echo "Hello from linux."
    echo "INSTALLING STUFF..."
    echo "Do you want to update stuff? (y/n)"
    read update
    if [[ $update == 'y' ]]; then
        sudo apt update
        sudo apt upgrade
        sudo apt-get update
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
    echo "Hello WINDOWS or MAC"
    echo "This doesn't work here :("
    exit
fi

# check my ip adresses
echo "NETWORK:"
ipadress=$(ifconfig | grep broadcast | awk '{print $2}')
echo "Machine IP: $ipadress"
read A B C D <<<"${ipadress//./ }"
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
