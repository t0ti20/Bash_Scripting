#!/bin/bash
############################################
#------------ Create Data-Base -------------
############################################
FILE="$HOME/.Tasks_Data"
#Finished Tasks Sign
Finished_Sign=🗸
# Check File Exists And If Not Create Tt
[[ ! -f "$FILE" ]] && touch "$FILE"
# ANSI Color Codes
Color_Green='\033[0;32m'
Color_Yellow='\033[0;33m'
Color_Red='\033[0;31m'
Color_None='\033[0m'
############################################
#---------- Validate Date Format -----------
############################################
function Date_Validation()
{
    local Date="$1"
    date "+%d/%m/%Y" -d "$Date" > /dev/null 2>&1
    return $?
}
############################################
#---------- Update Tasks Number ------------
############################################
function Update_Task_Numbers 
{
    awk -i inplace -F, -v OFS=, '{$1=NR; print}' "$FILE"
}
############################################
#----------- Display All Tasks -------------
############################################
function Display_Tasks 
{
    echo "========================================="
    #Check If List Is Empty
    if [[ ! -s "$FILE" ]];
    then
        echo "There Are No Tasks"
    else
        echo -e "No.\tStatus\tTitle\t\tDate"
        #Loop On Every Line In File Print Task Data
        while IFS=, read -r Number Title Date Status
        do
            #Set Default Color To Yellow
            color=$Color_Yellow
            #Check If It Is Finished Change Color
            [[ "$Status" == "$Finished_Sign" ]] && color=$Color_Green
            #Print Task Data and Increment Counter
            echo -e "$color$Number.\t[$Status]\t$Title\t\t$Date$Color_None";
        done < "$FILE"
    fi
    echo "========================================="
}
############################################
#----------- Add Task To List --------------
############################################
function Add_Task 
{
    local Task_Number=$(( $(wc -l < "$FILE") + 1 ))
    read -p "Enter The Task Title To Add: " Title
    read -p "Enter The Due Date: " Date
    echo "$Task_Number,$Title,$Date," >> "$FILE"
}
############################################
#-------- Mark Task As Completed -----------
############################################
function Mark_As_Complete 
{
    #Get Task Title To Mark
    read -p "Enter Task Number To Mark: " Task_Number
    #Check If Task Is In The File
    grep -q "^$Task_Number," "$FILE"
    #Check For Last Operation
    if [ $? -eq 0 ];
    then
        #Search And Edit In Data-Base
        sed -i "/^$Task_Number,/s/, *$/,$Finished_Sign/" "$FILE"
    else
        # If Task Not Found Print Error
        echo -e "${Color_Red}Task Not Found!${Color_None}"
        sleep 1
    fi
}
############################################
#--------- Remove Task From List -----------
############################################
function Remove_Task 
{
    read -p "Enter The Task Number To Remove: " Task_Title
    #Check If Task Is In The File
    grep -q "^$Task_Title," "$FILE"
    #Check For Last Operation
    if [ $? -eq 0 ];
    then
        #Search And Edit In Data-Base
        sed -i "/^$Task_Title,/d" "$FILE"
        Update_Task_Numbers
    else
        # If Task Not Found Print Error
        echo -e "${Color_Red}Task Not Found!${Color_None}"
        sleep 1
    fi
}
############################################
#------------ Main Application -------------
############################################
while true;
do
    #Clear The Screen
    clear
    #Display All Tasks Stored
    Display_Tasks
    #User Message Options
    printf "Choose An Action:\n1. Add Task\n2. Mark Task As Completed\n3. Remove task\n4. Exit\n"
    #Read Choice
    read -p "Your choice: " Choice
    case $Choice
    in
        1)Add_Task;;
        2)Mark_As_Complete;;
        3)Remove_Task;;
        4)echo "Exiting...";exit 0;;
        *)echo -e "${Color_Red}Invalid Option!${Color_None}";sleep 1;;
    esac
done
