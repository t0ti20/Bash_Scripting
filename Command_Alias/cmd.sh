#!/bin/sh
############################################
#------------ Create Data-Base -------------
############################################
List=~/.Command_List
Command=''
############################################
#------- Print All Saved Commands ----------
############################################
Print_All_Commands()
{
     echo "- Your Saved Commands : "
     cat "${List}"
}
############################################
#---------- Search For Command ------------
############################################
Search_For_Command()
{
     local command_name="$1"
     while read -r Line
     do
          Command=$(echo "${Line}" | grep "^${command_name}=" | cut -d '=' -f 2) 
          if [ -n "${Command}" ]
          then 
               break
          fi
     done < "${List}"
}
############################################
#---------- Check Search Result ------------
############################################
Check_Result()
{
     if [ -n "${Command}" ]
     then
          echo "Executing command: ${Command}"
          ${Command} 
     else
          echo "Command not found: $1"
          Print_All_Commands
     fi
}
############################################
#------------ Main Application -------------
############################################
if [ $# -eq 0 ]
then
     Print_All_Commands
else 
     Search_For_Command "$1"
     Check_Result
fi
