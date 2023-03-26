# Purpose of the code
This code demonstrates two methods of testing open ports on a target IP address. The first method uses the nc tool, which tests all ports from 0 to 65535 using a for loop. The second method uses the Nmap tool, which is a more comprehensive port scanner that provides additional information about the target system.

This code needs to be run in the <b>Gateway</b> and in the <b>IoT Bridge<b>.

## Requirements
- nc tool (usually pre-installed on Linux systems)
- Nmap tool (can be installed with sudo apt-get install nmap on Linux systems)

## How to use the code

``` ./port_scanning_script.sh $target_ip $safeguard_name```

* The target IP is any IP of the IoT device in the wlan the safeguard are connected
* Wait for the Nmap scan to complete
* Analyze the output to determine whether the threat has been detected by the safeguard.

## Disclaimer
This code is provided for research and testing purposes only. The use of this code for any malicious purpose is strictly prohibited. The author of this code is not responsible for any damage or harm caused by the use of this code. Use at your own risk.
