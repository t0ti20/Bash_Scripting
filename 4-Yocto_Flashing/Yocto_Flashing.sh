#!/bin/bash
############################################
#------------ Script Variables -------------
############################################
WIC_Image="/home/t0ti20/Shared/rpi-test-image-raspberrypi4-64.wic.bz2"

############################################
#------------ Flashing Image ---------------
############################################
Do_Flash()
{
     while true; do
          echo "WIC Image: ${WIC_Image}"
          read -p "Do you want to edit the above information? (y/n): " Confirm
          case $Confirm in
          "n" | "N")
               break
               ;;
          "y" | "Y")
               read -p "Enter WIC Image Location: " WIC_Image
               ;;
          *)
               echo "Invalid Option. Please enter 'y' for yes or 'n' for no."
               ;;
          esac
     done

     echo "==================================="
     lsblk
     echo "==================================="
     read -p "Please Choose Device To Flash: " Device
     sudo mkfs -t ext4 /dev/${Device}2
     sudo mkfs -t vfat /dev/${Device}1
     bzcat "${WIC_Image}" | sudo dd of="/dev/${Device}" status=progress
     echo "Done Flashing."
     while true; do
          read -p "Do you want to mount? (y/n): " Confirm
          case $Confirm in
          "n" | "N")
               break
               ;;
          "y" | "Y")
               Do_Mount
               break
               ;;
          *)
               echo "Invalid Option. Please enter 'y' for yes or 'n' for no."
               ;;
          esac
     done

     while true; do
          read -p "Do you want to configure? (y/n): " Confirm
          case $Confirm in
          "n" | "N")
               break
               ;;
          "y" | "Y")
               Do_Configure
               break
               ;;
          *)
               echo "Invalid Option. Please enter 'y' for yes or 'n' for no."
               ;;
          esac
     done
}

############################################
#----------- Mounting Device ---------------
############################################
Do_Mount()
{
     echo "==================================="
     lsblk
     echo "==================================="
     read -p "Please Choose Device To Mount: " Device
     sudo mkdir -p /Media/USB/boot /Media/USB/root
     sudo mount -t vfat "/dev/${Device}1" /Media/USB/boot -o rw
     sudo mount "/dev/${Device}2" /Media/USB/root -o rw
     echo "==================================="
     lsblk
     echo "==================================="
     echo "Done Mounting."
}

############################################
#----------- Configuring Device ------------
############################################
Do_Configure()
{
     sudo bash -c 'echo "dwc_otg.lpm_enable=0 console=serial0,115200 console=tty1 console=ttyS0 root=/dev/sda2 rootfstype=ext4 rootwait" > /Media/USB/boot/cmdline.txt'
     sudo bash -c 'echo -e "enable_uart=1\narm_64bit=1" >> /Media/USB/boot/config.txt'
     echo "Done Configuring."
}

############################################
#----------- Main Application --------------
############################################
while true; do
     echo "==================================="
     echo "1) Flashing."
     echo "2) Mounting."
     echo "3) Configure."
     echo "4) Exit."
     read -p "- What You Want To Do? " Confirm
     case $Confirm in
     "1")
          Do_Flash
          ;;
     "2")
          Do_Mount
          ;;
     "3")
          Do_Configure
          ;;
     "4")
          break
          ;;
     *)
          echo "Invalid Option!"
          ;;
     esac
done

######################################################################
# *  END OF FILE:  Yocto Flashing
######################################################################
