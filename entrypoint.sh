#!/bin/sh

EXIT_CODE=0

echo "sort:"
(echo "$1" | grep -Po '"\K[^"]*.ebuild'; echo "$2" |grep -Po '"\K[^"]*.ebuild') | sort -du

list=$((echo "$1" | grep -Po '"\K[^"]*.ebuild'; echo "$2" |grep -Po '"\K[^"]*.ebuild') | sort -du)
echo -e "list:\n$list\n"

IFS=$'\n' combined=($list)

echo -e "combined:\n$combined\n"
echo -e "combined0:\n${combined[0]}\n"

for i in "${combined[@]}"
do
echo -e "i:\n$i\n"
   USE="${@:4}" ebuild $i $3
   RETVAL=$?
   if [ $RETVAL -ne 0 ]
   then
      EXIT_CODE=$RETVAL
   fi
done

exit $EXIT_CODE
