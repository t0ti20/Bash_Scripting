# Process Monitor Script (Process_Monitor.sh)

## Overview

The `Process_Monitor.sh` script is a versatile and interactive tool designed for monitoring and managing processes on a Linux system. It provides various functionalities such as listing running processes, displaying system statistics, killing specific processes, enabling alert mode for CPU and memory, and more.

## Features

### 1. List All Processes

```BASH
./Process_Monitor.sh -l
```

This option lists detailed information about all running processes, including PID, CPU usage, memory usage, and command.

### 2. Process Information

```BASH
./Process_Monitor.sh -i [PID]`
```

Displays detailed information about a specific process identified by its Process ID (PID). This includes PID, parent PID, CPU usage, memory usage, user, start time, thread name, time, and command.

### 3. Kill Process

```BASH
./Process_Monitor.sh -k [PID]`
```

Allows you to kill a specific process by entering its PID. A confirmation prompt ensures you don't accidentally terminate a process.

### 4. Display System Statistics

```BASH
./Process_Monitor.sh -s
```

Shows system-wide process statistics, including the total number of processes, memory usage, CPU load, and system uptime.

### 5. Monitor Processes in Real-Time

```BASH
./Process_Monitor.sh -m
```

Continuously monitors and displays information about running processes in real-time. It updates every specified interval (default: 10 seconds).

### 6. Enable Alert Mode

```BASH
./Process_Monitor.sh -a
```

Enables alert mode for CPU and memory usage. If thresholds are exceeded, an alert message is displayed. This runs continuously in the background.

### 7. Search and Filter Processes

```BASH
./Process_Monitor.sh -f [OPT]
```

Search for processes based on specific criteria: user (`usr`), process ID (`pid`), or process name (`name`).

### 8. Interactive Mode

```BASH
./Process_Monitor.sh -o
```

Opens an interactive menu allowing you to choose various operations in a user-friendly, menu-driven interface. Simply enter the corresponding option number to perform the desired operation. The menu will continue to be displayed until you choose the "Exit" option.

The interactive mode includes the following operations:

1. **Kill Specific Process By ID**
    - Enter the process ID to terminate the specified process.
2. **List All Running Processes**
    - Display detailed information about all running processes.
3. **Monitor Running Processes**
    - Continuously monitor and display information about running processes in real-time. Updates occur every specified interval (default: 10 seconds).
4. **Process ID Information**
    - Retrieve detailed information about a specific process identified by its Process ID (PID).
5. **Display Statistics**
    - Show system-wide process statistics, including the total number of processes, memory usage, CPU load, and system uptime.
6. **Enable Alerts**
    - Activate alert mode for CPU and memory usage. If thresholds are exceeded, an alert message is displayed. This runs continuously in the background.
7. **Find Process**
    - Search and filter processes based on specific criteria such as user, process ID, or process name.
8. **Exit**
    - Terminate the script and exit the interactive mode.

### 9. Help

```BASH
./Process_Monitor.sh -h
```

Displays a help message providing information about valid options and their usage.

## Usage

1. Clone the repository or download the `Process_Monitor.sh` script.

3. Grant execute permissions:

```BASH
chmod +x Process_Monitor.sh
```

3. Run the script with desired options:

```BASH
./Process_Monitor.sh -l
```

4. Follow the on-screen instructions for interactive options.

## Dependencies

- This script is designed for Linux systems and may not work on other platforms.