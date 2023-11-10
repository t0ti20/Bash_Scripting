#!/bin/bash
function Get_Adhan
{
     ####################################################
     #Set Source To Get Aladhan As JSON
     Aladhan_URL="https://api.aladhan.com/v1/timingsByCity/31-10-2023?city=Cairo&country=Arab+Rebublic+Egypt"
     #Set IMportant Keys To Filter
     Item_Needed=".data.timings"
     ####################################################
     #Fetch Data From Site
     Result=$(curl -s "$Aladhan_URL")
     ####################################################
     #Get Needed Data
     Fajr=$(jq -r "$Item_Needed.Fajr" <<< "$Result")
     Dhuhr=$(jq -r "$Item_Needed.Dhuhr" <<< "$Result")
     Asr=$(jq -r "$Item_Needed.Asr" <<< "$Result")
     Maghrib=$(jq -r "$Item_Needed.Maghrib" <<< "$Result")
     Isha=$(jq -r "$Item_Needed.Isha" <<< "$Result")
     ####################################################
     #Print Data
     echo "================================="
     echo "- Fajr At -> ${Fajr}"
     echo "- Dhuhr At -> ${Dhuhr}"
     echo "- Asr At -> ${Asr}"
     echo "- Maghrib At -> ${Maghrib}"
     echo "- Isha At -> ${Isha}"
     echo "================================="
}