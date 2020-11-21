#!/bin/bash
# Wrapper for ssh which waits for client (to come back)
ssh $1
while test $? -gt 0
do
   sleep 3
   echo "Waiting for host..."
   ssh $1
done
