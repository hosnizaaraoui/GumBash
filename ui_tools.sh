#!/bin/bash

# Define text styles using `tput`
RED=$(tput setaf 1 && tput bold) # Red text with bold styling
GREEN=$(tput setaf 2)            # Green text
NONE=$(tput sgr0)                # Reset text formatting
BOLD=$(tput bold)                # Bold text

# Get terminal dimensions
cols=$(tput cols)   # Number of columns
lines=$(tput lines) # Number of lines

# Calculate terminal center positions
cols_mid=$(($cols / 2))   # Center column
lines_mid=$(($lines / 2)) # Center row

# Function to move the cursor to a specified row ($1) and column ($2)
goto() {
    tput cup $1 $2
}

# Function to display a loading animation
# Arguments:
#   $1: Title to display during loading
#   $2: Delay time (in seconds)
loading() {
    title=$1
    delay=$2

    # Use Gum to display a spinner with the given title and delay
    gum spin --spinner dot --title="$title" -- sleep $delay
}

# Function to display a styled alert/banner with a rounded border
# Arguments:
#   $1: Message to display
#   $2: Color code for the message (e.g., 1 for RED)
banner() {
    alert="$(tput setaf $2)$1$(tput sgr0)"

    if [[ $3 -ne 0 ]]; then
        cols=$3
    fi
    # Use Gum to display the styled banner
    gum style --bold --border rounded --width $(($cols - 2)) --height 1 "$alert"
}

# Function to get the current cursor position
# Outputs the row and column coordinates
get_cursor_coordinates() {
    # Save current cursor position
    echo -ne "\033[6n"              # ANSI escape code to request cursor position
    IFS=';' read -sdR -p '' row col # Read the response into variables
    row=${row#*[}                   # Extract the row number
    echo "$row $col"
}

hidecursor() {
    # Hide the cursor for better display
    trap "tput cnorm; exit" SIGINT SIGTERM

    tput civis
}

restorecursor() {
    # Ensure the cursor is restored when the script exits
    trap "tput cnorm" EXIT
}
