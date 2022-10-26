#!/bin/bash

if [ -e "$1" ]
then
	echo "File exists."
	echo
	file "$1"
	echo
	ls -lah $1
else
	echo "File doesn't exists."
fi
