#!/bin/bash

INPUTS=$@

for INPUT in $INPUTS
do
	echo "Result for $INPUT: "
	echo
	if [ -e "$INPUT" ]
	then
		echo "File exists."
		echo
		file "$INPUT"
		echo
		ls -lah $INPUT
	else
		echo "File doesn't exists."
	fi
	echo
	echo "==============================================" 
	echo
done
