# File Organizer

The File Organizer is a Bash script that allows you to automatically organize files in a specified directory based on their file types into separate subdirectories. This helps in keeping your directories clean and tidy by sorting files into appropriate categories.

![Screenshot 2023-09-13 155310](https://github.com/t0ti20/Embedded_Linux/assets/61616031/5b4cabac-40a3-420d-98fc-8035b151bd18)

## Features

- Organizes files based on their file extensions into separate subdirectories.
- Creates subdirectories for each file type.
- Handles files with unknown or no file extensions.
- Moves files into existing subdirectories if they already exist.
- Supports organizing hidden files (those starting with a dot).

## Usage

1. Run the script and provide the directory path as an argument:
   ./file_organizer.sh <directory-path>  Replace `<directory-path>` with the path to the directory you want to organize.

2. The script will organize the files in the specified directory based on their file types into separate subdirectories. The organized files will be placed in a directory called "Result" within the current directory.

3. If the `tree` command is available, the script will display the organized directory structure using the `tree` command.

## Example

Suppose you have a directory called "Downloads" with the following files:

```
file1.txt
file2.jpg
file3.pdf
file5_without_extension
file6.unknown
```

Running the script on the "Downloads" directory will result in the following directory structure:

```
Downloads/
|-- txt/
|   |-- file1.txt
|-- jpg/
|   |-- file2.jpg
|-- pdf/
|   |-- file3.pdf
|-- misc/
|   |-- file5_without_extension
|   |-- file6.unknown
```

## Contributing

Contributions to the File Organizer project are always welcome! If you find any issues or want to add new features, please feel free to open an issue or submit a pull request.

