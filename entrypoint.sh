#!/bin/sh -l

echo "$1"

echo "$*"

echo "USE=\"${@:3}\" ebuild $oldest $2"

cd $1
oldest=$(ls -At --ignore="*9999*" --ignore=Manifest --ignore=metadata.xml --ignore=files | tail -n 1)

USE="${@:3}" ebuild $oldest $2
