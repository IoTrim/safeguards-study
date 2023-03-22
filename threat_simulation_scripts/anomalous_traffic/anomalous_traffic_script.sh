#automatically switching off the echodot
kasa power ...

#injecting google home traffic
tcpreplay-edit --srcipmap=192.168.20.205:192.168.20.206 --dstipmap=192.168.20.205:192.168.20.206 --enet-smac=5c:41:5a:29:ad:97 --enet-dmac=e8:44:7e:5:c7:29  --loop=10 -i wlan0 google.pcap
