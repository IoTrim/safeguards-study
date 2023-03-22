#!/bin/bash
#using nc for the open port test
IP_ADDR=$1
for port in {0..65535};
do nc -zv $IP_ADDR $port;
done


#using nmap for the open port test
# Check if Nmap is installed
if ! command -v nmap &> /dev/null
then
    echo "Nmap is not installed. Please install Nmap first."
    exit
fi

# Read target IP address from user input
read -p "Enter target IP address: " ip_address

# Run Nmap scan on target IP address
nmap -p 1-65535 -T4 -A -v $ip_address
