#!/bin/bash

# Define text styles using `tput`
RED=$(tput setaf 1 && tput bold) # Red text with bold styling
GREEN=$(tput setaf 2)            # Green text
NONE=$(tput sgr0)                # Reset text formatting
BOLD=$(tput bold)                # Bold text

# Get terminal dimensions
cols=$(tput cols)   # Number of columns in the terminal
lines=$(tput lines) # Number of rows (lines) in the terminal

# Calculate the center of the terminal
cols_mid=$(($cols / 2))   # Center column index
lines_mid=$(($lines / 2)) # Center row index

# Function to hide the cursor for cleaner display
hidecursor() {
    # Ensure the cursor is restored upon script exit
    trap "tput cnorm; exit" SIGINT SIGTERM

    # Hide the cursor
    tput civis
}

# Function to restore the cursor when the script exits
restorecursor() {
    trap "tput cnorm" EXIT
}

# Function to move the cursor to a specified row ($1) and column ($2)
goto() {
    hidecursor
    tput cup $1 $2 # Move the cursor to the specified position
    restorecursor
}

# Function to display a loading animation
# Arguments:
#   $1: Title to display during loading
#   $2: Delay time (in seconds)
loading() {
    title=$1
    delay=$2

    # Display a spinner with the provided title and delay
    gum spin --spinner dot --title="$title" -- sleep $delay
}

# Function to display a styled alert/banner with a rounded border
# Arguments:
#   $1: Message to display
#   $2: Color code for the message (e.g., 1 for RED)
#   $3: (Optional) Width of the banner
banner() {
    alert="$(tput setaf $2)$1$(tput sgr0)"

    # Adjust the banner width if a third argument is provided
    if [[ $3 -ne 0 ]]; then
        cols=$3
    fi

    # Display the styled banner with a rounded border
    gum style --bold --border rounded --width $(($cols - 2)) --height 1 "$alert"
}

# Function to get the current cursor position
# Outputs the row and column coordinates
get_cursor_coordinates() {
    # Request the current cursor position using an ANSI escape code
    echo -ne "\033[6n"
    # Parse the response to extract row and column values
    IFS=';' read -sdR -p '' row col
    row=${row#*[} # Remove unwanted characters to extract the row number
    echo "$row $col"
}

# Function to clear all lines from a specified starting line to the bottom
# Arguments:
#   $1: Line number to start clearing from
clearlines() {
    local total_lines=$(tput lines)   # Get the total number of lines in the terminal
    total_lines=$((total_lines - $1)) # Adjust for the starting line

    # Move the cursor to the starting line
    goto $1 0

    # Loop through the lines and clear them
    for ((i = 0; i < total_lines; i++)); do
        tput el   # Clear the current line
        tput cuu1 # Move the cursor up one line
    done

    # Reset the cursor to the starting position
    goto $1 0
}
