#!/bin/bash
############################################
#             Configurations               #
############################################
Application_Name=$(basename "$0")
Display_Count=5
Update_Interval=10
CPU_Threshold=90
MEMORY_Threshold=16
############################################
#             Configure Color              #
############################################
GREEN="0;32"
RED="1;31"
BLUE="0;34"
YELLOW="1;33"
Print()
{
    Color=$1
    Text=$2
    echo -n -e "\e[${Color}m${Text}\e[0m"
}
############################################
#                 User Help                #
############################################
Usage_Help() 
{
    Print "${GREEN}" "Usage_Help: ${Application_Name} -l -h -k -s -m -f -o -i -a\n"
    Print "${GREEN}" "----------------------------------------------------------------\n"
    echo "  -f[OPT]     Find Information About Process With [OPT]->{usr, pid, name}"
    echo "  -i[PID]     List All Information About [PID]"
    echo "  -k[PID]     Kill Specific Process By ID [PID]"
    echo "  -l          List All Running Processes."
    echo "  -m          Monitor All Running Processes."
    echo "  -s          Display Overall System Process Statistics"
    echo "  -h          Help For Valid Options."
    echo "  -o          Open Interactive Mode."
    echo "  -a          Enable Alert Mode For CPU And Memory."
    exit 1
}
############################################
#             List All Process             #
############################################
List_Process()
{
    Print "${GREEN}" "List All Process Information.\n"
    Print "${GREEN}" "-----------------------------\n"
    # Column headers
    Print "${BLUE}" "PID\tCPU%\tMemory%\tCommand\n"
    # List process information, sorted by PID
    ps aux | awk '{print $2 "\t" $3 "\t" $4 "\t" $11}' | sort -nk1
}
############################################
#            Process Informaion            #
############################################
Process_Informaion()
{
    # Check if PID is provided
    if [ -z "${OPTARG}" ]; then
        Print "${RED}" "Error: Please provide a PID to retrieve information.\n"
        return
    fi
    # Check if PID exists
    if [ ! -e "/proc/${OPTARG}" ]; then
        Print "${RED}" "Error: Process with PID ${OPTARG} does not exist.\n"
    else
        Print "${GREEN}" "List Information For Process ID -> ${OPTARG}.\n"
        Print "${GREEN}" "----------------------------------------------\n"
        # List detailed information for the specified PID
        Print "${BLUE}" "$(ps -p ${OPTARG} o pid,ppid,%cpu,%mem,user,stime,tname,time,cmd | head -n 1)\n"
        ps -p ${OPTARG} o pid,ppid,%cpu,%mem,user,stime,tname,time,cmd | tail -n 1
    fi
}
############################################
#                Kill Process              #
############################################
Kill_Process()
{
    # Check if PID is provided
    if [ -z "${OPTARG}" ]; then
        Print "${RED}" "Error: Please provide a PID to kill.\n"
        return
    fi
    # Check if PID exists
    if [ ! -e "/proc/${OPTARG}" ]; then
        Print "${RED}" "Error: Process with PID ${OPTARG} does not exist.\n"
    else
        # Confirmation prompt
        read -p "Are you sure you want to kill the process with PID ${OPTARG}? (y/n): " confirm
        case $confirm in
            [yY])
                Print "${GREEN}" "Killing Process With ID -> ${OPTARG}.\n"
                Print "${GREEN}" "----------------------------------------------\n"
                kill -SIGKILL "${OPTARG}"
                ;;
            *)
                Print "${YELLOW}" "Action canceled. Process with PID ${OPTARG} not killed.\n"
                ;;
        esac
    fi
}
############################################
#               Display Stats              #
############################################
Display_Stats() 
{
    Print "${GREEN}" "System Process Statistics:\n"
    Print "${GREEN}" "---------------------------\n"
    # Total number of processes
    Print "${YELLOW}" "- Total Number Of Processes : "
    echo "$(ps aux --no-headers | wc -l)"
    # Memory usage
    Print "${YELLOW}" "- Memory Usage : "
    echo "$(free -m | awk 'NR==2{printf "%s MB (%.2f%%)\n", $3,$3*100/$2 }')"
    # CPU load
    Print "${YELLOW}" "- CPU Load (1min/5min/15min) :"
    echo "$(uptime | awk -F'average:' '{print "" $2}')"
    # Uptime 
    Print "${YELLOW}" "- Uptime : "
    echo "$(uptime -p | sed 's/up //')"
}
############################################
#                 Monitoring               #
############################################
Monitoring()
{
    while true;
    do
        # Clear the screen before displaying updated information (cross-platform)
        clear
        # Display total number of processes
        Display_Stats
        Print "${GREEN}" "\nLatest Running Process Information :\n"
        Print "${GREEN}" "----------------------------------------------\n"
        # Display header and top 5 processes based on start time
        Print "${BLUE}" "$(ps -ef --sort=start_time | head -n 1)\n"
        ps -ef --sort=start_time | tail -n 10 | head -n "$Display_Count"
        sleep ${Update_Interval}
    done
}
############################################
#               Enable Alert               #
############################################
Alert()
{
    Print "${GREEN}" " Enabling Alerts :\n"
    Print "${GREEN}" "------------------------\n"
    Print "${YELLOW}" "- CPU Threshold = ${CPU_Threshold}\n"
    Print "${YELLOW}" "- MEMORY Threshold = ${MEMORY_Threshold}\n"
    while true
    do
        CPU_Usage=$(top -b -n 1 | awk '/^%Cpu/{print $2}' | cut -d. -f1)
        MEMORY_Usage=$(free | awk '/^Mem/{printf("%.0f", $3/$2*100)}')
        if [ "$CPU_Usage" -gt "$CPU_Threshold" ]; then
            Print "${RED}" "\nALERT: CPU usage exceeded ${CPU_Threshold}% - Current CPU Usage: ${CPU_Usage}%\n"
            # Add your alert action here
        fi
        if [ "$MEMORY_Usage" -gt "$MEMORY_Threshold" ]; then
            Print "${RED}" "\nALERT: Memory usage exceeded ${MEMORY_Threshold}% - Current Memory Usage: ${MEMORY_Usage}%\n"
            # Add your alert action here
        fi
        sleep ${Update_Interval}  # Adjust the sleep duration as needed
    done
}
############################################
#                   Find                   #
############################################
Find()
{
    Print "${GREEN}" "Searching For Process:\n"
    Print "${GREEN}" "------------------------\n"
    case ${OPTARG} in
        pid)
            read -p "Enter the process ID to search: " Value
            Find_Pid "$Value"
            ;;
        name)
            read -p "Enter the process Name to search: " Value
            Find_Name "$Value"
            ;;
        usr)
            read -p "Enter the process User to search: " Value
            Find_User "$Value"
            ;;
        *)
            Print "${RED}" "Error: Search criteria not provided.\n"
            ;;
    esac
}
Find_Pid()
{
    Value=$1
    Print "${YELLOW}" "Searching By ID for process ID = $Value ...\n"
    Result=$(ps aux | awk -v pid="$Value" '$2 == pid')
    Display_Find "$Result"
}
Find_Name()
{
    Value=$1
    Print "${YELLOW}" "Searching By Name for process Name = $Value ...\n"
    Result=$(ps aux | grep "$Value" | head -n -1)
    Display_Find "$Result"
}
Find_User()
{
    Value=$1
    Print "${YELLOW}" "Searching By User = $Value ...\n"
    Result=$(ps aux | awk -v user="$Value" '$1 == user')
    Display_Find "$Result"
}
Display_Find()
{
    Result=$1
    if [ ! -z "$Result" ]; then
        Print "${BLUE}" "$(ps aux | head -n 1)\n"
        echo "$Result"
    else
        Print "${RED}" "Error: Process Not Found.\n"
    fi
}
############################################
#             Interative Mode              #
############################################
Interactive()
{
    clear
    while true;
    do
        
        Print ${GREEN} "----------------------------\n"
        Print ${GREEN} "Please Choose An Operation :\n"
        Print ${GREEN} "----------------------------\n"
        Print ${BLUE} "1) "
        echo "Kill Specific Process By ID."
        Print ${BLUE} "2) "
        echo "List All Running Processes."
        Print ${BLUE} "3) "
        echo "Monitor Running Processes."
        Print ${BLUE} "4) "
        echo "Process ID Information."
        Print ${BLUE} "5) "
        echo "Display Statistics."
        Print ${BLUE} "6) "
        echo "Enable Alerts."
        Print ${BLUE} "7) "
        echo "Find Process."
        Print ${BLUE} "8) "
        echo "Exit."
        Print ${YELLOW} "- Enter Any Option: "
        read Option
        case ${Option} in 
            "1")
                read -p "- Enter the process ID : " OPTARG
                Kill_Process ;;
            "2")
                List_Process
            ;;
            "3") Monitoring ;;
            "4")
                read -p "- Enter the process ID : " OPTARG
                Process_Informaion ;;
            "5")
                Display_Stats ;;
            "7")
                read -p "- Find By {usr,pid,name} : " OPTARG
                Find ;;
            "6") 
                Alert & disown
                exit 0 ;;
            "8") exit 0 ;;
            *)
                Print ${RED} "Error: Invalid Option !.\n"
                sleep ${Update_Interval} ;;
        esac
        Print ${GREEN} "\n|||||||||||||||||||||||||||||||||||||||||||||||\n"
    done
}
############################################
#             Main Application             #
############################################
while getopts "ohlsamf:i:k:" Option
do
    case ${Option} in 
        l) List_Process ;;
        i) Process_Informaion ;;
        k) Kill_Process ;;
        m) Monitoring ;;
        h) Usage_Help ;;
        f) Find ;;
        a) Alert & disown ;;
        s) Display_Stats ;;
        o) Interactive ;;
        *) Usage_Help ;;
    esac
done
# Check if no options were provided
if [ $OPTIND -eq 1 ];
then
    Interactive
fi
