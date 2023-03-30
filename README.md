# Safeguards Study

This repository contains the data and software for experimenting with Internet of Things safeguards. 
We released this with the public release of the paper "Protected or Porous: A Comparative Analysis of Threat Detection Capability of IoT Safeguards".

More details about the paper [here.](https://iotrim.github.io/safeguards.html)

As discussed in Section 4 of the paper, we use threat simulation scripts that are specific to each simulated threat to reproduce the threats that the safeguards claim to detect. The scripts we use for each detectable threat is reported in the second column of the following Table (Threat Simulation) and described as follows.

<img src="https://github.com/IoTrim/safeguards-study/blob/main/table.png" width="500"/>

## DATA
Data are stored [here.](https://liveuclac-my.sharepoint.com/:f:/g/personal/uceeam9_ucl_ac_uk/EowECdCSEkVNlg5L4NH8HWAB3ZcWpYRIY0P6lUsDdZvdzQ?e=HLSuHb)

The folder contains one subfolder for each safeguard we tested, containing their packet captures for all the duration of our experiments.  

## HOW TO RUN THE SOFTWARE

<img src="https://github.com/IoTrim/safeguards-study/blob/main/setup.jpg" width="500"/>

To run the threat scripts you will need to set up the testbed. 

More details on each testbed component are presented below.

<b>Gateway</b>

The gateway is configured using a NAT setup. It has two network interfaces, a WAN interface with a public IPv4 address outside of any firewall, and a LAN interface with private IP address, used to give NAT Internet connectivity to the safeguards.
The gateway manages the network on its LAN interface, providing DHCP support, assigning private IP addresses and forwarding DNS queries to the ISP DNS servers.
In addition to acting as gateway, the gateway is also responsible for capturing all the network traffic transiting through it using tcpdump, so that we track all the communication between the safeguard and the Internet using [Mon(IoT)r](https://github.com/IoTrim/safeguards-study/tree/main/moniotr).
The gateway can selectively block certain traffic by resolving certain DNS request to 127.0.0.1 instead of forwarding them to the ISP DNS and/or blocking certain IP addresses using simple firewall rules.
The gateway is also responsible for running certain threat scripts to simulate threats originating from the Internet.
Finally, the gateway is physically connected to an Android phone via the Android Debug Bridge, and has the possibility to control and retrieve data from the companion app of the safeguard.

<b>Safeguard</b>

We connect the Internet/WAN port of the safeguard to the LAN interface of our gateway, while the other port is connected to the IoT-LAN through the IoT bridge.
The safeguard routes the traffic between the LAN and the IoT-LAN in a NAT configuration and provides full DHCP support to the IoT devices in the IoT-LAN.
Devices in the IoT-LAN also have private IP addresses, but from a different subnet with respect to the private IP addresses in the LAN network since there is a second NAT.
The safeguards are installed using default settings.

<b>IoT Bridge</b>

This component is a Layer-2 bridge with two network interfaces, the first one connected to the IoT-LAN interface of the safeguard, and the other interface (Wi-Fi) connected to all the IoT devices under test.
The IoT bridge the network traffic being bridged between the IoT devices and the safeguard using [Mon(IoT)r](https://github.com/IoTrim/safeguards-study/tree/main/moniotr).
Each device's traffic is filtered by MAC address into separate files.
Moreover, similar to the gateway, the IoT bridge is responsible for running  threat scripts to simulate threats originating from the IoT devices.
Due to the privileged role as a Layer-2 bridge, we use the IoT bridge to perform attacks that require spoofing, for example by producing network traffic on behalf of other IoT devices in the same network by spoofing their IP addresses and MAC addresses.

<b>Android Phone</b>
We use an Android phone to understand if the safeguards are operating normally (i.e., they report an "online or "ready" status), 
and to understand if and when safeguards detect threats via their companion app using threat detection scripts.
The Android phone is connected via USB to the gateway, which offers programmatic control via ADB, thus allowing the execution of threat detection scripts.
The Android phone is connected to the LAN (i.e., the network that connects the gateway to the safeguard).

The code needs a modified version of Mon(IoT)r installed in the Gateway and the IoT bridge. Please download and install the software (moniotr) in this repository. 
[Mon(IoT)r](https://moniotrlab.ccis.neu.edu/tools/) allows traffic monitoring and customized experimentation with IoT devices.

## File Structure  

[Mon(IoT)r](https://moniotrlab.ccis.neu.edu/tools/) allows traffic monitoring and customized experimentation with IoT devices.

For each threat we create a subdirectory showing samples of:
* Threat Simulation Scripts: for running the threat 
* Threat Detection Scripts: to understand the detection capabilities of a safeguard with respect to the simulated threats. For each threat we include both the threat simulation script and the threat detection script in the appropriate folder.  

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



