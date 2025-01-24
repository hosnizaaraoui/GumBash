#!/bin/bash

# Source the utility script containing UI helper functions
source ui_tools.sh

# Clear the terminal screen
tput clear

# Move the cursor to row 2, column 0
goto 2 0

# Display a styled banner with the message "Hello World" in color code 5 (e.g., magenta)
banner "Hello World" 5

# Script written by the author
