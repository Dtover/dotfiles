#!/bin/sh
#get the name of the wifi device
[[ -z "$INTERFACE" ]] && INTERFACE=`ip link | grep 2: | cut -d ' ' -f2 | cut -d ':' -f1`
#Check whether the wifi device is up 
if [[ "$(cat /sys/class/net/$INTERFACE/operstate)" = 'down' ]]; then
	echo "down"
	echo "down"
	echo "#FF0000"
	exit
else
	ipaddr=`ip addr | grep -i "$INTERFACE$" | cut -d ' ' -f6 | cut -d '/' -f1`
	quality=`grep $INTERFACE /proc/net/wireless | awk '{print int($3 * 100 / 70)}'`
	echo "W: $ipaddr($quality%)"
	echo "W: $ipaddr($quality%)"
	echo "#39B43F"
fi
