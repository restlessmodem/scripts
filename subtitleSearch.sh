#!/bin/bash
# Script to search and download subtitles from subscene
echo 'Usage Example: subtitle_search "The Good Place" "First"'
rm *.srt
SUBWEBSITE="subscene.com"
NAMEURL="$(echo $1 |  sed -e 's/ /%20/g' )"

echo -e "\n\033[1mFinding Subtitle Page URL...\033[0m" # Finding Subtitle Page Url
SHOW_SUBTITLEPAGE=$(curl -s "https://$SUBWEBSITE/subtitles/title?q=$NAMEURL" | sed -n '/<div class="title">/,/<\/div>/p' | grep "a href" | sed -e 's/\t//g' | sed -e 's/  //g' | sed -e 's/<a href=//g' | sed -e 's/<\/a>//g' | sed -e 's/>/\t/g' | sed -e "s/&#39;/'/g" | sed -e 's/\t/    /g' | grep -E "$2" | cut -d '"' -f2) # getting subtitle list
curl -s https://$SUBWEBSITE$SHOW_SUBTITLEPAGE | sed -n '/<td class="a1">/,/<\/td>/p' | grep --no-group-separator -E "(<a href=|<span>)" -A1 | grep -v span | tr -d "\t" | cut -d'"' -f2 | grep /english/ -A1 | tr -t " " "_" > /tmp/subtitlelist

if [ "$(cat /tmp/subtitlelist)" != "" ]; then
    if [ $LATEST ]; then
        SUBTITLEMENUOUTPUT=$(cat /tmp/subtitlelist | head -n1)
    else
        SUBTITLEMENUOUTPUT=$(zenity --list --width 700 --height 500 --text "Select Subtitle:" --column "Subtitle" --column "Name" $(cat /tmp/subtitlelist) 2>/dev/null)
    fi
fi

if [ "$SUBTITLEMENUOUTPUT" != "" ]; then
    echo -e "\033[1mDownloading Subtitle...\033[0m"
    SUBDOWNLOADREL=$(curl -s https://$SUBWEBSITE$SUBTITLEMENUOUTPUT | sed -n '/<div class="download">/,/<\/div>/p' | grep "a href" | cut -d '"' -f2)
    wget -qO sub.zip https://$SUBWEBSITE$SUBDOWNLOADREL
    unzip -o sub.zip && rm sub.zip
    mv *.srt currentsub.srt
else
    echo -e "\e[91mERROR: No subtitle found!\e[39m"
fi