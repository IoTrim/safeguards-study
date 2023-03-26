#!/bin/bash

DATE=`date "+%Y%m%d_%H%M%S"`

SAFEGUARD="$1"
TAG_DIR="$2"
name="$3"

    mkdir $TAG_DIR
    mkdir $TAG_DIR/$name
    mkdir $TAG_DIR/$name/power

    echo "Cancel past experiment power for device $name"
    [ "$TAG_DIR" != "notag" ] && /opt/moniotr/bin/tag-experiment cancel $name "power"
    echo "Starting experiment $name_exp for device $name"
	 /opt/moniotr/bin/tag-experiment cancel $name "power"
        /opt/moniotr/bin/tag-experiment start $name "power"
        ./kasa-power $name off
        sleep 5s
        ./kasa-power $name on
        sleep 30s
        echo $DATE $name $name_exp "power ok" >> $TAG_DIR/$name/power
        /opt/moniotr/bin/tag-experiment stop $name "power" $TAG_DIR
        cd $TAG_DIR/$name/power

# Pause for 20 minutes to allow the safeguard to detect the threat
sleep 20m
# Call the detection script for safeguard
./power_detection.sh $SAFEGUARD

