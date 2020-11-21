#!/bin/bash
# Script to backup online minecraft world using rcon and scp
# force save
mcrcon -H10.156.0.2 -p ysggPUsz2fgTC9M "/say Players, please stand by for world backup..."
mcrcon -H10.156.0.2 -p ysggPUsz2fgTC9M "save-off"
mcrcon -H10.156.0.2 -p ysggPUsz2fgTC9M "save-all"

# tar world folder
echo "Collecting world..."
ssh krista tar -cpvzf /home/christopher/minecraft-0-$(date +%s).tar.gz /opt/minecraft/server/world/

mcrcon -H10.156.0.2 -p ysggPUsz2fgTC9M "save-on"

# Execute backup
echo "Transfering world..."
scp krista:/home/christopher/minecraft-* /home/restlessmodem/

# Delete archives from server
echo "Cleaning up..."
ssh krista rm /home/christopher/minecraft-*

mcrcon -H10.156.0.2 -p ysggPUsz2fgTC9M "/say Backup complete..."
