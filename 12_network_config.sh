#!/bin/bash

# Source the utility script containing UI helper functions
source ui_tools.sh

# Clear the terminal screen
tput clear

# Display a banner
banner "Network Interface Configuration Tool" 0

# List available network interfaces
interfaces=$(ifconfig -s | awk '{print $1}' | tail -n+2)

# Let the user select an interface
interface=$(gum choose $interfaces --header="Select a network interface to configure")

# Display the selected interface
goto 3 0
banner "Preparing to configure interface: $interface" 2

# Prompt the user for IP address, subnet mask, and gateway
goto 6 0
ip_addr=$(gum input --placeholder="Enter the IP address (e.g., 192.168.1.10):")
subnet_mask=$(gum input --placeholder="Enter the Subnet Mask (e.g., 255.255.255.0):")
gateway=$(gum input --placeholder="Enter the Gateway address (e.g., 192.168.1.1):")

# Configure network interface
sudo ifconfig $interface $ip_addr netmask $subnet_mask up

# Check if the interface configuration succeeded
if [ $? -eq 0 ]; then
    # Ask the user to set the gateway as the default route
    gum confirm "Do you want to set $gateway as the default gateway?"

    if [[ $? -eq 0 ]]; then
        # Set default gateway
        sudo route replace default gw $gateway
    fi
else
    # Clear the screen and display a failure message
    tput clear
    goto $lines_mid 0
    banner "Error: Network configuration failed. Please check your inputs." 1
    exit 1
fi

# Clear the screen and display a success message
tput clear
goto $lines_mid 0
banner "Success: Network configuration completed successfully." 2
exit 0

# Script written by the author
