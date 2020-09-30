#!/bin/sh -l

emerge -qv gn

cd "$1"
newest=$(ls -Ar *.ebuild | head -n 1)

USE="${@:3}" ebuild $newest $2
