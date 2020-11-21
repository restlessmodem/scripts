#!/bin/bash
# Script used by polybar for protonvpn widget
protonvpn status > /tmp/protonStatus
status=$(cat /tmp/protonStatus | grep Status | cut -d ":" -f2 | tr -d " ")
server=$(cat /tmp/protonStatus | grep Server | cut -d ":" -f2 | tr -d " ")
protocol=$(cat /tmp/protonStatus | grep Protocol | cut -d ":" -f2 | tr -d " ")
load=$(cat /tmp/protonStatus | grep Load | cut -d ":" -f2 | tr -d " ")
ks=$(cat /tmp/protonStatus | grep "Kill Switch" | cut -d ":" -f2 | tr -d " ")

if [ $status == "Connected" ]; then
    echo "VPN $status ($protocol) - $server - $load"
else
    echo "VPN disconnected"
fi
