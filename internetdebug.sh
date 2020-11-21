#!/bin/bash
# Script to find out why I have no internet connection, it is probably Vodafone's fault
echo "Internet Connection Status:"
if ! ping -c1 10.0.0.1; then
	echo "Connection to EdgeRouter X failed!"
elif ! ping -c1 192.168.0.1; then
	echo "Connection to ISP Router failed!"
elif ! ping -c1 1.1.1.1; then
	echo "Connection to Public Internet failed!"
elif ! ping -c1 google.com; then
	echo "DNS failed!"
else
	echo "All connections successful!"
fi
