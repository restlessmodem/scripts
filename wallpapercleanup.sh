#!/bin/bash
# Script to go through wallpaper so I can delete old ones
cd /home/restlessmodem/Pictures/Wallpaper/
i=1
ALLWLPS=99
while [ $i -lt $ALLWLPS ]; do
	ALLWLPS=$(find /home/restlessmodem/Pictures/Wallpaper/ -type f | wc -l)
	FILE=$(find /home/restlessmodem/Pictures/Wallpaper/ -type f | sed -n "$i p")
	feh --bg-fill $(echo $FILE)

	read -p "Keep this wallpaper? ($i/$ALLWLPS) " -n 1 -r
	echo
	if [[ $REPLY =~ ^[Nn]$ ]]; then
  	  sudo rm $FILE
	else
		i=$(($i+1))
	fi
	#if [ "$(ls -A $DIR)" ]; then exit 0; fi
done
echo "Finished!"
