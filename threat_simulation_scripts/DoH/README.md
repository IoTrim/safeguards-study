# Purpose of the code
This Python code uses the Scapy library to read a pcap file (a sample pcap from Bitdefender is added in this folder) and detect any 
DoH (DNS over HTTPS) requests made in the captured network traffic. It 
extracts the destination IP address of the DoH server and prints it to the 
console.

## How to use the code

Install Scapy library using pip:

pip install scapy

Save the code in a Python file (e.g. doh_detection.py) and ensure that the pcap file to be analyzed is in the same directory as the Python file.

Replace "bitdefender.pcap" in the code with the filename of the pcap file to be analyzed.

Run the Python script:

python doh_detection.py

python doh_detection.py
