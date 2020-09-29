#!/bin/sh -l

emerge -qv gn

cd "$1"
newest=$(ls -Art --ignore="*9999*" --ignore=Manifest --ignore=metadata.xml --ignore=files | tail -n 1)

USE="${@:3}" ebuild $newest $2
