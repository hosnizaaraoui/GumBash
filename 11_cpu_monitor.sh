#!/bin/bash

# Source the utility script containing UI helper functions
source ui_tools.sh

# Clear the terminal screen
tput clear

hidecursor

# Display a banner
banner "CPU Monitor: " 0

threshold=90

while true; do
    # Monitor CPU usage and trigger alert if threshold exceeded
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}')
    cpu_value=$(echo $cpu_usage | sed 's/%//')

    goto 4 0

    left=$(banner "CPU Usage: $cpu_usage" 5 $((cols - 25)))

    if (($(echo "$cpu_value > $threshold" | bc -l))); then
        right=$(banner "High Usage!" 1 25)
    else
        right=$(banner "Good" 2 25)
    fi

    gum join "$left" "$right"
    sleep .8

done

restorecursor

# Script written by the author
