#!/bin/sh
state=`acpi | cut -d ' ' -f3 | cut -d ',' -f1`
num=`acpi | cut -d ' ' -f4 | cut -d ',' -f1`

case $state in
	#somehow my laptop can not correct show the state of the battery, while it is charging, it shows "Unknown"
	Unknown) echo "🔋$num";;
	Discharging) 
		lefttime=`acpi | cut -d ' ' -f5-6`
		echo "$num($lefttime)";;
	*) echo "🔋$num";;
esac
