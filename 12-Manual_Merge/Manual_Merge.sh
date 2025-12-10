#!/bin/bash

################################################################
# ╔════════════════════════════════════════════════════════════╗
# 💼  Contact Information
# ╠════════════════════════════════════════════════════════════╣
#  Name:     Khaled El-Sayed
#  Mobile:   +20 (100) 303-1049
#  Email:    Khaled.3bdulaziz@gmail.com
#  GitHub:   https://github.com/t0ti20
#  LinkedIn: https://www.linkedin.com/in/khaled3bdulaziz/
# ╚════════════════════════════════════════════════════════════╝
################################################################

############################################
#------------ Script Variables -------------
############################################
declare -a git_dirs_global=()

reset_repos() {

    # Prompt to edit the command if requested
    read -rp $'\033[0;34mAre You Sure you want to reset all repositories? (Y/n) \033[0m' edit_choice
    if [[ "$edit_choice" == "n" ]]; then
        echo -e "\033[1;34m=======================================================\033[0m"
        return
    fi
    
    # Loop through each Git repository directory
    for gitdir in "${git_dirs_global[@]}"; do
        repo_dir=$(dirname "$gitdir")
        if ! (git -C "$repo_dir" reset --hard HEAD && git -C "$repo_dir" clean -fd); then
            echo -e "\033[31mError: Commands failed.\033[0m"
            echo -e "\033[1;34m=======================================================\033[0m"
            return
        fi
    done
    echo -e "\033[32mAll Repositories reset successfully.\033[0m"
    echo -e "\033[1;34m=======================================================\033[0m"
}

############################################
# Function to print Git repository directories with numbering
############################################
print_git_dirs() {
    # Initialize count for numbering the directories
    local count=1

    # Print header for the directory list
    echo -e "\033[1;34m=======================================================\033[0m"
    echo -e "\033[0;34m- Git repository's directory List :\033[0m"

    # Loop through each directory in the global array git_dirs_global
    for git_dir in "${git_dirs_global[@]}"; do
        # Print the directory with its corresponding number
        echo -e "\033[0;33m  [$count]\033[0m" "$git_dir"
        ((count++))  # Increment count for the next directory
    done

    # Print footer to end the directory list section
    echo -e "\033[1;34m=======================================================\033[0m"
}
############################################
# Function to recursively find and push Git repositories
############################################
find_git_repos() {
    # Recursively searches for Git repositories starting from a specified directory
    
    local dir="$1"
    local count=1  # Initialize count for numbering
    
    # Find all .git directories under the specified directory
    git_dirs=$(find -L "$dir" -name ".git" -type d)
    
    # Loop through each found .git directory
    for git_dir in $git_dirs; do
        git_dirs_global+=("$git_dir")  # Store each git directory in global array
    done 
}

############################################
# Function to recursively find and push Git repositories
############################################
find_git_repos() {
    # Recursively searches for Git repositories starting from a specified directory
    
    local dir="$1"
    local count=1  # Initialize count for numbering
    
    # Find all .git directories under the specified directory
    git_dirs=$(find -L "$dir" -name ".git" -type d)
    
    # Loop through each found .git directory
    for git_dir in $git_dirs; do
        git_dirs_global+=("$git_dir")  # Store each git directory in global array
    done 
}

############################################
# Function to execute command in each repository
############################################
execute_command_in_repos() {
    # Executes a command in each Git repository found in git_dirs_global array
    
    local force_push="$1"
    local command="$2"

    # Prompt to edit the command if requested
    read -rp $'\033[0;34mCurrent command: '"\"$command"\"$'. Do you want to edit this command? (y/N) \033[0m' edit_choice
    if [[ "$edit_choice" == "y" ]]; then
        read -rp $'\033[0;34mEnter the new command: \033[0m' command
    fi
    
    Current_Directory=$(pwd)
    # Loop through each Git repository directory
    for gitdir in "${git_dirs_global[@]}"; do
        echo -e "\033[1;34m-------------------------------------------------------\033[0m"
        repo_dir=$(dirname "$gitdir")
        echo -e "\033[1;33mCurrent repository: $repo_dir\033[0m"
        
        # Determine whether to execute the command based on user input
        if [ "$force_push" == "true" ]; then
            choice="y"
        else
            read -rp $'\033[0;34mDo you want to execute this command in this repository? (Y/n) \033[0m' choice
            # Default to "y" if user just presses Enter
            if [[ -z "$choice" ]]; then
                choice="y"
            fi
        fi
        
        # Execute the command in the repository if chosen
        
        if [ "$choice" == "y" ]; then
            cd $repo_dir && eval "$command"
            if [ $? -eq 0 ]; then
                echo -e "\e[32mSuccessfully executed command.\e[0m"
            else
                echo -e "\e[31mFailed to execute for this repository.\e[0m"
                #exit 1  # You may choose to uncomment this to exit on failure
            fi
        else
            echo "Skipping repository: $repo_dir"
        fi
        cd $Current_Directory
    done
    
    echo -e "\033[1;34m=======================================================\033[0m"
}

############################################
# Function to prompt user to ignore repositories and remove them from global array
############################################
ignore_repos() {
    # Prompt user to enter numbers corresponding to repositories to ignore
    read -p $'\033[0;34mEnter numbers corresponding to the repositories you want to ignore (e.g., 1 3 5): \033[0m' -r ignore_indices

    # Split input into an array
    IFS=' ' read -r -a ignore_array <<< "$ignore_indices"
    
    # Create a temporary array to store indices of repositories to remove
    declare -a to_remove_indices=()

    # Validate indices and add them to to_remove_indices array
    for index in "${ignore_array[@]}"; do
        if [[ "$index" =~ ^[0-9]+$ ]] && (( index >= 1 )) && (( index <= ${#git_dirs_global[@]} )); then
            to_remove_indices+=( $((index - 1)) )  # Store index to remove (adjust for zero-based index)
        else
            echo "Invalid input: $index. Skipping..."
        fi
    done

    # Create a new array to hold repositories to keep
    declare -a new_git_dirs_global=()

    # Populate new_git_dirs_global with repositories not in to_remove_indices
    for (( i=0; i<${#git_dirs_global[@]}; i++ )); do
        if [[ ! " ${to_remove_indices[@]} " =~ " $i " ]]; then
            new_git_dirs_global+=( "${git_dirs_global[i]}" )
        else
            echo "Removing repository: ${git_dirs_global[i]}"
        fi
    done

    # Update git_dirs_global with new_git_dirs_global
    git_dirs_global=("${new_git_dirs_global[@]}")
    echo -e "\033[1;34m=======================================================\033[0m"
}

############################################
# Function to monitor Git repositories for updates
############################################
git_monitor_updates() {
    # Initialize count for numbering repositories
    local count=0
    declare -a new_git_dirs_global=()  # Array to hold repositories with updates
    current_location=$(pwd)  # Store current directory location

    # Iterate through each Git repository directory in git_dirs_global
    for gitdir in "${git_dirs_global[@]}"; do
        repo_dir=$(dirname "$gitdir")
        cd "$current_location/$repo_dir"

        # Check if there are any unstaged changes or untracked files
        if [[ -n $(git status --porcelain) ]]; then
            new_git_dirs_global+=( "${git_dirs_global[count]}" )  # Add repository with updates to new array
        fi

        ((count++))  # Increment count for next repository
    done

    cd "$current_location"  # Return to the original directory
    git_dirs_global=("${new_git_dirs_global[@]}")  # Update git_dirs_global with repositories that have updates
    echo -e "\033[1;34m=======================================================\033[0m"
}

############################################
# Function to list unstaged and untracked files in Git repositories
############################################
git_list_files() {
    # Iterate through each Git repository directory in git_dirs_global
    for gitdir in "${git_dirs_global[@]}"; do
        repo_dir=$(dirname "$gitdir")

        # List unstaged changes (modified files)
        git -C "$repo_dir" diff --name-only | while read filename; do
            echo -e "\033[1;33m[M] \033[0m""$repo_dir/$filename"
        done

        # List untracked files
        git -C "$repo_dir" ls-files --others --exclude-standard | while read filename; do
            echo -e "\033[0;32m[A] \033[0m""$repo_dir/$filename"
        done
    done

    echo -e "\033[1;34m=======================================================\033[0m"
}

############################################
# Function to export unstaged and untracked files from Git repositories
############################################
git_export_files() {
    # Check if 'Changes' directory exists and delete it if it does
    if [ -d "./Changes" ]; then
        rm -rf "./Changes"
    fi

    # Create the 'Changes' directory
    mkdir -p "./Changes"

    # Iterate through each Git repository directory in git_dirs_global
    for gitdir in "${git_dirs_global[@]}"; do

        repo_dir=$(realpath "$(dirname "$gitdir")")
        relative_repo_path=$(basename "$repo_dir")

        # Check if there are any unstaged changes or untracked files
        changed_files=$(git -C "$repo_dir" diff --name-only)
        untracked_files=$(git -C "$repo_dir" ls-files --others --exclude-standard)

        # Loop through changed files
        IFS=$'\n' # Set IFS to newline to properly handle spaces in filenames
        for file in $changed_files; do
            target_dir="./Changes/$(dirname "$gitdir")/$(dirname "$file")"
            mkdir -p "$target_dir"
            cp "$repo_dir/$file" "$target_dir"
        done

        # Loop through untracked files
        for file in $untracked_files; do
            target_dir="./Changes/$(dirname "$gitdir")/$(dirname "$file")"
            mkdir -p "$target_dir"
            cp "$repo_dir/$file" "$target_dir"
        done
    done
    echo -e "\033[0;32mDone Exporting Changed Files In :\033[0m"" ./Changes"
    echo -e "\033[1;34m=======================================================\033[0m"
}


############################################
# Function to manage Git repositories with various operations
############################################
push_git_repos() {
    local dir="$1"
    local force_push="$2"
    local command="$3"

    # Find all Git repositories in the specified directory
    find_git_repos "$dir"

    # Main menu loop
    while true; do
        clear  # Clear the terminal screen
        print_git_dirs  # Display the list of Git repositories

        # Display menu options
        echo -e "\033[0;34mPlease choose an option:\033[0m"
        echo -e "\033[0;33m  1 - \033[0m""Ignore Some Repositories."
        echo -e "\033[0;33m  2 - \033[0m""Update Repositories List With Changed Ones Only."
        echo -e "\033[0;33m  3 - \033[0m""Execute Command."
        echo -e "\033[0;33m  4 - \033[0m""Reset Repositories."
        echo -e "\033[0;33m  5 - \033[0m""List Changed Files."
        echo -e "\033[0;33m  6 - \033[0m""Export Changed Files."
        echo -e "\033[0;33m  q - \033[0m""Quit"

        # Read user input
        read -rp $'\033[0;34mEnter your choice: \033[0m' choice

        # Process user choice
        case "$choice" in
            1) 
                ignore_repos  # Ignore some repositories
                read -r  # Wait for user to press Enter
                ;;
            2) 
                git_monitor_updates  # Update changed repositories
                read -r  # Wait for user to press Enter
                ;;
            3) 
                execute_command_in_repos "$force_push" "$command"  # Execute the specified command
                read -r  # Wait for user to press Enter
                ;;
            4) 
                reset_repos  # List changed files
                read -r  # Wait for user to press Enter
                ;;
            5) 
                git_list_files  # List changed files
                read -r  # Wait for user to press Enter
                ;;
            6) 
                git_export_files  # Export changed files
                read -r  # Wait for user to press Enter
                ;;
            q|Q) 
                echo "Quitting ...."  # Quit the menu
                read -r  # Wait for user to press Enter
                break  # Exit the loop
                ;;
            *) 
                echo -e "\e[31m- Invalid choice. Please choose a valid option.\e[0m"  # Invalid choice message
                read -r  # Wait for user to press Enter
                ;;
        esac
    done

    clear  # Clear the terminal screen before exiting
}

############################################
# Script to manage Git repositories with various operations
############################################

# Check if at least one directory is provided
if [ $# -lt 1 ]; then
    echo "Usage: $0 <base_directory> [-f]"
    exit 1
fi

# Check for the -f flag indicating a forced push
force_push="false"
for arg in "$@"; do
    if [ "$arg" == "-f" ]; then
        force_push="true"
        break
    fi
done

# Call the push_git_repos function with the provided directory and force push flag
push_git_repos "$1" "$force_push" "git status"
