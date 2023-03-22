#Detect if in the safeguards pcap there are DoH requests

from scapy.all import *

# Define a function to detect DoH traffic
def detect_doh(pcap):
    # Create a set to store unique DoH server IP addresses
    doh_servers = set()

    # Iterate through each packet in the PCAP
    for packet in pcap:
        # Check if the packet is a DNS over HTTPS request
        if packet.haslayer(TCP) and packet.haslayer(Raw):
            # Extract the destination IP address and payload from the packet
            dst_ip = packet[IP].dst
            payload = str(packet[TCP].payload)

            # Check if the payload contains a DoH request
            if "GET /dns-query?" in payload:
                # Add the DoH server IP address to the set
                doh_servers.add(dst_ip)

    # Print the detected DoH server IP addresses
    print("Detected DoH servers:")
    for ip in doh_servers:
        print(ip)

# Open the PCAP file
pcap_file = "bitdefender.pcap"
pcap = rdpcap(pcap_file)

# Call the detect_doh function
detect_doh(pcap)
