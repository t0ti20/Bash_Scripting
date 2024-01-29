# Yocto Flashing Script

This Bash script provides a user-friendly interface for flashing, mounting, and configuring a Yocto image on a Raspberry Pi.

## Script Variables

- **WIC_Image:** Default path to the Yocto image file.

## Usage

1. Run the script: `./Yocto_Flashing.sh`
2. Follow the on-screen prompts to perform actions such as flashing, mounting, and configuring.

## Actions

### 1. Flashing Image

- Prompts for the Yocto image file location.
- Allows editing the image file location.
- Prompts for the target device to flash.
- Flashes the Yocto image onto the specified device.

### 2. Mounting Device

- Prompts for the target device to mount.
- Creates mount points for boot and root partitions.
- Mounts the specified device partitions.

### 3. Configuring Device

- Configures the cmdline.txt and config.txt files on the boot partition.

### 4. Exit

- Exits the script.

## Notes

- Ensure you have the necessary permissions to perform the specified actions.
- Exercise caution when modifying system files.
- Make sure to review and understand the script before usage.

## Author

- Author: Khaled El-Sayed
- Email: khaled.3bdulaziz@icloud.com

Feel free to contribute or report issues on [GitHub Repository](https://github.com/t0ti20/Bash_Scripting/edit/master/04-Yocto_Flashing).

---

