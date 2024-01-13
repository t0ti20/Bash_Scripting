#!/bin/bash

############################################
#------------ Script Variables -------------
############################################
Name="Khaled El-Sayed"
Mail="@t0ti20"

############################################
#----------- Set Default Values ------------
############################################
# Function to read input and set default values
Set_Default_Values() {
    File_Name="Test"
    Class_Name="Test"
    Namespace="Test"
    Description="This Is Default Test File For CPP Generator"
}

############################################
#-------- Start Generation Header ----------
############################################
Generate_Header() {
    HeaderFile="./${File_Name}.hpp"
    echo "Generating Header File: ${HeaderFile}"

    cat >"${HeaderFile}" <<EOL
/*******************************************************************
 *  FILE DESCRIPTION
-----------------------
 *  Author: ${Name} ${Mail}
 *  File: ${HeaderFile}
 *  Date: $(date +"%B %d, %Y")
 *  Description: ${Description}
 *  Class Name: ${Class_Name}
 *  (C) $(date +%Y) "${Mail}". All rights reserved.
*******************************************************************/
#ifndef _${File_Name^^}_HPP_
#define _${File_Name^^}_HPP_
/******************************************************************/
/*****************************************
----------    GLOBAL DATA     ------------
*****************************************/
namespace ${Namespace}
{
class ${Class_Name}
{
public:
$(Get_Data "public")
     ${Class_Name}();
     ~${Class_Name}();
private:
$(Get_Data "private")
protected:
$(Get_Data "protected")
};
}
/********************************************************************
 *  END OF FILE:  ${HeaderFile}
********************************************************************/
#endif
EOL
}

############################################
#----- Adding External Options To File -----
############################################
Get_Data() {
    case $1 in
    "public")
        for Attribute in "${Added_Public_Attributes[@]}"; do
            echo -e "\t$Attribute"
        done
        ;;
    "private")
        for Attribute in "${Added_Private_Attributes[@]}"; do
            echo -e "\t$Attribute"
        done
        ;;
    "protected")
        for Attribute in "${Added_Protected_Attributes[@]}"; do
            echo -e "\t$Attribute"
        done
        ;;
    *)
        echo "Invalid option."
        ;;
    esac
}

############################################
#-------- Start Generation Program ---------
############################################
Generate_Program() {
    CppFile="./${File_Name}.cpp"
    echo "Generating Program File: ${CppFile}"

    cat >"${CppFile}" <<EOL
/*******************************************************************
 *  FILE DESCRIPTION
-----------------------
 *  Author: ${Name} ${Mail}
 *  File: ${CppFile}
 *  Date: $(date +"%B %d, %Y")
 *  Description: ${Description}
 *  Class Name: ${Class_Name}
 *  (C) $(date +%Y) "${Mail}". All rights reserved.
*******************************************************************/
/*****************************************
-----------     INCLUDES     -------------
*****************************************/
#include "${File_Name}.hpp"
/*****************************************
----------    GLOBAL DATA     ------------
*****************************************/
namespace ${Namespace}
{
     ${Class_Name}::${Class_Name}()
     {

     }
     ${Class_Name}::~${Class_Name}()
     {

     }
}
/********************************************************************
 *  END OF FILE:  ${CppFile}
********************************************************************/
EOL
}

############################################
#----------- External Options --------------
############################################
Add_Attributes() {
    while true; do
        read -p "Enter attribute (<datatype> <name>): " AttributeData
        read -p "Enter attribute type (public(u)/private(v)/protected(r)): " AttributeType

        case $AttributeType in
        "R" | "r")
            Added_Protected_Attributes+=("${AttributeData};")
            ;;
        "U" | "u")
            Added_Public_Attributes+=("${AttributeData};")
            ;;
        "V" | "v")
            Added_Private_Attributes+=("${AttributeData};")
            ;;
        *)
            echo "Invalid Option! Please enter 'u' for public, 'v' for private, or 'r' for protected."
            continue
            ;;
        esac

        read -p "Do you want to add other attributes? (y/n): " AddAttribute
        if [[ "${AddAttribute}" == "n" || "${AddAttribute}" == "N" ]]; then
            break
        fi
    done
}

############################################
#--------- Adding External Option ----------
############################################
External_Options() {
    read -p "Do you want to add external options? (y/n): " ExternalOption

    if [[ "${ExternalOption}" == "y" || "${ExternalOption}" == "Y" ]]; then
        while true; do
            echo -e "1) Add Attributes.\n*) Finish."
            read -p "Select external options: " Add_Option

            case $Add_Option in
            "1")
                Add_Attributes
                ;;
            *)
                break
                ;;
            esac
        done
    fi
}

############################################
#----------- Input Needed Data -------------
############################################
# Initial input
Set_Default_Values

# Loop for user interaction
while true; do
    # Display entered information for confirmation
    echo -e "- Name: ${Name}\n- Mail: ${Mail}\n- Class: ${Class_Name}\n- Namespace: ${Namespace}\n- Description: ${Description}\n"
    # Prompt user for confirmation or modification
    read -p "Do you want to edit the above information? (y/n): " Confirm

    case $Confirm in
    "n" | "N")
        External_Options
        Generate_Header
        Generate_Program
        echo "Files generated successfully."
        exit 0
        ;;
    "y" | "Y")
        read -p "- Enter Your File Name (press Enter to keep the current value '${File_Name}'): " File_Name_Edit
        [ -n "$File_Name_Edit" ] && File_Name="$File_Name_Edit"

        read -p "- Enter Your Class Name (press Enter to keep the current value '${Class_Name}'): " Class_Name_Edit
        [ -n "$Class_Name_Edit" ] && Class_Name="$Class_Name_Edit"

        read -p "- Enter Your Namespace (press Enter to keep the current value '${Namespace}'): " Namespace_Edit
        [ -n "$Namespace_Edit" ] && Namespace="$Namespace_Edit"

        read -p "- Enter Your Class Description (press Enter to keep the current value '${Description}'): " Description_Edit
        [ -n "$Description_Edit" ] && Description="$Description_Edit"
        ;;
    *)
        echo "Invalid Option. Please enter 'y' for yes or 'n' for no."
        ;;
    esac
done
