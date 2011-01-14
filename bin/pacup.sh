#!/bin/bash

# An updates notification script , wich displays the number of updates in xmobar
# this should be run as  run Com "sh" ["/path/to/updates.sh"]  interval
# this only works for ArchLinux

po=$(pacman -Qu)
echo $po | grep -q 'Targets'

if [ $? = 0 ]; then # grep found something
	echo $po |
	sed 's/^.*Targets ([0-9]*):\(.*\)Total Download Size:.*/\1/' |
	wc -w
else
	echo 0
fi
