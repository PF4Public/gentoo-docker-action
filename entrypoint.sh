#!/bin/sh

OLDIFS="$IFS"
IFS=$'\n'
combined=$((echo "$1" | grep -Po '"\K[^"]*.ebuild'; echo "$2" |grep -Po '"\K[^"]*.ebuild') | sort -du)
IFS="$OLDIFS"

for i in "${combined[@]}"
do
   USE="${@:4}" ebuild $i $3
done
