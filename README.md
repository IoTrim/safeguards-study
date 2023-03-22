# Safeguards Study

This repository contains the data and software for experimenting with Internet of Things safeguards. 
We released this with the public release of the paper "Protected or Porous: A Comparative Analysis of Threat Detection Capability of IoT Safeguards".

As discussed in Section 4 of the paper, we use threat simulation scripts that are specific to each simulated threat to reproduce the threats that the safeguards claim to detect. The scripts we use for each detectable threat is reported in the second column of the following Table (Threat Simulation) and described as follows.

<img src="https://github.com/IoTrim/safeguards-study/blob/main/table.png" width="500"/>

Data are stored here: https://liveuclac-my.sharepoint.com/:f:/g/personal/uceeam9_ucl_ac_uk/El87b_6c8pVNkiAoapE1y2EBU2Arvgse5tB1HYNTVkHqzw?e=hqr3l7 
The folder contains one subfolder for each safeguard we tested containing their packet captures for all the duration of our experiments.  

HOW TO RUN THE SOFTWARE
## File Structure 

The code needs a modified version of Mon(IoT)r installed. Please download and install the software (moniotr) in this repository. 
Mon(IoT)r allows traffic monitoring and customized experiments with IoT devices. 

For each threat we create a subdirectory showing samples of:
* Threat Simulation Scripts: for running the threat 
* Threat Detection Scripts: to understand the detection capabilities of a safeguard with respect to the simulated threats
For each threat we include both the Threat Simulation Script and the Threat Detection script in the appropriate folder.  

`anomalous_on_off` - Code for emulating the situation in which a compromised device is switched on and off continuously.

`anomalous_traffic` - Code for producing synthetic traffic that does not conform to the typical traffic of an IoT device. In the example we emulate an Google Home traffic as being produced by an Echo Spot. First, we collect normal traffic produced by an Echo Spot while interacting with the device normally, including asking different questions. From the IoT bridge we then spoof source IP address, MAC address, and inject the Echo Spot traffic to the safeguard as if the Echo Spot is sending traffic as Google Home.

`anomalous_upload` - Code for emulating IoT devices generating anomalous peaks of outgoing traffic.

`open_port` - Code for emulating an IoT device with open port.

`weak_password` - Code for emulating the usage of weak passwords. The code use a list of 200 weak password sent using FTP. 

`flooding` - Code for generating DoS attacks. We run a Kali Linux virtual machine
running for generating the DoS pcaps. We then spoof source IP address, MAC address, and inject the traffic produced by Kali attacks to the safeguard to make it appear as if the IoT device is infected and is sending DoS traffic in addition to its normal traffic.

`port_scanning` - Code for generating port scan attacks using nmap. We test port [0-65535].

`os_scanning` - Code for generating os scan attacks using nmap.

`malicious_destinations` - Code for emulating an IoT device connecting to malicious destinations (83,021 malicious destinations).

`pii_exposure` - Code for generating plaintext traffic that includes PII (name, age, email, password, info, ip, credit card, passport, DoB, bank account).

`DoH` - Code for detecting DNS requests are DoH compliant.



