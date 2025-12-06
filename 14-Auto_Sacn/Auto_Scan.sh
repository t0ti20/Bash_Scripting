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
#------------ Color Variables -------------
############################################
GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
RESET="\033[0m"

############################################
#------------ Debug Toggle ----------------
############################################
DEBUG=false

############################################
#------------ Trusted Directories ---------
############################################
# Add your trusted directories here
TRUSTED_DIRS=(
    "$HOME/Documents/Github/Bash_Scripting/"
)

############################################
#------------ Utility Functions -----------
############################################

print_header() {
    echo -e "${BLUE}=======================================================${RESET}"
    echo -e "${BLUE}$1${RESET}"
    echo -e "${BLUE}=======================================================${RESET}"
}

# Function overrides when DEBUG is false
print_info() {
    if [ "$DEBUG" = true ]; then
        echo -e "${BLUE}[INFO]${RESET} $1"
    fi
}
print_success() {
    if [ "$DEBUG" = true ]; then
        echo -e "${GREEN}[SUCCESS]${RESET} $1"
    fi
}

print_warning() {
    if [ "$DEBUG" = true ]; then
        echo -e "${YELLOW}[CHECK]${RESET} $1"
    fi
}

print_error() {
    echo -e "${RED}[ERROR]${RESET} $1"
}

print_debug() {
    if [ "$DEBUG" = true ]; then
        echo -e "${YELLOW}[DEBUG]${RESET} $1"
    fi
}

############################################
# Function: Discover and generate aliases
############################################
scan_and_alias() {
    for dir in "${TRUSTED_DIRS[@]}"; do
        if [ -d "$dir" ]; then
            print_info "Scanning directory: $dir"
            
            while IFS= read -r -d '' script; do
                filename=$(basename "$script")
                alias_name="${filename%.sh}"

                print_debug "Found script: $script"
                print_debug "Alias to create: $alias_name → $script"

                alias $alias_name="bash \"$script\""
                print_success "Alias '$alias_name' created for $script"

            done < <(find "$dir" -type f -name "*.sh" -print0)
        else
            print_warning "Trusted directory not found: $dir"
        fi
    done
}

############################################
# Script Execution
############################################
if [ "$DEBUG" = true ]; then
    print_header "AUTO SCRIPT DISCOVERY & ALIAS GENERATOR"
fi
scan_and_alias
