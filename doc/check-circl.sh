#!/bin/sh

if ! [ -d "$1" ]; then
	if ! [ -f "$1" ]; then
		echo "Argv1: Path of file or directory"
		exit
	fi
fi

find "$1" -type f | while read line; do

echo "== Filename: $line =="
curl -s -X 'GET'   "https://hashlookup.circl.lu/lookup/sha256/$(sha256sum "$line" | cut -f 1 -d ' ')"   -H 'accept: application/json' | jq

sleep 2

echo
echo
done