#!/bin/bash

# Tino's Computer - Systemd Service Installation Script
# This script installs the systemd service for auto-starting the UI

set -e  # Exit immediately if a command exits with a non-zero status

echo "===== Tino's Computer Systemd Service Installation ====="
echo "This script will install the systemd service for auto-starting the UI."
echo

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root or with sudo."
  exit 1
fi

# Get the directory of the script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

# Copy the service file to the systemd directory
echo "Copying service file to /etc/systemd/system/..."
cp "$PROJECT_DIR/systemd/tinos-computer.service" /etc/systemd/system/

# Reload systemd to recognize the new service
echo "Reloading systemd..."
systemctl daemon-reload

# Enable the service to start at boot
echo "Enabling service to start at boot..."
systemctl enable tinos-computer.service

# Ask if the user wants to start the service now
echo
echo "Do you want to start the service now? (y/n)"
read -r response
if [[ "$response" == "y" ]]; then
    echo "Starting service..."
    systemctl start tinos-computer.service
    echo "Service status:"
    systemctl status tinos-computer.service
else
    echo "Service installation complete. You can start it manually with:"
    echo "sudo systemctl start tinos-computer.service"
fi

echo
echo "===== Installation Complete ====="
echo
echo "To check the service status:"
echo "sudo systemctl status tinos-computer.service"
echo
echo "To stop the service:"
echo "sudo systemctl stop tinos-computer.service"
echo
echo "To disable the service from starting at boot:"
echo "sudo systemctl disable tinos-computer.service"
echo
echo "To view logs:"
echo "sudo journalctl -u tinos-computer.service"
