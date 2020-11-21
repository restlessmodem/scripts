#!/bin/bash
# Script to set new wallpaper using nitrogen on all screens
while true; do
	echo "Changing wallpaper..."
	nitrogen --set-zoom-fill --random --head=0
	nitrogen --set-zoom-fill --random --head=1
	nitrogen --set-zoom-fill --random --head=2
	sleep 10m
done
