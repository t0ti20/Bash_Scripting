#!/bin/bash
############################################
#             Configurations               #
############################################
Supported_Extensions=('txt' 'jpg' 'png' '.')
Output_File_Name="Result"
############################################
#             Main Application             #
############################################
#Get Directory
printf "Please Enter Directory : "
read Directory
#Check If The Directory Is Valid
if [ -d "${Directory}" ]
then
    # Loop On All Files In The Directory
    for File in $(ls -A "${Directory}");
    do
        # Check For Hidden File
        if [[ $File == .* ]];
        then
            mkdir -p "./${Output_File_Name}/HIDDEN"
            cp -p "${Directory}/${File}" "./${Output_File_Name}/HIDDEN"
        # File Is Not Hidden
        else
            # Initialize File Recognization Flag
            File_Recognized_Flag=0
            # Loop On Supported Extensions
            for Extention in "${Supported_Extensions[@]}";
            do
                # Check If The Current File Support The Listed Extensions
                if [[ $File == *.$Extention ]];
                then
                    #Make Directory With Extention Name
                    mkdir -p "./${Output_File_Name}/${Extention^^}"
                    #Copy File To This Directory
                    cp -p "${Directory}/${File}" "./${Output_File_Name}/${Extention^^}"
                    #File Is Recognized
                    File_Recognized_Flag=1
                    #Break From Extension Search
                    break
                fi
            done
            # Check if file was not recognized
            if [[ $File_Recognized_Flag != 1 ]];
            then
                #Make MISC Directory For Un recognized Files
                mkdir -p "./${Output_File_Name}/MISC"
                #Move File To MISC Directory
                cp -p "${Directory}/${File}" "./${Output_File_Name}/MISC"
            fi
        fi
    done
    echo "Files have been organized successfully."
    #Check For Tree Command
    if command -v tree &> /dev/null
    then
        #Display the organized directory structure
        tree -a ./${Output_File_Name}
    fi
else
    echo "Directory Invalid : ${Directory}"
fi