#!/bin/sh

echo "DISTDIR=${GITHUB_WORKSPACE}/distfiles" >> /etc/portage/make.conf
echo "CCACHE_DIR=${GITHUB_WORKSPACE}/ccache" >> /etc/portage/make.conf

EXIT_CODE=0

TOOL="$2"

if [ "$TOOL" == "ebuild" ]; then
    list=$((echo "$1" | grep -Po '[^ ]*.ebuild' ) | sort -du | tr '\n' ' ')
    ACTION="$3"
    USE_FLAGS="${@:4}"
elif [ "$TOOL" == "repoman" ] || [ "$TOOL" == "pkgcheck" ]; then
    list=$((echo "$1" | grep -Po '[^ ]*(.ebuild|Manifest|.xml)' ) | sort -du | tr '\n' ' ')
    list=$(dirname $list | sort -du | uniq | tr '\n' ' ')
    ACTION="$3"
    PARAMS="${@:4}"
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
        USE="$USE_FLAGS" NODIE=1 I_KNOW_WHAT_I_AM_DOING=yes ebuild $i clean
    elif [ "$TOOL" == "repoman" ]; then
        pushd $i
            repoman --ignore-arches $ACTION $PARAMS
            RETVAL=$?
        popd
    elif [ "$TOOL" == "pkgcheck" ]; then
        pushd $i
            pkgcheck $ACTION $PARAMS --color true
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
