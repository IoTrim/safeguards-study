# Purpose of the code
This is a Bash script designed to automatically inject camera traffic (peak traffic), and pause for a set time to allow for detection of the threat from the safeguard.

This code needs to be run in the <b>IoT Bridge<b>.

## How to use the code

You would need to modify the IP addresses on the anomalous_upload_script based on the IP addresses reported in the safeguards for the IoT device you are spoofing and modify the interface based on the name of the interface connected to the safeguard.
To use this script, execute the following command:

``` ./anomalous_upload_script.sh $safeguard_name ```



