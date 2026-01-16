#!/bin/bash

# ------------------
# Tool name : user-audit.sh
# Purpouse : Display user and privilage information
# Author : Srivatsa
# ------------------

echo "====== USER & PRIVILGE INFORMATION ======"
echo

echo "Current User:"
whoami
echo

echo "All Local User Accounts:"
net user
echo

echo "Currently Logged-In Sessions:"
who
echo

echo "Administrator Group Members:"
net localgroup administrators
echo

echo "================================="

