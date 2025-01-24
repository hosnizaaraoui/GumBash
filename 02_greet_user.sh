#!/bin/bash

# Source the utility script containing UI helper functions
source ui_tools.sh

# Clear the terminal screen
tput clear

# Prompt the user for their username using Gum
name=$(gum input --placeholder="Username: ")

# Display a loading spinner while "searching" for the username
loading "Searching for '$name'..." .6

# Check if the entered name matches the current user
if [[ $name == $USER ]]; then
    # Display a friendly message if the names match
    banner "Welcome back, $name! Have a great day!" 2
else
    # Display a playful message if the names don't match
    banner "Hello, $USER! Is '$name' your nickname?" 6
fi
# Script written by the author
