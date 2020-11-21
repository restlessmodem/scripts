#!/bin/bash
# Script to unlock and mount bitlocker encrypted usb drive
echo "Unlocking Bitlocker Encrypted Drive located at /sdb/sdb2..."
echo "Enter Decryption key:"
read pw
sudo mkdir /mnt/dislockerwrapper /mnt/dislocker
sudo chown -R restlessmodem /mnt/dislockerwrapper /mnt/dislocker
sudo dislocker /dev/sdc2 -u${pw} -- /mnt/dislockerwrapper
sudo mount -o loop /mnt/dislockerwrapper/dislocker-file /mnt/dislocker
ls /mnt/dislocker
