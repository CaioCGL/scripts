#!/bin/bash

echo "Which action do you want to perform? (start/stop):"
read VAR
echo
echo "Please enter the name of the program that you want to $VAR:"
read PROGRAM

case $VAR in
        start)
                $PROGRAM&
                ;;
        stop)
                PID=$(ps aux | grep $PROGRAM | awk '{print $2}' | sed '1!d')
		kill -9 $PID
		if [ "$?" -eq "0" ]
		then
			echo
			echo "==== $PROGRAM Stopped ===="
			echo
      		else
			echo "ERROR stoping $PROGRAM"
		fi
                ;;
        *)
                echo "Invalid Option!"
                exit 1
                ;;
esac
