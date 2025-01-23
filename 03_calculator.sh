#!/bin/bash

# Source the main script to reuse defined functions and styles
source easy.sh

# Clear the terminal screen
tput clear

# Display a banner for the calculator title
banner "Buff Calculator: + - / *" 3

# Let the user choose an operation using Gum
operation=$(gum choose "Addition" "Subtraction" "Multiplication" "Division")

# Prompt the user to input two numbers
x=$(gum input --placeholder "Enter the first number: ")
y=$(gum input --placeholder "Enter the second number: ")

# Define a prefix for the result message
prefix="Result:" 

# Perform the chosen operation and display the result
case $operation in
    "Addition")
        banner "$prefix $(($x + $y))" 6
        ;;
    "Subtraction")
        banner "$prefix $(($x - $y))" 6
        ;;
    "Multiplication")
        banner "$prefix $(($x * $y))" 6
        ;;
    "Division")
        # Check for division by zero
        if [ "$y" -eq 0 ]; then
            banner "Error: Division by zero is undefined!" 1
        else
            banner "$prefix $(($x / $y))" 6
        fi
        ;;
    *)
        # Handle unexpected input
        banner "Error: Invalid operation selected!" 1
        ;;
esac
# Script written by the author
