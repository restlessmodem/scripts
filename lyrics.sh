#!/bin/bash
# Script to display lyrics of currently playing song (from last.fm)
while true; do
        echo "Fetching new lyrics..."
        query=$(~/System/Scripts/lastfmFetch.sh 1)
        clyrics $query | head -n45 > /tmp/lyrics
        clear
        echo -e "\n\033[1m$query\033[0m"
        echo -e "\033[1m----------------------\033[0m"
        cat /tmp/lyrics
        if [ "$(cat /tmp/lyrics)" == "" ]; then
                cat "/home/christopher/Documents/Lyrics/$query"
        elif [ ! -e "/home/christopher/Documents/Lyrics/$query" ]; then 
                cat /tmp/lyrics > "/home/christopher/Documents/Lyrics/$query"
        fi
        while [ "$(~/System/Scripts/lastfmFetch.sh 1)" ==  "$query" ]; do sleep 10; done
done
