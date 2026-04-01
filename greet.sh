#!/bin/sh
FIRST_NAME=$(getent passwd "$USER" | cut -d: -f5 | cut -d, -f1 | cut -d' ' -f1)
#1. (getent) Start with user info,
#2,3. (cut, cut) strip it to the name,
#4. (cut) Pull only the first.

#Test if empty, fall back on username.
if [ -z "$FIRST_NAME" ]; then
	FIRST_NAME="$USER"
fi

#Get the hour
HOUR=$(date +"%H")

#Default to evening, for very early morning work.
TIME_GREETING="evening"

#A question I love to ask people is "Is 5 o'clock the afternoon, or evening?"
#I'm opting for 5 o'clock to be evening, because it's a nice confirmation that
#it's almost time to clock out.

#If it's before 5:00 PM
if [ $HOUR -lt 17 ]; then
	#If it's 4:00 AM or later
	if [ $HOUR -gt 3 ]; then
		TIME_GREETING="morning"
	fi
	#If it's 12:00 PM or later
	if [ $HOUR -gt 11 ]; then
		TIME_GREETING="afternoon"
	fi
fi

#Greet user based on time
echo "Good $TIME_GREETING, $FIRST_NAME."
