#!/bin/bash

EXIT_CODE=0

USE_FLAGS="${@:4}"
ACTION="$3"

list=$((echo "$1" | grep -Po '"\K[^"]*.ebuild'; echo "$2" |grep -Po '"\K[^"]*.ebuild') | sort -du | tr '\n' ' ')

set -- junk $list
shift
for i; do
   USE="$USE_FLAGS" ebuild $i $ACTION
   RETVAL=$?
   if [ $RETVAL -ne 0 ]
   then
      EXIT_CODE=$RETVAL
   fi
done

exit $EXIT_CODE
