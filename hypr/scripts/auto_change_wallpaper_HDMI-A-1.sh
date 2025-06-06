#!/usr/bin/bash

while true; do

	waypaper --folder /home/linus/Documents/wallpapers/2160x3840 --monitor "HDMI-A-1" --random

	rand=$RANDOM
	min=600
	max=3600
	rand=$(( RANDOM % (max - min + 1) + min ))

	sleep "$rand"
done
