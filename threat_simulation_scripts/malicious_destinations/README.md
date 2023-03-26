# Purpose of the code
This script uses the sys module and the http.client module to make an HTTP GET request to a specified malicious destination (in easylist.txt). The destination is passed to the script as a command-line argument when the script is executed. The script prints the destination, status code, and reason phrase to the console using the print statement.

This code needs to be run in the <b>IoT Bridge<b>.


## How to use the code

To use this script, you need to have Python installed on the IoT Bridge. You can execute the script by running the following command in your terminal:

``` ./malicious_destination.sh $safeguard_name```

* Analyze the output to determine whether the threat has been detected by the safeguard.

## Disclaimer
This code is provided for research and testing purposes only. The use of this code for any malicious purpose is strictly prohibited. The author of this code is not responsible for any damage or harm caused by the use of this code. Use at your own risk.
