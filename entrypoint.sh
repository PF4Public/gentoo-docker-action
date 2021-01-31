#!/bin/sh

EXIT_CODE=0

USE_FLAGS="${@:4}"
ACTION="$3"

list=$((echo "$1" | grep -Po '"\K[^"]*.ebuild'; echo "$2" |grep -Po '"\K[^"]*.ebuild') | sort -du | tr '\n' ' ')

# No array support
set -- junk $list
shift
for i; do
   USE="$USE_FLAGS" NODIE=1 I_KNOW_WHAT_I_AM_DOING=yes ebuild $i $ACTION
   RETVAL=$?
   if [ $RETVAL -ne 0 ]
   then
      EXIT_CODE=$RETVAL
   fi
done

exit $EXIT_CODE
