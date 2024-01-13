#!/bin/bash
############################################
#             Configurations               #
############################################
PCAP_Location="$(pwd)/Test.pcap"
Interface="eth0"
readonly Application_Name=$(basename "$0")
readonly Update_Interval=2
############################################
#            Common Configure              #
############################################
readonly GREEN="0;32"
readonly RED="1;31"
readonly BLUE="0;34"
readonly YELLOW="1;33"
Log_Message()
{
    logger -t "${Application_Name}" "$1"
}
Print()
{
    Color=$1
    Text=$2
    echo -n -e "\e[${Color}m${Text}\e[0m"
}
My_Message()
{
    Print "${GREEN}" "\nThanks for using my App!\n"
    Print "${BLUE}" "+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+\n"
    Print "${BLUE}" "+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+\n"
    Print "${YELLOW}" "Name     : "
    echo "Khaled El-Sayed (@t0ti20)"
    Print "${YELLOW}" "GitHub   : "
    echo "https://github.com/t0ti20"
    Print "${YELLOW}" "LinkedIn : "
    echo "https://www.linkedin.com/in/t0ti20"
    Print "${BLUE}" "+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+\n"
    Print "${BLUE}" "+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+\n"
}
trap My_Message EXIT
############################################
#                 User Help                #
############################################
Usage_Help() 
{
    Print "${GREEN}" "Usage_Help: ${Application_Name} -h -r -c\n"
    Print "${GREEN}" "----------------------------------------------------------------\n"
    echo "  -h          Get Help Usage Of Application"
    echo "  -r          Generate Report For PCAP File."
    echo "  -c          Capture Traffic For Specific Interface."
    exit 1
}
############################################
#              Generate Report             #
############################################
Generate_Report() 
{
    Log_Message "Generating Network Report For $PCAP_Location."
    Print "${GREEN}" "Generating report for : $PCAP_Location\n"
    Print "${YELLOW}" "1) Total packets : "
    echo "$(tshark -r $PCAP_Location -n | wc -l)"
    Print "${YELLOW}" "2) Protocols : \n"
    echo "  - HTTP: "$(tshark -r $PCAP_Location -Y "http" | wc -l)""
    echo "  - HTTPS/TLS: "$(tshark -r $PCAP_Location -Y "tls.handshake.type == 1" | wc -l)""
    Print "${YELLOW}" "3) Top 5 Source IP Addresses : \n"
    echo "$(tshark -r $PCAP_Location -T fields -e ip.src | sort | uniq -c | sort -nr | awk 'NR>1 {printf "  - Source %-15s \tTotal Packets: %s\n", $2, $1}')"
    Print "${YELLOW}" "4) Top 5 Destination IP Addresses : \n"
    echo "$(tshark -r $PCAP_Location -T fields -e ip.dst | sort | uniq -c | sort -nr | awk 'NR>1 {printf "  - Source %-15s \tTotal Packets: %s\n", $2, $1}')"
}
############################################
#             Edit PCAP Location           #
############################################
Edit_Location() 
{
    Log_Message "Edit Location Of PCAP File ."
    while true
    do
        Print "${GREEN}" "Please enter new PCAP file location : "
        read PCAP_Location
        if [[ "$PCAP_Location" == *.pcap ]] && [[ -f "$PCAP_Location" ]]
        then
            break
        else
            Print "${RED}" "File {.pcap} not found !\n"
        fi
    done
}
############################################
#               Capture Traffic            #
############################################
Capture_Traffic()
{
    Log_Message "Start Captureing Traffic ."
    Print "${GREEN}" "Enter the interface to capture traffic (e.g., eth0) : "
    read Interface
    Print "${GREEN}" "Capturing network traffic on interface $Interface. Press Ctrl+C to stop the capture.\n"
    sudo tcpdump -i "$Interface" -w "$PCAP_Location"
    Print "${GREEN}" "Capture complete. Output saved to $PCAP_Location.\n"
}
############################################
#             Interative Mode              #
############################################
Interactive()
{
    Log_Message "Start Running $Application_Name Application ."
    clear
    while true;
    do
        Print ${GREEN} "------------------------------------\n"
        Print ${GREEN} "Welcome To Network Analysis Script :\n"
        Print ${GREEN} "------------------------------------\n"
        Print ${BLUE} "- {PCAP} file location in : "
        echo ${PCAP_Location}
        Print ${GREEN} "------------------------------------\n"
        Print ${BLUE} "1) "
        echo "Network Traffic Analysis Report."
        Print ${BLUE} "2) "
        echo "Start Capture Traffic."
        Print ${BLUE} "3) "
        echo "Edit PCAP location."
        Print ${BLUE} "4) "
        echo "Usage Help ."
        Print ${BLUE} "5) "
        echo "Exit."
        Print ${YELLOW} "- Enter any option: "
        read Option
        case ${Option} in 
            "1")
                Generate_Report
            ;;
            "2")
                Capture_Traffic
            ;;
            "3")
                Edit_Location
            ;;
            "4")
                Usage_Help
            ;;
            "5") exit 0 ;;
            *)
                Print "${RED}" "Error: Invalid Option!\n"
                sleep ${Update_Interval} ;;
        esac
        Print ${GREEN} "||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||\n"
    done
}
############################################
#             Main Application             #
############################################
while getopts "hrc" Option
do
    case ${Option} in 
        h) Usage_Help ;;
        r) 
            Edit_Location 
            Generate_Report  
        ;;
        c) 
            Edit_Location
            Capture_Traffic 
        ;;
        *) Usage_Help ;;
    esac
done
# Check if no options were provided
if [ $OPTIND -eq 1 ];
then
    Interactive
fi
