#!/bin/bash

# This script looks at my local network and tells me things about it.

if [[ $OSTYPE =~ ^linux ]]; then
    # echo "Do you want to update stuff first? (y/n)"
    # read update
    if [[ $1 == '-u' ]]; then
        echo "INSTALLING STUFF..."
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
ipadress=$(ifconfig | grep 'inet 192' | awk '{print $2}')
echo "IP: $ipadress"
read A B C D <<<"${ipadress//./ }"
echo ""
# quick check if machine is online. command below recieves 0 or 1 where 1 = online.
online=$(ping -q -c 1 -w 2 8.8.8.8 | grep transmitted | awk '{print $4}')
if [[ $online == 1 ]]
	then echo "We are online!"
else
	echo "No internet connection."
fi
# echo ""
# echo "ifconfig:"
# ifconfig

echo ""
echo "OTHER CLIENTS:"
echo "__________"
clients=$(arp -a | grep ether| awk '{printf  $1" - "$2" - "$4 "\n"}')
echo "$clients"

echo ""
echo "Nmap for $A.$B.$C.0/24:"
echo "__________"
bc=$(nmap -sP 192.168.178.0/24| grep report| awk '{print $5 $6}')
echo "$bc"

exit
