#!/bin/bash
function Compare_Files
{
     read -p "Enter Location Of First File : " File_1
     read -p "Enter Location Of Second File : " File_2
     IFS=' '
     read -ra Result_1 <<< `md5sum "${File_1}"`
     read -ra Result_2 <<< `md5sum "${File_2}"`
     if [ ${Result_1[0]} = ${Result_2[0]} ]
     then
     echo "Two Files Are The Same ..."
     else
     echo "Two Files Are Not The Same ..."
     fi
}