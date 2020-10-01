#!/bin/sh -l

cd "$1"
newest=$(ls -At *.ebuild | head -n 1)

USE="${@:3}" ebuild $newest $2
