# Command Database Script

This script allows you to manage and execute saved commands in a simple database.

## Usage

1. Make the script executable:

    ```bash
    chmod +x your_script.sh
    ```

2. Source the script or run it directly:

    ```bash
    source your_script.sh
    ```

    ```bash
    ./your_script.sh
    ```

3. Run the script with a command to search and execute:

    ```bash
    cmd "your_command"
    ```

## Functions

### Print_All_Commands()

Prints all saved commands in the database file.

### Search_For_Command(command_name)

Searches for a specific command by name in the database.

### Check_Result()

Checks the result of the search and either executes the command or displays an error message.

## Main Application

The main application checks the command-line arguments. If no arguments are provided, it prints all saved commands. If a command name is provided, it searches for and executes the command if found.

## Database File

The script uses a file located at `~/.Command_List` to store the saved commands. Ensure this file exists and is writable.
