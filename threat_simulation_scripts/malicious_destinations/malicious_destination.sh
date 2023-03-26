#!/bin/bash
SAFEGUARD="$1"

while read dest
do
python3 malicious_destination.py $dest
done<easylist.txt

# Pause for 20 minutes to allow the safeguard to detect the threat
sleep 20m
# Call the detection script for safeguard
./weak_password_detection.sh $SAFEGUARD

