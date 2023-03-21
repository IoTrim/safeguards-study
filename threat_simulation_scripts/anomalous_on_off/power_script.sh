#!/bin/bash
#To retry the list of installed apps: adb shell "pm list packages -3"|cut -f 2 -d ":"
#To check the coordinate to tap: settings/Developer options/Pointer location

DATE=`date "+%Y%m%d_%H%M%S"`

#./auto_app2multi_list_dest.sh $phone $file_dev $dir_data

# The first parameter $1 should be the phone name, and a file "ids/phone_name" must exist
# If running the script witho only the first  parameter, dev_auto is used, and all experiments executed and tagged
# If running the script with additional parameters: $2 is the experiment file (default: 'dev_auto')
# $3 is the tag dir. If it is 'default' the experiment is tagged in the default directory, if 'notag' the experiment is not tagged 
(default: 'default') 
# $4 is the device to experiment with (if the option is not provided, all devices will be tested)
# $5 is the experiment to be started (if the option is not provided, all experiments for the chosen device will be started)
CAPT_DIR="$1"
PHONE="$2"
DEV_AUTO="$3"
TAG_DIR="$4"
DO_DEVICE="$5"
DO_EXPERIMENT="$6"
SAFEGUARD="$8"

function waitphone {
    while [ -z "$PHONE_FOUND" ]; do
        echo "Phone not found, waiting for $PHONE/$ANDROID_SERIAL"
        sleep 5
       PHONE_FOUND=`adb devices | grep $ANDROID_SERIAL`
    done
}

if [ ! -f "ids/$PHONE" ]; then
    echo Devices ids/$PHONE does not exist. Aborting.
    exit
else
    export ANDROID_SERIAL=`cat ids/$PHONE`
    echo Phone is: $PHONE/$ANDROID_SERIAL
    PHONE_FOUND=`adb devices | grep $ANDROID_SERIAL | grep device`
    waitphone
    echo Phone ready, proceeding...
fi

[ -z "$DEV_AUTO" ] && DEV_AUTO="dev_auto"
[ -z "$TAG_DIR" ] && TAG_DIR="default"

while IFS=";" read name name_exp crop phone_exp package sleep1 sleep2 function_1 function_2 function_3 function_4 function_5 function_6 
function_7 function_8 function_9
do
    mkdir $TAG_DIR
    mkdir $TAG_DIR/$name
    mkdir $TAG_DIR/$name/power
    mkdir $TAG_DIR/$name/$name_exp
    # Ignore commented lines starting with # (spaces before # are allowed)
    [[ $name  =~ ^[[:space:]]*# ]] && continue
    # Ignore empty lines and lines with only spaces
    [[ $name  =~ ^[[:space:]]*$ ]] && continue
    # Run only experiments matching the given device (if provided)
    [[ -n "$DO_DEVICE" ]] && [[ "$DO_DEVICE" != "$name" ]] && continue
    # Run only experiments matching the given experiment name (if provided)
    [[ -n "$DO_EXPERIMENT" ]] && [[ "$DO_EXPERIMENT" != "$name_exp" ]] && continue

	/opt/moniotr/bin/dns-override wipe $name
	/opt/moniotr/bin/ip-block wipe $name
    cd $CAPT_DIR/..
    # Ignore commented lines starting with # (spaces before # are allowed)
    [[ $name  =~ ^[[:space:]]*# ]] && continue
    # Ignore empty lines and lines with only spaces
    [[ $name  =~ ^[[:space:]]*$ ]] && continue
    # Run only experiments matching the given device (if provided)
    [[ -n "$DO_DEVICE" ]] && [[ "$DO_DEVICE" != "$name" ]] && continue
    # Run only experiments matching the given experiment name (if provided)
    [[ -n "$DO_EXPERIMENT" ]] && [[ "$DO_EXPERIMENT" != "$name_exp" ]] && continue

    echo "Cancel past experiment $name_exp for device $name"
    [ "$TAG_DIR" != "notag" ] && /opt/moniotr/bin/tag-experiment cancel $name $name_exp
    echo "Starting experiment $name_exp for device $name"
    echo $DO_DEVICE $name $DO_EXPERIMENT $name_exp $PHONE
    if [[ "$TAG_DIR" != "notag" ]] && [[ $phone_exp != "x" ]]; then
	 /opt/moniotr/bin/tag-experiment cancel $name "power"
        /opt/moniotr/bin/tag-experiment start-with-companion $name $PHONE "power"
        ./kasa-power $name off
        sleep 5s
        ./kasa-power $name on
        sleep 30s
        echo $DATE $name $name_exp "power ok" >> $TAG_DIR/$name/exp_okA
        /opt/moniotr/bin/tag-experiment stop $name "power" $TAG_DIR
        cd $TAG_DIR/$name/power
        echo $TAG_DIR/$name/power
        LAST_CAPT=$(ls -t | grep -v companion |  grep -v http | head -n 1)
        echo $LAST_CAPT
        #tshark -r $LAST_CAPT  -q -z hosts | awk 'NF && $1!~/^#/' | awk '{print $2}' | grep -v "ntp" | grep -v "time" | grep -v "dns" | 
sort | uniq > $TAG_DIR/$name/$name_exp/list_dest_pow
        tshark -r $LAST_CAPT -Y "dns.flags.response == 1" -T fields -E separator=\; -e dns.qry.name -e dns.a -E header=n -E quote=n | 
sort | uniq | awk -F ";" {'if($1) print $1'} | awk -F "," {'print $1 "\n" $2 "\n" $3 "\n" $4 "\n" $5 "\n" $6 "\n" $7'} | grep -v "ntp" | 
grep -v "time" | grep -v "dns" | sort | uniq >$TAG_DIR/$name/$name_exp/list_dest_pow
	#tshark -r $LAST_CAPT -T fields -e dns.qry.name -e dns.resp.name -E separator=\;  -E header=n -E quote=n | sort | uniq | awk -F 
";" {'if($2) print $2'} | awk -F "," {'print $1 "\n" $2 "\n" $3 "\n" $4 "\n" $5 "\n" $6 "\n" $7'} | grep -v "ntp" | grep -v "time" | grep 
-v "dns" | sort | uniq >$TAG_DIR/$name/$name_exp/list_dest_pow
	tshark -r $LAST_CAPT -T fields -e dns.qry.name -e dns.resp.name -E separator=\;  -E header=n -E quote=n | sort | uniq | awk -F 
";" {'if($2) print $2'} | awk -F "," {'print $1 "\n" $2 "\n" $3 "\n" $4 "\n" $5 "\n" $6 "\n" $7'} | grep -v "ntp" | grep -v "time" | grep 
-v "dns" | sort | uniq >>$TAG_DIR/$name/$name_exp/list_cname_pow
        tshark -r $LAST_CAPT  -q -z hosts | awk 'NF && $1!~/^#/' | awk '{print $1}' | grep -v "ntp" | grep -v "time" | grep -v "dns" | 
sort | uniq > $TAG_DIR/$name/$name_exp/list_ipdom_pow
        tshark -r $LAST_CAPT -T fields  -e ip.dst -e udp.port -E separator=\; | grep -v ",53" | grep -v "53," | grep -v ",123" | grep -v 
"123," | sort | uniq > $TAG_DIR/$name/$name_exp/list_ip_pow
        tshark -r $LAST_CAPT -T fields  -e ip.src -e udp.port -E separator=\; | grep -v ",53" | grep -v "53," | grep -v ",123" | grep -v 
"123," | sort | uniq >> $TAG_DIR/$name/$name_exp/list_ip_pow
     	grep -v -f $TAG_DIR/$name/$name_exp/list_ipdom_pow $TAG_DIR/$name/$name_exp/list_ip_pow 
>$TAG_DIR/$name/$name_exp/list_ipnodom_pow
        #tshark -r $LAST_CAPT -q -z ip_hosts,tree | awk {'print $1 ";" $2 ";" $3 ";" $4 ";" $5 ";" $6'} | grep "%" | grep -v "192.168." 
>> $TAG_DIR/$name/$name_exp/dest_list_all_2
    elif [[ "$TAG_DIR" != "notag" ]] && [[ $phone_exp == "x" ]]; then
        /opt/moniotr/bin/tag-experiment start $name $PHONE "power"
    fi

    if [[ "$TAG_DIR" != "notag" ]] && [[ $phone_exp != "x" ]]; then
        /opt/moniotr/bin/tag-experiment start-with-companion $name $PHONE $name_exp
    elif [[ "$TAG_DIR" != "notag" ]] && [[ $phone_exp == "x" ]]; then
        /opt/moniotr/bin/tag-experiment start $name $name_exp
    fi

    if [[ $phone_exp == *"echo"* || $phone_exp == *"google"* || $phone_exp == "allure-speaker" || $phone_exp == "x" ]]; then
        echo "echo..."
        sleep $sleep1
        ~/intl-iot/auto_app/blocker/./speak.sh $package
	sleep $sleep2
	COMP=0;
    if [ $COMP = "0" ]; then
        echo $DATE $name $name_exp "ok" >> $TAG_DIR/$name/exp_okA
        /opt/moniotr/bin/tag-experiment stop $name $name_exp $TAG_DIR
        cd $TAG_DIR/$name/$name_exp
        sleep 2s
        echo $TAG_DIR/$name/$name_exp
	echo "NOW"
        LAST_CAPT=$(ls -t | grep -v companion |  grep -v http | head -n 1)
        tshark -r $LAST_CAPT  -q -z hosts | awk 'NF && $1!~/^#/' | awk '{print $2}' | grep -v "ntp" | grep -v "time" | grep -v "dns" | 
sort | uniq > $TAG_DIR/$name/$name_exp/list_dest
        tshark -r $LAST_CAPT -T fields -e dns.qry.name -e dns.resp.name -E separator=\;  -E header=n -E quote=n | sort | uniq | awk -F 
";" {'if($2) print $2'} | awk -F "," {'print $1 "\n" $2 "\n" $3 "\n" $4 "\n" $5 "\n" $6 "\n" $7'} | grep -v "ntp" | grep -v "time" | grep 
-v "dns" | sort | uniq>>$TAG_DIR/$name/$name_exp/list_dest
        tshark -r $LAST_CAPT -T fields -e dns.qry.name -e dns.resp.name -E separator=\;  -E header=n -E quote=n | sort | uniq | awk -F 
";" {'if($2) print $2'} | awk -F "," {'print $1 "\n" $2 "\n" $3 "\n" $4 "\n" $5 "\n" $6 "\n" $7'} | grep -v "ntp" | grep -v "time" | grep 
-v "dns" | sort | uniq >>$TAG_DIR/$name/$name_exp/list_cname
        tshark -r $LAST_CAPT  -q -z hosts | awk 'NF && $1!~/^#/' | awk '{print $1}' | grep -v "ntp" | grep -v "time" | grep -v "dns" | 
sort | uniq > $TAG_DIR/$name/$name_exp/list_ipdom
        tshark -r $LAST_CAPT -T fields  -e ip.dst -e udp.port -E separator=\; | grep -v ",53" | grep -v "53," | grep -v ",123" | grep -v 
"123," | sort | uniq > $TAG_DIR/$name/$name_exp/list_ip
        tshark -r $LAST_CAPT -T fields  -e ip.src -e udp.port -E separator=\; | grep -v ",53" | grep -v "53," | grep -v ",123" | grep -v 
"123," | sort | uniq >> $TAG_DIR/$name/$name_exp/list_ip
        grep -v -f $TAG_DIR/$name/$name_exp/list_ipdom $TAG_DIR/$name/$name_exp/list_ip >$TAG_DIR/$name/$name_exp/list_ipnodom
        grep -v -f $TAG_DIR/$name/$name_exp/list_ipdom_pow $TAG_DIR/$name/$name_exp/list_ipnodom 
>$TAG_DIR/$name/$name_exp/list_ipnodom_dest_pow
    else
        echo $DATE $name $name_exp "failed" >> $TAG_DIR/$name/exp_okA
        /opt/moniotr/bin/tag-experiment cancel $name $name_exp
        echo "experiment canceled, the screenshots do not match!"
    fi

    else
        #echo "Starting app for device" $name_dev
        waitphone
        adb shell -n monkey -p $package -c android.intent.category.LAUNCHER 1
        sleep $sleep1
	if [[ $name == "roku-tv" ]]; then
		sleep 5s
		waitphone
		adb shell -n am force-stop $package
	        waitphone
             	adb shell -n monkey -p $package -c android.intent.category.LAUNCHER 1
		sleep 5s
	fi

        #scroll just in case and run functionalities
        #echo "Starting functionalities for device $name"
        [ -n "$function_1" ] && ( waitphone ; adb shell -n input $function_1 ; sleep 3s )
        [ -n "$function_2" ] && ( waitphone ; adb shell -n input $function_2 ; sleep 3s )
        [ -n "$function_3" ] && ( waitphone ; adb shell -n input $function_3 ; sleep 3s )
        [ -n "$function_4" ] && ( waitphone ; adb shell -n input $function_4 ; sleep 3s )
        [ -n "$function_5" ] && ( waitphone ; adb shell -n input $function_5 ; sleep 3s )
        [ -n "$function_6" ] && ( waitphone ; adb shell -n input $function_6 ; sleep 3s )
        [ -n "$function_7" ] && ( waitphone ; adb shell -n input $function_7 ; sleep 3s )
        [ -n "$function_8" ] && ( waitphone ; adb shell -n input $function_8 ; sleep 3s )
        [ -n "$function_9" ] && ( waitphone ; adb shell -n input $function_9 ; sleep 3s )
        sleep $sleep2
	echo "Stop experiment for device" $name_dev
    #capture screenshot
    waitphone
    adb shell -n screencap -p /sdcard/screen_exp.png
    waitphone
    adb pull /sdcard/screen_exp.png $CAPT_DIR/${name}.${name_exp}.${DATE}.png
    waitphone
    adb shell -n rm /sdcard/screen_exp.png
    #comparing screenshot
    COMP=$(convert $CAPT_DIR/${name}.${name_exp}.png $CAPT_DIR/${name}.${name_exp}.${DATE}.png -crop $crop +repage miff:- | compare 
-verbose -metric MAE  - $CAPT_DIR/out.${name}.${name_exp}.${DATE}.png 2>&1 | grep all | awk '{print $2}')
    COMP2=$(convert $CAPT_DIR/${name}.${name_exp}2.png $CAPT_DIR/${name}.${name_exp}.${DATE}.png -crop $crop +repage miff:- | compare 
-verbose -metric MAE  - $CAPT_DIR/out.${name}.${name_exp}.${DATE}.png 2>&1 | grep all | awk '{print $2}')
        #if [ $COMP = "0" ] || [ $COMP2 = "0" ]; then
    if [ $COMP = "0" ]; then
        echo $DATE $name $name_exp "ok" >> $TAG_DIR/$name/exp_okA
        /opt/moniotr/bin/tag-experiment stop $name $name_exp $TAG_DIR
        cd $TAG_DIR/$name/$name_exp
        sleep 2s
        echo $TAG_DIR/$name/$name_exp
        LAST_CAPT=$(ls -t | grep -v companion |  grep -v http | head -n 1)
        #tshark -r $LAST_CAPT  -q -z hosts | awk 'NF && $1!~/^#/' | awk '{print $2}' | grep -v "ntp" | grep -v "time" | grep -v "dns" | 
sort | uniq > $TAG_DIR/$name/$name_exp/list_dest
        tshark -r $LAST_CAPT -Y "dns.flags.response == 1" -T fields -E separator=\; -e dns.qry.name -e dns.a -E header=n -E quote=n | 
sort | uniq | awk -F ";" {'if($1) print $1'} | awk -F "," {'print $1 "\n" $2 "\n" $3 "\n" $4 "\n" $5 "\n" $6 "\n" $7'} | grep -v "ntp" | 
grep -v "time" | grep -v "dns" | sort | uniq>$TAG_DIR/$name/$name_exp/list_dest
	#tshark -r $LAST_CAPT -T fields -e dns.qry.name -e dns.resp.name -E separator=\;  -E header=n -E quote=n | sort | uniq | awk -F 
";" {'if($2) print $2'} | awk -F "," {'print $1 "\n" $2 "\n" $3 "\n" $4 "\n" $5 "\n" $6 "\n" $7'} | grep -v "ntp" | grep -v "time" | grep 
-v "dns" | sort | uniq>$TAG_DIR/$name/$name_exp/list_dest
	tshark -r $LAST_CAPT -T fields -e dns.qry.name -e dns.resp.name -E separator=\;  -E header=n -E quote=n | sort | uniq | awk -F 
";" {'if($2) print $2'} | awk -F "," {'print $1 "\n" $2 "\n" $3 "\n" $4 "\n" $5 "\n" $6 "\n" $7'} | grep -v "ntp" | grep -v "time" | grep 
-v "dns" | sort | uniq >>$TAG_DIR/$name/$name_exp/list_cname
        tshark -r $LAST_CAPT  -q -z hosts | awk 'NF && $1!~/^#/' | awk '{print $1}' | grep -v "ntp" | grep -v "time" | grep -v "dns" | 
sort | uniq > $TAG_DIR/$name/$name_exp/list_ipdom
        tshark -r $LAST_CAPT -T fields  -e ip.dst -e udp.port -E separator=\; | grep -v ",53" | grep -v "53," | grep -v ",123" | grep -v 
"123," | sort | uniq > $TAG_DIR/$name/$name_exp/list_ip
        tshark -r $LAST_CAPT -T fields  -e ip.src -e udp.port -E separator=\; | grep -v ",53" | grep -v "53," | grep -v ",123" | grep -v 
"123," | sort | uniq >> $TAG_DIR/$name/$name_exp/list_ip
        grep -v -f $TAG_DIR/$name/$name_exp/list_ipdom $TAG_DIR/$name/$name_exp/list_ip >$TAG_DIR/$name/$name_exp/list_ipnodom
	grep -v -f $TAG_DIR/$name/$name_exp/list_ipdom_pow $TAG_DIR/$name/$name_exp/list_ipnodom 
>$TAG_DIR/$name/$name_exp/list_ipnodom_dest_pow
    else
        echo $DATE $name $name_exp "failed" >> $TAG_DIR/$name/exp_okA
        /opt/moniotr/bin/tag-experiment cancel $name $name_exp
        echo "experiment canceled, the screenshots do not match!"
    fi
        waitphone
        adb shell -n am force-stop $package
    sleep 2s
    fi
rm $TAG_DIR/$name/$name_exp/dest_list2
cat $TAG_DIR/$name/$name_exp/list_dest_pow | sort | uniq | awk -F ";" {'print $1'} | grep -v "192.168." | grep -v "146.179.255.34" | grep 
-v "155.198.142" | grep -v "224.0.0" | grep -v "239.255." | grep -v "255.255." | grep -v "0.0.0.0" > $TAG_DIR/$name/$name_exp/dest_list2
cat $TAG_DIR/$name/$name_exp/list_ipnodom_pow | sort | uniq | awk -F ";" {'print $1'} | grep -v "192.168." | grep -v "146.179.255.34" | 
grep -v "155.198.142" | grep -v "224.0.0" | grep -v "239.255." | grep -v "255.255." | grep -v "0.0.0.0" >> 
$TAG_DIR/$name/$name_exp/dest_list2
cat $TAG_DIR/$name/$name_exp/list_dest | sort | uniq | awk -F ";" {'print $1'} | grep -v "192.168." | grep -v "146.179.255.34" | grep -v 
"155.198.142" | grep -v "224.0.0" | grep -v "239.255." | grep -v "255.255." | grep -v "0.0.0.0" >> $TAG_DIR/$name/$name_exp/dest_list2
cat $TAG_DIR/$name/$name_exp/list_ipnodom_dest_pow | sort | uniq | awk -F ";" {'print $1'} | grep -v "192.168." | grep -v 
"146.179.255.34" | grep -v "155.198.142" | grep -v "224.0.0" | grep -v "239.255." | grep -v "255.255." | grep -v "0.0.0.0" >> 
$TAG_DIR/$name/$name_exp/dest_list2

echo "$DATE;$name_exp">>$TAG_DIR/$name/$name_exp/dest_list
cat $TAG_DIR/$name/$name_exp/dest_list2 | sort | uniq | awk -F ";" {'print $1'} | grep -v "192.168." | grep -v "146.179.255.34" | grep -v 
"155.198.142" | grep -v "224.0.0" | grep -v "239.255." | grep -v "255.255." | grep -v "0.0.0.0" >> $TAG_DIR/$name/$name_exp/dest_list

echo "$DATE;$name_exp">>$TAG_DIR/$name/$name_exp/list_dest_pow_all
echo "$DATE;$name_exp">>$TAG_DIR/$name/$name_exp/list_dest_all
cat $TAG_DIR/$name/$name_exp/list_ipnodom_pow | sort | uniq | grep -v "192.168." | grep -v "146.179.255.34" | grep -v "155.198.142" | 
grep -v "224.0.0" | grep -v "239.255." | grep -v "255.255." | grep -v "0.0.0.0" >>$TAG_DIR/$name/$name_exp/list_dest_pow_all
cat $TAG_DIR/$name/$name_exp/list_ipnodom_dest_pow | sort | uniq | grep -v "192.168." | grep -v "146.179.255.34" | grep -v "155.198.142" 
| grep -v "224.0.0" | grep -v "239.255." | grep -v "255.255." | grep -v "0.0.0.0" >> $TAG_DIR/$name/$name_exp/list_dest_all
cat $TAG_DIR/$name/$name_exp/list_dest_pow | sort | uniq | grep -v "192.168." | grep -v "146.179.255.34" | grep -v "155.198.142" | grep 
-v "224.0.0" | grep -v "239.255." | grep -v "255.255." | grep -v "0.0.0.0" >>$TAG_DIR/$name/$name_exp/list_dest_pow_all
cat $TAG_DIR/$name/$name_exp/list_dest | sort | uniq | grep -v "192.168." | grep -v "146.179.255.34" | grep -v "155.198.142" | grep -v 
"224.0.0" | grep -v "239.255." | grep -v "255.255." | grep -v "0.0.0.0" >> $TAG_DIR/$name/$name_exp/list_dest_all

    if [ "$TAG_DIR" != "notag" ]; then
        if [ "$TAG_DIR" == "default" ]; then
            /opt/moniotr/bin/tag-experiment stop $name $name_exp $TAG_DIR
        else
            /opt/moniotr/bin/tag-experiment stop $name $name_exp $TAG_DIR
        fi
    fi
if [[ $name == *"smartth"* ]]; then
        waitphone
        adb shell -n monkey -p $package -c android.intent.category.LAUNCHER 1
        sleep $sleep1
        #scroll just in case and run functionalities
        #echo "Starting functionalities for device $name"
        [ -n "$function_1" ] && ( waitphone ; adb shell -n input $function_1 ; sleep 3s )
        [ -n "$function_2" ] && ( waitphone ; adb shell -n input $function_2 ; sleep 3s )
        [ -n "$function_3" ] && ( waitphone ; adb shell -n input $function_3 ; sleep 3s )
        [ -n "$function_4" ] && ( waitphone ; adb shell -n input $function_4 ; sleep 3s )
        [ -n "$function_5" ] && ( waitphone ; adb shell -n input $function_5 ; sleep 3s )
        [ -n "$function_6" ] && ( waitphone ; adb shell -n input $function_6 ; sleep 3s )
        [ -n "$function_7" ] && ( waitphone ; adb shell -n input $function_7 ; sleep 3s )
        [ -n "$function_8" ] && ( waitphone ; adb shell -n input $function_8 ; sleep 3s )
        [ -n "$function_9" ] && ( waitphone ; adb shell -n input $function_9 ; sleep 3s )
fi 
if [[ $name == *"rice"* ]]; then
        waitphone
        adb shell -n monkey -p $package -c android.intent.category.LAUNCHER 1
        sleep $sleep1
        #scroll just in case and run functionalities
        #echo "Starting functionalities for device $name"
        [ -n "$function_1" ] && ( waitphone ; adb shell -n input $function_1 ; sleep 3s )
        [ -n "$function_2" ] && ( waitphone ; adb shell -n input $function_2 ; sleep 3s )
        [ -n "$function_3" ] && ( waitphone ; adb shell -n input $function_3 ; sleep 3s )
        [ -n "$function_4" ] && ( waitphone ; adb shell -n input $function_4 ; sleep 3s )
        [ -n "$function_5" ] && ( waitphone ; adb shell -n input $function_5 ; sleep 3s )
        [ -n "$function_6" ] && ( waitphone ; adb shell -n input tap 994 288 ; sleep 3s )
        [ -n "$function_7" ] && ( waitphone ; adb shell -n input tap 496 1686 ; sleep 3s )
        [ -n "$function_7" ] && ( waitphone ; adb shell -n input tap 806 1721 ; sleep 3s )
fi
adb shell -n am force-stop $package
done < $DEV_AUTO

./power_detection.sh $SAFEGUARD
