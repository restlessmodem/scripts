#!/bin/bash
# Script to backup full system to LUKS encrypted drive via rsync
echo Starting System Backup with rsync...
sudo -v

read -p "Cleaning? " -n 1
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	echo Cleaning System with Bleachbit...
	bleachbit -c --preset
	sudo pacman -Scc
fi

echo "Waiting 3 seconds..."
nap 3

if [ ! -e /mnt/ChristopherData/backups/darlene/ ]; then
	echo "Mount the encrypted backup drive first!"
	exit 1
fi
sudo rsync -avh --progress --exclude=/boot/* --exclude=/dev/* --exclude=/proc/* --exclude=/sys/* --exclude=/tmp/* --exclude=/run/* --exclude=/mnt/* --exclude=/media/* --exclude=/lost+found/ --exclude=/home/christopher/.cache/ / /mnt/ChristopherData/backups/darlene/ --delete-before

echo "Additional files..."
echo "darlene-backup" | sudo tee /mnt/ChristopherData/backups/darlene/etc/hostname
echo Finished!
