#!/bin/bash

DAY=$(date +%F)
echo "Please enter the file extension: "
read EXTENSION
echo
echo "Please enter the prefix to prepend to the file: "
read PREFIX
echo

if [[ -z "$PREFIX" ]]
then
	echo "$PREFIX"
	PREFIX=$DAY
fi

for FILE in *.$EXTENSION
do
	echo "$FILE --> $PREFIX-$FILE"
	mv $FILE ${PREFIX}-${FILE}
done
