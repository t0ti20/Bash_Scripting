# Network Analysis Script

## Overview

This script provides functionality for capturing and analyzing network traffic using `tcpdump` and `tshark`. It includes features for generating network traffic analysis reports and capturing traffic on a specified interface.

## Configurations

The script uses several configurations, which can be modified at the beginning of the script:

- **Application Name:** The base name of the script.
- **PCAP Location:** The default location for storing packet capture files.
- **Interface:** The default network interface for traffic capture.

## Usage

### Interactive Mode

Run the script without any command-line options to enter interactive mode. This mode provides a menu-driven interface for various actions, including generating network reports, capturing traffic, and editing the PCAP file location.

```bash
./network_analysis_script.sh
```

### Command-Line Options

The script supports the following command-line options:

- `-h`: Display usage help.
- `-r`: Generate a network analysis report for a specified PCAP file.
- `-c`: Capture network traffic on a specified interface.

Example usage:

```bash
./network_analysis_script.sh -r
./network_analysis_script.sh -c
```
## Network Analysis Report

When generating a network analysis report (`-r` option), the script provides information such as total packets, protocols, and top source/destination IP addresses.

## Capture Traffic

To capture network traffic (`-c` option), the script prompts for the interface and uses `tcpdump` to save the output to a specified PCAP file.

## Editing PCAP Location

To edit the PCAP file location, choose the appropriate option in interactive mode. The script will prompt for the new PCAP file location.

## Credits

Thanks for using the Network Analysis Script!

- **Name:** Khaled El-Sayed (@t0ti20)
- **GitHub:** [https://github.com/t0ti20](https://github.com/t0ti20)
- **LinkedIn:** [https://www.linkedin.com/in/t0ti20](https://www.linkedin.com/in/t0ti20)