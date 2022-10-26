#!/bin/bash

FILE=/tmp/file_path
if test -e $FILE; then
	echo "file_path passwords are enabled."
	if [ -w "$FILE" ]; then
		echo "You have permissions to edit $FILE"
	else
		echo "You do NOT have permissions to edit $FILE"
	fi
else
	echo "file_path passwords are not enabled."
fi
