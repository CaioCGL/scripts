#!/bin/bash

echo "Type the name of the file you want to verify."
read FILE
echo

if [ -e "$FILE" ]
then
	echo "File exists."
	echo
	file "$FILE"
	echo
	ls -lah $FILE
else
	echo "File doesn't exists."
fi
