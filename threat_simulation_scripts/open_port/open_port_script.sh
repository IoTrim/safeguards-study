#!/bin/bash

#to be run at the IoT Bridge
IP_ADDR=$1
for port in {0..65535};
do sudo ufw allow $port;

done

