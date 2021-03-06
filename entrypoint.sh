#!/bin/sh

EXIT_CODE=0

TOOL="$3"

if [ "$TOOL" == "ebuild" ]; then
    list=$((echo "$1" | grep -Po '"\K[^"]*.ebuild'; echo "$2" |grep -Po '"\K[^"]*.ebuild') | sort -du | tr '\n' ' ')
    ACTION="$4"
    USE_FLAGS="${@:5}"
elif [ "$TOOL" == "repoman" ]; then
    list=$((echo "$1" | grep -Po '"\K[^"]*(.ebuild|Manifest|.xml)'; echo "$2" |grep -Po '"\K[^"]*(.ebuild|Manifest|.xml)') | sort -du | tr '\n' ' ')
    list=$(dirname $list | sort -du | uniq | tr '\n' ' ')
    ACTION="$4"
    PARAMS="${@:5}"
elif [ "$TOOL" == "emerge" ]; then
    echo "TODO!"
    exit 1
fi

# No array support
set -- junk $list
shift
for i; do
    if [ "$TOOL" == "ebuild" ]; then
        USE="$USE_FLAGS" NODIE=1 I_KNOW_WHAT_I_AM_DOING=yes ebuild $i $ACTION
        RETVAL=$?
    elif [ "$TOOL" == "repoman" ]; then
        pushd $i
            repoman $ACTION $PARAMS
            RETVAL=$?
        popd
    elif [ "$TOOL" == "emerge" ]; then
        echo "TODO!"
        exit 1
    fi

    if [ $RETVAL -ne 0 ]
    then
        EXIT_CODE=$RETVAL
    fi
done

exit $EXIT_CODE
