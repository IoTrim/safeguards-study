# Safeguards Study

This repository contains the data and software for experimenting with Internet of Things safeguards. 
We released this with the public release of the paper "Protected or Porous: A Comparative Analysis of Threat Detection Capability of IoT Safeguards".

As discussed in Section 4 of the paper, we use threat simulation scripts that are specific to each simulated threat to reproduce the threats that the safeguards claim to detect. The scripts we use for each detectable threat is reported in the second column of the following Table (Threat Simulation) and described as follows.

<img src="https://github.com/IoTrim/safeguards-study/blob/main/table.png" width="500"/>

HOW TO RUN THE SOFTWARE
## File Structure 

The code needs Mon(IoT)r installed. Please download and install the software here: https://moniotrlab.ccis.neu.edu/tools/ [TODO: Download and add the code of moniotr here]

For each threat we create a subdirectory showing samples of:
* Threat Simulation Scripts: for running the threat 
* Threat Detection Scripts: to understand the detection capabilities of a safeguard with respect to the simulated threats
For each threat we include both the Threat Simulation Script and the Threat Detection script in the appropriate folder.  

`anomalous_on_off` - Code for emulating the situation in which a compromised device is switched on and off continuously.

`anomalous_traffic` - Code for producing synthetic traffic that does not conform to the typical traffic of an IoT device. In the example we emulate an Google Home traffic as being produced by an Echo Spot. First, we collect normal traffic produced by an Echo Spot while interacting with the device normally, including asking different questions. From the IoT bridge we then spoof source IP address, MAC address, and inject the Echo Spot traffic to the safeguard as if the Echo Spot is sending traffic as Google Home.
