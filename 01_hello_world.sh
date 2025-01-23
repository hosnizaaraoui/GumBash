#!/bin/bash

# Source the main script to reuse defined functions and styles
source easy.sh

# Clear the terminal screen
tput clear

# Move the cursor to row 2, column 0
goto 2 0

# Display a styled banner with the message "Hello World" in color code 5 (e.g., magenta)
banner "Hello World" 5

# Script written by the author
