#!/bin/bash

# Source the utility script containing UI helper functions
source ui_tools.sh

# Clear the terminal screen
tput clear

# Display a banner for the day of the week
banner "Day Of Week: Day Of $USER" 0

# Define an array for the days of the week
days=("Sunday" "Monday" "Tuesday" "Wednesday" "Thursday" "Friday" "Saturday")

# Move the cursor to row 4, column 0
goto 4 0

# Display a banner with the current day of the week and a personalized message
banner "Hey $USER, today is ${days[$(date +%w)]}. A good day to bash scripting." 4

# Script written by the author
