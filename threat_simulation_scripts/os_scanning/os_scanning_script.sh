#!/bin/bash
#using nmap for os scanning


#using nmap for the open port test
# Check if Nmap is installed
if ! command -v nmap &> /dev/null
then
    echo "Nmap is not installed. Please install Nmap first."
    exit
fi

# Read target IP address from user input
ip_address=$1

# Run Nmap scan on target IP address
nmap -O $ip_address
