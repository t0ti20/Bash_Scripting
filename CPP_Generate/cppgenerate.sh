#!/bin/sh

############################################
#------------ Script Variables -------------
############################################
Name="Khaled El-Sayed"
Mail="@t0ti20"

############################################
#----------- Input Needed Data -------------
############################################
read -p "- Please Enter Your File Name: " File_Name
read -p "- Please Enter Your Class Name: " Class_Name
read -p "- Please Enter Your Namespace : " Namespace
read -p "- Please Enter Your Class Description : " Description

# Display entered information for confirmation
echo "\n-Name: ${Name}\n-Mail: ${Mail}\n-Class: ${Class_Name}\n-Namespace: ${Namespace}\n-Description: ${Description}\n"

# Prompt user for confirmation or modification
read -p "Do you want to generate files with the above information? (yes/no): " Confirm

if [ "$Confirm" != "yes" ]; then
    echo "Please re-run the script with the correct information."
    exit 1
fi

############################################
#-------- Start Generation Header ----------
############################################
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
/*****************************************
----------    GLOBAL DATA     ------------
*****************************************/
namespace ${Namespace}
{
class ${Class_Name}
{
public:
     ${Class_Name}();
     ~${Class_Name}();
private:

};
}
/********************************************************************
 *  END OF FILE:  ${HeaderFile}
********************************************************************/
EOL

############################################
#-------- Start Generation Program ---------
############################################
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

echo "Files generated successfully."
