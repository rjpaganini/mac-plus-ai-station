#!/bin/bash

# Tino's Computer - Development Environment Setup Script
# This script sets up the development environment for Tino's Computer project

set -e  # Exit immediately if a command exits with a non-zero status

echo "===== Tino's Computer Development Environment Setup ====="
echo "This script will install necessary dependencies and configure the environment."
echo

# Check if running as root
if [ "$EUID" -eq 0 ]; then
  echo "Please do not run this script as root or with sudo."
  exit 1
fi

# Detect OS
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
else
    echo "Cannot detect operating system. This script is designed for Ubuntu."
    exit 1
fi

echo "Detected OS: $OS $VER"

if [[ "$OS" != *"Ubuntu"* ]]; then
    echo "This script is designed for Ubuntu. Your OS is $OS."
    echo "The script may not work correctly. Do you want to continue? (y/n)"
    read -r response
    if [[ "$response" != "y" ]]; then
        echo "Setup cancelled."
        exit 1
    fi
fi

# Update package lists
echo
echo "Updating package lists..."
sudo apt update

# Install common dependencies
echo
echo "Installing common dependencies..."
sudo apt install -y git curl wget build-essential python3-pip python3-venv

# Create Python virtual environment
echo
echo "Setting up Python virtual environment..."
python3 -m venv env
source env/bin/activate
pip install --upgrade pip setuptools wheel

# Ask which UI framework to use
echo
echo "Which UI framework would you like to use?"
echo "1) Electron.js (HTML/CSS/JavaScript)"
echo "2) PyQt5 (Python)"
echo "3) Kivy (Python)"
read -r ui_choice

case $ui_choice in
    1)
        echo
        echo "Setting up Electron.js environment..."
        # Check if Node.js is installed
        if ! command -v node &> /dev/null; then
            echo "Installing Node.js..."
            curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
            sudo apt install -y nodejs
        fi
        
        # Install Electron globally
        echo "Installing Electron..."
        sudo npm install -g electron electron-builder
        
        # Create package.json if it doesn't exist
        if [ ! -f "../ui/package.json" ]; then
            echo "Creating package.json in ui directory..."
            mkdir -p ../ui
            cd ../ui
            npm init -y
            npm install --save electron electron-builder react react-dom
            cd ../scripts
        fi
        ;;
    2)
        echo
        echo "Setting up PyQt5 environment..."
        sudo apt install -y python3-pyqt5 python3-pyqt5.qtwebengine python3-pyqt5.qtmultimedia
        pip install PyQt5 PyQt5-Qt5 PyQt5-sip
        ;;
    3)
        echo
        echo "Setting up Kivy environment..."
        sudo apt install -y python3-kivy
        pip install kivy[base] kivy_examples
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

# Install VS Code Server for Remote-SSH (if not already installed)
echo
echo "Checking for VS Code Server..."
if [ ! -d "$HOME/.vscode-server" ]; then
    echo "VS Code Server will be installed automatically when you connect via Remote-SSH from your Mac."
    echo "Make sure to install the Remote-SSH extension in VS Code on your Mac."
else
    echo "VS Code Server is already installed."
fi

# Create a sample README in the ui directory
echo
echo "Creating sample README in ui directory..."
mkdir -p ../ui
cat > ../ui/README.md << EOL
# Tino's Computer UI

This directory contains the user interface code for Tino's Computer.

## Getting Started

Follow the setup instructions in the main repository README.

## Structure

- \`src/\` - Source code
- \`assets/\` - UI-specific assets
- \`components/\` - Reusable UI components

## Development

Instructions for development will depend on the chosen UI framework.
EOL

# Create a sample systemd service file
echo
echo "Creating sample systemd service file..."
mkdir -p ../systemd
cat > ../systemd/tinos-computer.service << EOL
[Unit]
Description=Tino's Computer UI
After=network.target

[Service]
Type=simple
User=tinopaganini
WorkingDirectory=/home/tinopaganini/tinos-computer/ui
ExecStart=/bin/bash -c 'cd /home/tinopaganini/tinos-computer && ./scripts/start-ui.sh'
Restart=on-failure
RestartSec=5
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=tinos-computer

[Install]
WantedBy=multi-user.target
EOL

# Create a start script
echo
echo "Creating UI start script..."
cat > ./start-ui.sh << EOL
#!/bin/bash

# Tino's Computer - UI Start Script

# Activate Python virtual environment if using Python
if [ -d "../env" ]; then
    source ../env/bin/activate
fi

# Detect which UI framework is being used
if [ -f "../ui/package.json" ]; then
    # Electron.js
    cd ../ui
    npm start
elif [ -f "../ui/main.py" ]; then
    # Python (PyQt or Kivy)
    cd ../ui
    python3 main.py
else
    echo "Cannot detect UI framework. Please make sure the UI code is properly set up."
    exit 1
fi
EOL

# Make scripts executable
chmod +x ./start-ui.sh

echo
echo "===== Setup Complete ====="
echo
echo "Next steps:"
echo "1. Develop your UI in the 'ui' directory"
echo "2. Use './scripts/start-ui.sh' to run the UI"
echo "3. To install the systemd service (for auto-start):"
echo "   sudo cp systemd/tinos-computer.service /etc/systemd/system/"
echo "   sudo systemctl daemon-reload"
echo "   sudo systemctl enable tinos-computer.service"
echo
echo "Happy coding!"
