#!/bin/bash

################################################################
# ╔════════════════════════════════════════════════════════════╗
# 💼  Contact Information
# ╠════════════════════════════════════════════════════════════╣
#  Name:     Khaled El-Sayed
#  Mobile:   +20 (100) 303-1049
#  Email:    Khaled.3bdulaziz@gmail.com
#  GitHub:   https://github.com/t0ti20
#  LinkedIn: https://www.linkedin.com/in/khaled3bdulaziz/
# ╚════════════════════════════════════════════════════════════╝
################################################################

############################################
#------------ Script Variables -------------
############################################

# Path to SSH configuration file
CONFIG="$HOME/.ssh/config"

# Extract all defined SSH hosts (excluding wildcard entries)
HOSTS=($(grep -E '^Host ' "$CONFIG" | awk '{for (i=2; i<=NF; i++) if ($i != "*") print $i}'))

# Exit if no hosts are found
if [ ${#HOSTS[@]} -eq 0 ]; then
    echo "No hosts found in $CONFIG"
    exit 1
fi

# Terminal color codes for better visual output
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
CYAN=$(tput setaf 6)
RESET=$(tput sgr0)
BOLD=$(tput bold)

# Menu navigation variables
selected=0   # Currently highlighted host index

# Hide the terminal cursor during menu navigation
tput civis


############################################
#------------ Menu Drawing Logic -----------
############################################
draw_menu() {
    # Clear the screen before drawing the menu
    clear

    # Print header
    echo "${YELLOW}=================================================================${RESET}"
    echo "${BOLD}${CYAN}Select an SSH Host:${RESET}"

    # Iterate through all available hosts and highlight the selected one
    for i in "${!HOSTS[@]}"; do
        if [ $i -eq $selected ]; then
            # Highlighted (selected) host
            echo " ${GREEN}> ${BOLD}${HOSTS[$i]}${RESET}"
        else
            # Normal host entry
            echo "   ${HOSTS[$i]}"
        fi
    done

    # Print footer
    echo "${YELLOW}=================================================================${RESET}"
}


############################################
#----------- Main Menu Loop ----------------
############################################
while true; do
    # Draw the host selection menu
    draw_menu

    # Read a single key press without echoing it to the terminal
    read -rsn1 key

    case "$key" in
        $'\x1b') # Detect arrow keys (escape sequences)
            read -rsn2 -t 0.1 key2
            case "$key2" in
                '[A') # Arrow Up - Move selection up
                    ((selected--))
                    ((selected<0)) && selected=$((${#HOSTS[@]}-1))
                    ;;
                '[B') # Arrow Down - Move selection down
                    ((selected++))
                    ((selected>=${#HOSTS[@]})) && selected=0
                    ;;
            esac
            ;;
        "") # Enter key - Connect to selected host
            tput cnorm
            echo "${GREEN}Connecting to ${HOSTS[$selected]}...${RESET}"
            echo "${YELLOW}=================================================================${RESET}"
            ssh "${HOSTS[$selected]}"
            exit 0
            ;;
        q) # Quit - Exit the script
            clear
            tput cnorm
            exit 0
            ;;
    esac
done
