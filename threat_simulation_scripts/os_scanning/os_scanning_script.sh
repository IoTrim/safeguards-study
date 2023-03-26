#!/bin/bash
#using nmap for os scanning
SAFEGUARD=$2


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


# Pause for 20 minutes to allow the safeguard to detect the threat
sleep 20m
# Call the detection script for safeguard
./os_scanning_detection.sh $SAFEGUARD
