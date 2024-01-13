#!/bin/bash
# Prompt the user for the IP address range
read -p "Enter the network IP address range (e.g., 192.168.0.0): " Netwrk_Address
# Prompt for the success message
Success_Message="1 received"
# Validate the provided IP address
if [[ ! "$Netwrk_Address" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Invalid IP address format. Please provide an IP address in the format 'x.x.x.x'."
    exit 1
fi
# Split the IP address into an array
IFS='.'
read -a IP <<< "$Netwrk_Address"
# Iterate through the IP range and ping each IP
for Counter in {1..15}
do
    Current_IP="${IP[0]}.${IP[1]}.${IP[2]}.${Counter}"
    # Ping the IP address
    Result=$(ping "${Current_IP}" -W 1 -c 1)
    #echo ${Result}
    # Check for success
    if [[ "${Result}" == *"${Success_Message}"* ]] && [ ${?} -eq 0 ]; then
        echo "User found at IP address: ${Current_IP}"
    fi
done
echo "Scan completed."
