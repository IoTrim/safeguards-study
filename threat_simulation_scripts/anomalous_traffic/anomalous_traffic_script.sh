#automatically switching off the echodot
kasa power ...

#injecting google home traffic
tcpreplay-edit --srcipmap=10.0.0.2:172.24.1.215 --dstipmap=10.128.0.2:213.209.17.209 --enet-smac=54:8d:5a:d0:b6:96 --enet-dmac=e8:44:7e:5:c7:29  --loop=10 -i wlan0 google.pcap
