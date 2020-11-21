#!/bin/bash
# Script to unlock and mount bitlocker encrypted hard drive
sudo mkdir /mnt/ChristopherData
sudo chown -R christopher /mnt/ChristopherData
sudo cryptsetup open /dev/sdb1 ChristopherData
sudo mount /dev/mapper/ChristopherData /mnt/ChristopherData
