#!/bin/sh

OLDIFS="$IFS"
IFS=$'\n'
combined=($((echo "$1" | grep -Po '"\K[^"]*.ebuild'; echo "$2" |grep -Po '"\K[^"]*.ebuild') | sort -du))
IFS="$OLDIFS"

echo -e "combined:\n$combined\n"
echo -e "combined0:\n${combined[0]}\n"

for i in "${combined[@]}"
do
echo -e "i:\n$i\n"
   USE="${@:4}" ebuild $i $3
done
