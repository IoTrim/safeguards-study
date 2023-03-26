# Purpose of the code
This code demonstrates an example of using Kali Linux to execute a flood attack using hping3 or tcpreply. The attack targets IP address 172.24.1.215 on port 80 with 15000 packets, each with a data size of 120 bytes, sent with the SYN flag (-S), window size set to 64 (-w 64), and using randomized source IP addresses (--rand-source). The --flood option enables the flood attack, which means that the packets will be sent as fast as possible, without waiting for a response.

This code needs to be run in the <b>Gateway</b> and in the <b>IoT Bridge<b>.

## Requirements
- Kali Linux (or any other Linux distribution)
- hping3 tool (can be installed with sudo apt-get install hping3 on Kali Linux)
- tcpreply

## How to use the code

``` ./flooding_script.sh $safeguard_name```

## Disclaimer
This code is provided for research and testing purposes only. The use of this code for any malicious purpose is strictly prohibited. The author of this code is not responsible for any damage or harm caused by the use of this code. Use at your own risk.
