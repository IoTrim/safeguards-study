# Purpose of the code
This script is intended to be run on the IoT Bridge device to allow all ports from 0 to 65535 using the ufw firewall utility. It then pauses for 20 minutes using the sleep command to allow the safeguard to detect any potential threats. Finally, it calls the weak_password_detection.sh script passing in the $SAFEGUARD variable as an argument.

This code needs to be run in the <b>IoT Bridge</b>.

## How to use the code

To use this script, simply provide the IP address of the IoT Bridge as a command-line argument when executing the script. For example, if the script is saved on the IoT Bridge, you can execute the script by running:

``` ./malicious_destination.sh $safeguard_name```

* Analyze the output to determine whether the threat has been detected by the safeguard.

## Disclaimer
This code is provided for research and testing purposes only. The use of this code for any malicious purpose is strictly prohibited. The author of this code is not responsible for any damage or harm caused by the use of this code. Use at your own risk.
