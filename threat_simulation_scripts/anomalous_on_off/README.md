# Purpose of the code
This Bash script is designed to run a power experiment on an IoT device and store the pcap of the experiment in a specific directory. It also stores the result of the detection from the safeguard.
This code needs to be run in the <b>IoT Bridge</b>.

## How to use the code

This script requires the following:

kasa-power script in the same directory and kasa-power.txt with details about the MAC address of the smart plug where the IoT device is plugged.
monitor installed.
power_detection.sh detection script.

The script requires three arguments:

$1: safeguard name
$2: tag directory path
$3: IoT device name
To use this script, run the following command:

``` power_script.sh $safeguard_name $directory $name_iot_device ```

The script performs the following actions:

* Create a tag directory if it does not already exist
* Create a directory for the device within the tag directory
* Cancel any past power experiments 
* Start a new power experiment for the device
* Turn the device off and on, with pauses in between using a smart plug
* Log the experiment results to a file in the power directory
* Stop the power experiment and stores the results in the tag directory
* Run the detection script with the safeguard parameter
