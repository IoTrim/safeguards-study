SAFEGUARD_NAME="$1"
adb shell dumpsys notification > notification_on-off_$SAFEGUARD_NAME.txt
