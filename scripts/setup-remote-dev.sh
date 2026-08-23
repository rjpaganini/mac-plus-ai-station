#!/bin/bash

# Tino's Computer - Remote Development Setup Script
# This script sets up SSH for remote development from a Mac to the Beelink SER8

set -e  # Exit immediately if a command exits with a non-zero status

echo "===== Tino's Computer Remote Development Setup ====="
echo "This script will help set up SSH for remote development."
echo

# Check if running on Mac
if [[ "$(uname)" != "Darwin" ]]; then
    echo "This script is designed to run on macOS. Please run it on your Mac."
    exit 1
fi

# Ask for the Beelink's IP address
echo "Enter the IP address of the Beelink SER8:"
read -r beelink_ip

# Validate IP address format
if [[ ! $beelink_ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Invalid IP address format. Please enter a valid IP address."
    exit 1
fi

# Ask for the username on the Beelink
echo "Enter the username on the Beelink SER8 (default: tinopaganini):"
read -r beelink_user
beelink_user=${beelink_user:-tinopaganini}

# Check if SSH key exists
if [ ! -f "$HOME/.ssh/id_rsa" ] && [ ! -f "$HOME/.ssh/id_ed25519" ]; then
    echo "No SSH key found. Generating a new SSH key..."
    ssh-keygen -t ed25519 -f "$HOME/.ssh/id_ed25519" -N ""
    ssh_key="$HOME/.ssh/id_ed25519.pub"
else
    # Use existing key
    if [ -f "$HOME/.ssh/id_ed25519.pub" ]; then
        ssh_key="$HOME/.ssh/id_ed25519.pub"
    else
        ssh_key="$HOME/.ssh/id_rsa.pub"
    fi
    echo "Using existing SSH key: $ssh_key"
fi

# Copy SSH key to Beelink
echo "Copying SSH key to Beelink..."
echo "You will be prompted for the password of $beelink_user on the Beelink."
ssh-copy-id -i "$ssh_key" "$beelink_user@$beelink_ip"

# Test SSH connection
echo "Testing SSH connection..."
if ssh -o BatchMode=yes "$beelink_user@$beelink_ip" "echo SSH connection successful"; then
    echo "SSH connection established successfully!"
else
    echo "SSH connection failed. Please check your credentials and try again."
    exit 1
fi

# Create SSH config entry
echo "Creating SSH config entry..."
if [ ! -d "$HOME/.ssh" ]; then
    mkdir -p "$HOME/.ssh"
    chmod 700 "$HOME/.ssh"
fi

if [ ! -f "$HOME/.ssh/config" ]; then
    touch "$HOME/.ssh/config"
    chmod 600 "$HOME/.ssh/config"
fi

# Check if config entry already exists
if grep -q "Host tinos-computer" "$HOME/.ssh/config"; then
    echo "SSH config entry already exists. Updating..."
    # Use sed to update the existing entry
    sed -i '' "/Host tinos-computer/,/^$/c\\
Host tinos-computer\\
    HostName $beelink_ip\\
    User $beelink_user\\
    IdentityFile $ssh_key\\
    ForwardX11 yes\\
    ForwardX11Trusted yes\\
    ServerAliveInterval 60\\
    ServerAliveCountMax 3\\
" "$HOME/.ssh/config"
else
    # Append new entry
    echo "
Host tinos-computer
    HostName $beelink_ip
    User $beelink_user
    IdentityFile $ssh_key
    ForwardX11 yes
    ForwardX11Trusted yes
    ServerAliveInterval 60
    ServerAliveCountMax 3
" >> "$HOME/.ssh/config"
fi

echo "SSH config entry created/updated."

# VS Code Remote-SSH setup
echo "Setting up VS Code Remote-SSH..."
if ! command -v code &> /dev/null; then
    echo "VS Code not found. Please install VS Code and the Remote-SSH extension manually."
else
    echo "Checking for Remote-SSH extension..."
    if ! code --list-extensions | grep -q "ms-vscode-remote.remote-ssh"; then
        echo "Installing Remote-SSH extension..."
        code --install-extension ms-vscode-remote.remote-ssh
    else
        echo "Remote-SSH extension already installed."
    fi
    
    echo "You can now connect to the Beelink using VS Code Remote-SSH."
    echo "In VS Code, press F1 and type 'Remote-SSH: Connect to Host...' then select 'tinos-computer'"
fi

echo
echo "===== Setup Complete ====="
echo
echo "You can now connect to the Beelink using:"
echo "ssh tinos-computer"
echo
echo "To copy files to the Beelink:"
echo "scp /path/to/local/file tinos-computer:/path/to/remote/directory/"
echo
echo "To copy files from the Beelink:"
echo "scp tinos-computer:/path/to/remote/file /path/to/local/directory/"
echo
echo "To sync the entire project directory to the Beelink:"
echo "rsync -avz --exclude 'node_modules' --exclude 'env' /path/to/tinos-computer/ tinos-computer:/home/$beelink_user/tinos-computer/"
