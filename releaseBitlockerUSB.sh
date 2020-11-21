#!/bin/bash
# Script to eject bitlocker encypted USB drive
sync
sudo umount /mnt/dislocker
sudo umount /mnt/dislockerwrapper
sudo eject /dev/sdb
