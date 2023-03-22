#!/bin/bash

# Set FTP server address and login credentials
ftp_server=$1
ftp_user="admin"

# Connect to FTP server and login
while read ftp_pass
do
ftp -n $ftp_server <<EOF
user $ftp_user $ftp_pass
done<list_password

