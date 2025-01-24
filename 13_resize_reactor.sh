#!/bin/bash

# Source the utility script containing UI helper functions
source ui_tools.sh

# Display a banner
banner "Terminal Window Reactor: " 0

update() {
    # Get terminal dimensions
    cols=$(tput cols)   # Number of columns
    lines=$(tput lines) # Number of lines

    clearlines 0

    # Print the updated dimensions cleanly
    goto $lines_mid 0
    banner "DEBUG terminal window has now $lines lines and is $cols characters wide" 2
}

# Initialize and continuously listen for window size changes
trap update WINCH
update

# Keep the script running
while true; do
    sleep 1
done
