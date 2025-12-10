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
#------------ Script Variables -------------
############################################
TARGET_IP=""

############################################
#------------ Utility Functions ------------
############################################

# Function to print header messages
print_header() {
    echo -e "${BLUE}=======================================================${RESET}"
    echo -e "${BLUE}$1${RESET}"
    echo -e "${BLUE}=======================================================${RESET}"
}

# Function to print informational messages
print_info() {
    echo -e "${BLUE}[INFO]${RESET} $1"
}

# Function to print success messages
print_success() {
    echo -e "${GREEN}[SUCCESS]${RESET} $1"
}

# Function to print warning messages
print_warning() {
    echo -e "${YELLOW}[CHECK]${RESET} $1"
}

# Function to print error messages
print_error() {
    echo -e "${RED}[ERROR]${RESET} $1"
}

############################################
# Function to check if IP argument is provided
############################################
check_arguments() {
    if [ -z "$1" ]; then
        print_error "No IP address provided."
        echo "Usage: $0 <ip_address>"
        exit 1
    fi
    TARGET_IP="$1"
    print_info "Target set to: $TARGET_IP"
}

############################################
# Function to check connectivity using ping
# Arguments:
#   $1 = IP address
# Notes:
#   - Sends 1 ICMP request (-c 1)
#   - If host is unreachable, exits the script
############################################
ping_host() {
    local ip="$1"
    print_warning "Testing connectivity to $ip ..."
    ping -c 1 "$ip" > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        print_error "Host $ip unreachable. Aborting scan."
        exit 1
    else
        print_success "Host $ip is reachable. Proceeding..."
    fi
}

############################################
# Function to execute Nmap scan
# Arguments:
#   $1 = IP address
# Notes:
#   -sV : Detect service versions
#   -sC : Run default NSE scripts for common checks
############################################
run_nmap_scan() {
    local ip="$1"
    print_info "Running Nmap scan on $ip ..."
    nmap -sV -sC "$ip"
    if [ $? -eq 0 ]; then
        print_success "Nmap scan completed successfully."
    else
        print_error "Nmap encountered an issue."
    fi
}

############################################
# Main workflow function
# Arguments:
#   $1 = IP address
############################################
scan_device() {
    local ip="$1"
    check_arguments "$ip"
    ping_host "$ip"
    run_nmap_scan "$ip"
}

############################################
# Script Execution
############################################
scan_device "$1"
