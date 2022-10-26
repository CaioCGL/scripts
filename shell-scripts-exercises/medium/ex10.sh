#!/bin/bash

FILE=$1

if [ -f "$FILE" ]
then
	echo "$FILE is a regular file."
elif [ -d "$FILE" ]
then
	echo "$FILE is a directory"
	exit 1
else
	echo "$FILE is another type of file"
fi
exit 2
