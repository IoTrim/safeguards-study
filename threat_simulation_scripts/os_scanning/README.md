# Purpose of the code
This code demonstrates two methods of os scanning on a target IP address. 

This code needs to be run in the <b>Gateway</b> and in the <b>IoT Bridge<b>.

## Requirements
- Nmap tool (can be installed with sudo apt-get install nmap on Linux systems)

## How to use the code

``` ./os_scanning_script.sh $target_ip $safeguard_name```

* The target IP is any IP of the IoT device in the wlan the safeguard are connected.
* Wait for the Nmap scan to complete.
* Analyze the output to determine whether the threat has been detected by the safeguard.

## Disclaimer
This code is provided for research and testing purposes only. The use of this code for any malicious purpose is strictly prohibited. The author of this code is not responsible for any damage or harm caused by the use of this code. Use at your own risk.
