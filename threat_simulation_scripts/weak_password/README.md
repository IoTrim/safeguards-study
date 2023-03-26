# Purpose of the code
The script takes the FTP server address as a command-line argument and uses a predefined FTP user "admin" for the login attempt. The script reads a list of passwords from a file named "list_password"

This code needs to be run in the <b>IoT Bridge<b>.

## Requirements
- FTP client (usually pre-installed on Linux systems)

## How to use the code

``` ./weak_password_script.sh $ftp_server $safeguard_name```

* Analyze the output to determine whether the threat has been detected by the safeguard.

## Disclaimer
This code is provided for research and testing purposes only. The use of this code for any malicious purpose is strictly prohibited. The author of this code is not responsible for any damage or harm caused by the use of this code. Use at your own risk.
