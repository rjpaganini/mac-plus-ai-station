#!/bin/bash

# Tino's Computer - UI Start Script
# This script starts the UI application based on the available framework

set -e  # Exit immediately if a command exits with a non-zero status

# Get the directory of the script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

# Log file
LOG_FILE="$PROJECT_DIR/logs/ui.log"
mkdir -p "$(dirname "$LOG_FILE")"

# Log function
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

log "Starting Tino's Computer UI..."

# Check if running in X environment
if [ -z "$DISPLAY" ]; then
    log "No DISPLAY environment variable set. Setting to :0"
    export DISPLAY=:0
fi

# Activate Python virtual environment if it exists
if [ -d "$PROJECT_DIR/env" ]; then
    log "Activating Python virtual environment..."
    source "$PROJECT_DIR/env/bin/activate"
fi

# Determine which UI framework to use
if [ -f "$PROJECT_DIR/ui/electron/package.json" ] && command -v electron &> /dev/null; then
    # Electron.js
    log "Starting Electron.js UI..."
    cd "$PROJECT_DIR/ui/electron"
    if [ -f "node_modules/.bin/electron" ]; then
        ./node_modules/.bin/electron . >> "$LOG_FILE" 2>&1
    else
        electron . >> "$LOG_FILE" 2>&1
    fi
elif [ -f "$PROJECT_DIR/ui/kivy/main.py" ] && command -v python3 &> /dev/null; then
    # Kivy
    log "Starting Kivy UI..."
    cd "$PROJECT_DIR/ui/kivy"
    python3 main.py >> "$LOG_FILE" 2>&1
elif [ -f "$PROJECT_DIR/ui/pyqt/main.py" ] && command -v python3 &> /dev/null; then
    # PyQt
    log "Starting PyQt UI..."
    cd "$PROJECT_DIR/ui/pyqt"
    python3 main.py >> "$LOG_FILE" 2>&1
else
    log "ERROR: No UI framework detected or required dependencies not installed."
    log "Please run setup-dev-environment.sh to set up the development environment."
    exit 1
fi

# This point should not be reached if the UI is running correctly
log "UI process exited. Check the log file for details: $LOG_FILE"
