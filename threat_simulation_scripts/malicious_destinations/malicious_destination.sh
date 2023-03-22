#!/bin/bash

while read dest
do
python3 malicious_destination.py $dest
done<easylist.txt

