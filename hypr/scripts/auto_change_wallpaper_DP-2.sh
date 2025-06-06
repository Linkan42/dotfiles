#!/usr/bin/bash

while true; do

	waypaper --folder /home/linus/Documents/wallpapers/3440x1440 --monitor "DP-2" --random

	rand=$RANDOM
	min=600
	max=3600
	rand=$(( RANDOM % (max - min + 1) + min ))

	sleep "$rand"
done
