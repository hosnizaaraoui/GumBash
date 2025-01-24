#!/bin/bash

# Source the utility script containing UI helper functions
source ui_tools.sh

# Clear the terminal screen
tput clear

# Display a banner
banner "Log Analyser: " 0

logfile=$(gum file --all "/var/log")

# Extract lines with "ERROR" from the log file
gum spin --title="Extracting errors..." -- grep "ERROR" "$logfile" >error_log.txt

gum pager <error_log.txt

gum confirm "Would keep the errors file?"
if [[ $? -eq 1 ]]; then
    rm -f error_log.txt
fi

# Script written by the author
