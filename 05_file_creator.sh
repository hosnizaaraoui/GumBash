
#!/bin/bash

# Source the main script to reuse defined functions and styles
source easy.sh

# Clear the terminal screen
tput clear

# Display a banner for the file creator tool
banner "File Creator" 0

# Prompt the user to input the filename
filename=$(gum input --placeholder="Type the filename...")

# Check if filename is empty or invalid
if [[ -z "$filename" ]]; then
    echo "Error: Filename cannot be empty."
    exit 1
fi

# Check if the file already exists and ask if the user wants to overwrite it
if [[ -e "$filename" ]]; then
    gum confirm "File already exists. Do you want to overwrite it?" || exit 1
fi

# Allow the user to write content into the specified file
gum write --placeholder="Write something into it..." >> "$filename"

# Ask the user if they want to preview the file
gum confirm "Would you preview your file?"
if [[ $? -eq 0 ]]; then
    # Display the file content using a pager if the user confirms
    gum pager < "$filename"
else
    # Exit the script if the user declines
    exit 0
fi

# Script written by the author
