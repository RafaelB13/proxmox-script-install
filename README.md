# Proxmox Installation Script

This script automates the initial configuration and installation of Proxmox VE on a Debian-based system.

## Initial Configuration

The script prompts for initial configuration settings, such as choosing an IP address and hostname for the server. If no IP address is provided, it defaults to the available IPs on the system.

## Proxmox VE Installation

The script adds the Proxmox VE repository, updates the system, and installs the Proxmox VE packages.

### Usage

1. Run the script in a terminal.
2. Follow the on-screen prompts for IP configuration and hostname.
3. The script then adds the Proxmox VE repository, updates the system, and installs Proxmox VE packages.

### Important Note

Make sure to review and customize the script according to your specific requirements before running it.

## Script Execution

```bash
./proxmox-installation-script.sh
