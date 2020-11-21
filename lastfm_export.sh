#!bin/bash
# Script to download a list of listened songs from a last.fm user
username=$1
for i in {1..12}
do
	echo "Exporting page $i..."
	curl -s "https://www.last.fm/user/$username/library/tracks?page=$i&date_preset=ALL" | grep -A20 '<td class="chartlist-name"' | grep -B1 '\-\-' | grep -v -- "^--$" | cut -d'"' -f2 >> lastfm_export.txt
done
