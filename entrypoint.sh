#!/bin/sh -l

mapfile -t my_array1 < <( echo "$1" |grep -Po '"\K[^"]*.ebuild' )
mapfile -t my_array2 < <( echo "$2" |grep -Po '"\K[^"]*.ebuild' )

OLDIFS="$IFS"
IFS=$'\n'
combined=(`for R in "${my_array1[@]}" "${my_array2[@]}" ; do echo "$R" ; done | sort -du`)
IFS="$OLDIFS"

for i in "${combined[@]}"
do
   USE="${@:4}" ebuild $i $3
done
