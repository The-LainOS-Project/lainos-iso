#!/usr/bin/env bash

counter=0

while :; do
	counter=$((counter + 1))
	tput cup 0 0
	# Using c-lolcat
	lolcat -h 0.05 -v 0.05 --color_offset $counter "$1"
	sleep 0.5
done
