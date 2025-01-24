#!/bin/bash

# Source the utility script containing UI helper functions
source ui_tools.sh

# Clear the terminal screen
tput clear

# Display a banner
banner "CPU Monitor: " 0

threshold=90

while true; do
    # Monitor CPU usage and trigger alert if threshold exceeded
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d. -f1)
    goto 4 0
    left=$(banner "CPU Usage: $cpu_usage" 5 $((cols - 25)))
    right=$(banner "Good" 2 25)

    gum join "$left" "$right"
    sleep .8
done
# Script written by the author
