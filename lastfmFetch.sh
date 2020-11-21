#!/bin/bash
# Script used by polybar for last.fm widget
if [ "$1" == "1" ]; then
    if [ ! -e /tmp/lastfm ]; then mkdir /tmp/lastfm; fi
    AS_BASEURL="http://ws.audioscrobbler.com/2.0/?method="
    AS_PROPS="&user=restlessmodem&api_key=$(cat ~/Development/Scripts/lastfm.key)"
    curl -s "${AS_BASEURL}user.getinfo${AS_PROPS}" > /tmp/lastfm/count
    curl -s "${AS_BASEURL}user.getrecenttracks${AS_PROPS}" | head -n15 | sed -e "s/&apos;/\'/g" > /tmp/lastfm/recents
    curl -s "${AS_BASEURL}user.getweeklytrackchart${AS_PROPS}" | grep -oP '(?<=<playcount>).*?(?=</playcount>)' | awk '{s+=$1} END {print s/7}' > /tmp/lastfm/perdaylastweek
fi

# last.fm
PLAYCOUNT=$(cat /tmp/lastfm/count | grep -oP '(?<=<playcount>).*?(?=</playcount>)' | cut -c 1-20)
TITLE=$(cat /tmp/lastfm/recents | grep -oP '(?<=<name>).*?(?=</name>)' | head -n1 | cut -c 1-20)
ARTIST=$(cat /tmp/lastfm/recents | grep -oP '(?<=<artist mbid=).*?(?=</artist>)' | cut -d '>' -f2 | head -n1)
AVGLASTWEEK=$(cat /tmp/lastfm/perdaylastweek | cut -c 1-5)
AVGLASTWEEK2=$(echo $AVGLASTWEEK | cut -d. -f1)

OUTPUT="$TITLE - $ARTIST ($PLAYCOUNT / $AVGLASTWEEK2)"

if [[ $OUTPUT == " -  ( / 0)" ]]; then
	OUTPUT="Loading..."
fi
echo $OUTPUT
