#!/bin/sh -l

echo "files_modified.json:"
cat ${HOME}/files_modified.json
echo "files_added.json:"
cat ${HOME}/files_added.json

cd "$1"
ls -la
newest=$(ls -At *.ebuild | head -n 1)

USE="${@:3}" ebuild $newest $2
