#!/bin/bash

# Source the utility script containing UI helper functions
source ui_tools.sh

# Function to randomly choose a number within the given range
choose_number() {
    # Generate a random number between 1 and the specified max
    local number=$((RANDOM % $1 + 1))
    echo $number
}

# Function to ask the user if they want to play again
play_again() {
    # Prompt the user with a confirmation dialog using Gum
    action=$(gum confirm "Would you like to play again?")

    # Exit if the user chooses "No"
    if [[ $? -eq 1 ]]; then
        exit 0
    fi
}

# Main game loop
while true; do
    tput clear # Clear the terminal screen
    game_title="GUESS GAME"
    banner "$game_title" 5 # Display the banner with the game title

    goto 4 2 # Move cursor to position for the max number input prompt
    max_value=$(gum input --placeholder "Set the maximum number: ")

    # Validate the max value input to ensure it's a number
    if ! [[ "$max_value" =~ ^[0-9]+$ ]]; then
        banner "Please enter a valid number." 1 # Show error banner if input is invalid
        continue
    fi

    loading "Choosing a number..." .5         # Display loading message with a slight delay
    chosen_number=$(choose_number $max_value) # Select a random number within the max value
    tries=3                                   # Set the number of tries
    won=false                                 # Set win condition to false initially

    # Game loop for the guessing attempts
    while [[ $tries -gt 0 ]]; do
        goto 6 2 # Move cursor to position for the user guess input
        guess=$(gum input --placeholder "$tries Try(s) left...")

        # Validate the guess input to ensure it's a number
        if ! [[ "$guess" =~ ^[0-9]+$ ]]; then
            banner "Please enter a valid number." 1 # Show error banner if input is invalid
            continue
        fi

        tries=$((tries - 1)) # Decrease remaining tries by 1

        # Check if the guess is correct
        if [[ $guess -eq $chosen_number ]]; then
            banner "You guessed it!" 2 # Display success message
            won=true
            break
        # Check if the guess is too high
        elif [[ $guess -gt $chosen_number ]]; then
            goto 0 0
            banner "$game_title: Guess smaller!" 3 # Hint for a smaller number
        # Check if the guess is too low
        elif [[ $guess -lt $chosen_number ]]; then
            goto 0 0
            banner "$game_title: Guess bigger!" 4 # Hint for a larger number
        fi
    done

    # End game check: if no tries left and the player hasn't won
    if [[ $tries -eq 0 ]] && [[ $won == false ]]; then
        goto 0 0
        banner ">> You lost! The correct number was $chosen_number << " 1 # Show losing message
    fi

    goto $lines_mid 0 # Move cursor to the middle of the screen
    play_again        # Prompt the user to play again
done

# Script written by the author
