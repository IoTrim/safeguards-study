# Purpose of the code
This is a Bash script designed to automatically switch off the Amazon Echo Dot to spoof Google behavior, inject Google Home traffic, and pause for a set time to allow for detection of the threat before calling a detection script.

This code needs to be run in the <b>IoT Bridge</b>.

## How to use the code

You would need to modify the IP addresses on the anomalous_traffic_script based on the IP addresses reported in the safeguards for the IoT device you are spoofing.
To use this script, execute the following command:

``` ./anomalous_traffic_script.sh $safeguard_name ```

The script performs the following actions:

* Turns off the Amazon Echo Dot
* Injects Google Home traffic into the network using a pre-recorded .pcap file (you find the pcap in this folder)
* Pauses the script for 20 minutes to allow for detection of the threat by a safeguard
* Calls the power_detection.sh detection script with the safeguard parameter
* Turns the Amazon Echo Dot back on
