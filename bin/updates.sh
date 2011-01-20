#!/bin/bash

## Update notifier, for Archlinux / Pacman only!

updates=$(pacman -Qu  | wc -l)

if [ $updates = 0 ]; then # grep found something
	echo 0
else
	echo $updates 
fi
