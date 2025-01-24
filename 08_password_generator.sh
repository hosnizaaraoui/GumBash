#!/bin/bash

# Source the utility script containing UI helper functions
source ui_tools.sh

tput clear
banner "Password Generator:" 0

length=$(gum input --placeholder "Give Me The Password Length")

# Generate a random password
password=$(openssl rand -base64 $length)
banner "Generated password: $password" 4
# Script written by the author
