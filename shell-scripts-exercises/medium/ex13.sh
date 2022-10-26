#!/bin/bash

DIRECTORY=$1

function file_count() {
	local Directory=$1
	COUNT_FILE=$(ls $Directory | wc -l)
	echo "$Directory: "
	echo "$COUNT_FILE"
	echo
}

file_count /etc
file_count /var
file_count /usr/bin



