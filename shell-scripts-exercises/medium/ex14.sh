#!/bin/bash

DAY=$(date +%F)

for FILE in *.jpg
do
	mv $FILE ${DAY}-${FILE}
done
