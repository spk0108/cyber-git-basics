#!/bin/bash

#--------------------
# Tool Name : network-info.sh
# Purpose : Display basic system and network information
# Author : Srivatsa
#--------------------

echo "======= SYSTEM & NETWORK INFORMATION ======="
echo "Date & Time:"
date
echo

echo "Hostname:"
hostname
echo

echo "Current User:"
whoami
echo

echo "Operating System:"
uname -a
echo
echo "Network Interface:"
ipconfig
echo

echo "IP Configuration:"
route print
echo

echo "============================="
