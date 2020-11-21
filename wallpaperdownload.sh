#!/bin/bash
# Script to download new wallpapers (from links entered into nano); sets them so I can see what they look like on the actual screen
cd /home/restlessmodem/Pictures/Wallpapers/wallpaperdownload/
nano /tmp/wlplist
sudo wget $(cat /tmp/wlplist) -P /home/restlessmodem/Pictures/Wallpapers/wallpaperdownload/

ALLWLPSDOWN=99
while [ $ALLWLPSDOWN -gt 1 ]; do
	ALLWLPSDOWN=$(find /home/restlessmodem/Pictures/Wallpapers/wallpaperdownload/ -type f | wc -l)
	FILE=$(find /home/restlessmodem/Pictures/Wallpapers/wallpaperdownload/ -type f | shuf -n1)
	feh --bg-fill $(echo $FILE)

	read -p "Keep this wallpaper? ($ALLWLPSDOWN) " -n 1 -r
	echo
	if [[ $REPLY =~ ^[Nn]$ ]]; then
  	sudo rm $FILE
	else
		sudo mv $FILE /home/restlessmodem/Pictures/Wallpapers/$(basename $FILE)
	fi
done
