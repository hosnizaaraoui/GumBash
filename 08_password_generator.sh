#!/bin/bash

# Source the easy.sh script to use the defined functions and styles
source easy.sh

tput clear
banner "Password Generator:" 0

length=$(gum input --placeholder "Give Me The Password Length")

# Generate a random password
password=$(openssl rand -base64 $length)
banner "Generated password: $password" 4
# Script written by the author
