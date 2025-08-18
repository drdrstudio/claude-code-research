#!/bin/bash

# MRP Research System - Desktop Launcher
# Double-click this file to start the research interface

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Clear the terminal for a clean start
clear

# Display welcome message
echo "════════════════════════════════════════════════════════════════"
echo "                                                                "
echo "              🔍 MRP INTELLIGENCE SYSTEM v7.0                  "
echo "                                                                "
echo "          $5,000 Enterprise Reputational Intelligence          "
echo "                                                                "
echo "════════════════════════════════════════════════════════════════"
echo ""
echo "Starting your research interface..."
echo ""

# Change to the system directory
cd "$SCRIPT_DIR"

# Run the web interface launcher
./launch-web-interface.sh

# Keep terminal open if there's an error
if [ $? -ne 0 ]; then
    echo ""
    echo "Press any key to close this window..."
    read -n 1
fi