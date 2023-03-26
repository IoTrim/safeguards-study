#!/bin/bash
SAFEGUARD="$1"

#to be run at the IoT Bridge
IP_ADDR=$1
for port in {0..65535};
do sudo ufw allow $port;

done

# !IMPORTANT! Manually activate a threat scanner in the safeguard app

# Pause for 20 minutes to allow the safeguard to detect the threat
sleep 20m
# Call the detection script for safeguard
./weak_password_detection.sh $SAFEGUARD
