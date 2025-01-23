#!/bin/bash

# Source the easy.sh script to use the defined functions and styles
source easy.sh
tput clear

# Set the number of countdown characters
nmbr=40
range=$nmbr

# Fetch terminal columns dynamically
cols=$(tput cols)

# Check if the terminal width is enough
if [[ $cols -lt $nmbr ]]; then
    # Display error message if terminal is too narrow
    banner "Hey $USER! This script needs a minimum of $nmbr columns to run!" 1
    echo "Your terminal width ($cols columns) is too small for this countdown."
    exit 1
else
    # Display a countdown header
    banner "COUNTDOWN: " 0
    col=$(( (cols - nmbr) / 2 ))  # Center the countdown in the terminal

    # Ask the user if they are ready to start the countdown
    gum confirm "Ready to start the countdown? Press Enter to continue."
     # Move the cursor to row 4 and center the countdown characters
    goto 4 $col
    printf "$RED✘%.0s" $(seq 1 $nmbr)

    # Countdown loop
    for (( i=1; i<=range; i++ )); do
       
        # Move the cursor to row 6 and print the current countdown value
        goto 6 $cols_mid
        printf "[%3d]" $nmbr
        nmbr=$((nmbr - 1))

        # Move the cursor down and print green checkmark for progress
        goto 4 $col
        echo "$GREEN✔"

        # Update column for next countdown position
        col=$((col + 1))
        
        # Sleep for 0.05 seconds to create a visual countdown effect
        sleep 0.05
    done

    # Ask the user if they want to finish after countdown
    gum confirm "Countdown complete! Press Enter to finish."

    # Reset terminal colors after the countdown
    echo "$NONE"
fi

# Script written by the author
