#!/bin/bash
SAFEGUARD="$2"

# Set FTP server address and login credentials
ftp_server=$1
ftp_user="admin"

# Connect to FTP server and login
while read ftp_pass
do
ftp -n $ftp_server <<EOF
user $ftp_user $ftp_pass
done<list_password


# Pause for 20 minutes to allow the safeguard to detect the threat
sleep 20m
# Call the detection script for safeguard
./weak_password_detection.sh $SAFEGUARD
