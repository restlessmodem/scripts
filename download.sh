#!/bin/bash
# Script to run fast parallel downloads
aria2c --file-allocation=none -c -x 16 -s 16 $1
