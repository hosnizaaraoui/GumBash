#!/bin/bash

# Source the utility script containing UI helper functions
source ui_tools.sh

# Clear the terminal screen
tput clear

# Display a banner
banner "File Backup: " 0

backup_dir=$(gum input --placeholder="/path/to/backup")
source_dir=$(gum input --placeholder="/path/to/source")

# Create a timestamped backup of the source directory
gum spin --title "Making Backup..." -- tar -czf "$backup_dir/backup_$(date +%Y%m%d_%H%M%S).tar.gz" "$source_dir"

banner "Backup done!" 2
# Script written by the author
