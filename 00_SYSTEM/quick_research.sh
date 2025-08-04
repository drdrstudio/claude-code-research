#!/bin/bash

# Claude Code Quick Research Setup Script

echo "🔍 Claude Code Quick Research Setup"
echo "=================================="
echo

# Get research topic
read -p "Enter research topic: " TOPIC

# Sanitize topic for folder name
FOLDER_NAME=$(echo "$TOPIC" | tr ' ' '_' | tr '[:upper:]' '[:lower:]' | sed 's/[^a-zA-Z0-9_-]//g')
DATE=$(date +%Y%m%d_%H%M%S)
PROJECT_NAME="Research_${FOLDER_NAME}_${DATE}"

# Create project directory
PROJECT_DIR="$HOME/Documents/cursor/Claude-Code-Research/03_PROJECTS/Duarte/$PROJECT_NAME"
mkdir -p "$PROJECT_DIR"

# Copy template
cp -r "$HOME/Documents/cursor/Claude-Code-Research/01_TEMPLATES/Claude_Code_Research_Template/"* "$PROJECT_DIR/"

# Update PROJECT_CONFIG.json
sed -i '' "s/\[TOPIC\]/$TOPIC/g" "$PROJECT_DIR/PROJECT_CONFIG.json"
sed -i '' "s/\[DATE\]/$DATE/g" "$PROJECT_DIR/PROJECT_CONFIG.json"
sed -i '' "s/\[TIMESTAMP\]/$(date -u +%Y-%m-%dT%H:%M:%SZ)/g" "$PROJECT_DIR/PROJECT_CONFIG.json"

# Update RESEARCH_LOG.md
sed -i '' "s/\[TOPIC\]/$TOPIC/g" "$PROJECT_DIR/RESEARCH_LOG.md"
sed -i '' "s/\[DATE\]/$(date +%Y-%m-%d)/g" "$PROJECT_DIR/RESEARCH_LOG.md"

# Create the Claude Code command
COMMAND="QUICK RESEARCH on $TOPIC"

# Copy command to clipboard (macOS)
echo "$COMMAND" | pbcopy

echo "✅ Project created: $PROJECT_DIR"
echo "📋 Command copied to clipboard: $COMMAND"
echo
echo "Next steps:"
echo "1. Open the project in Cursor"
echo "2. Paste the command to Claude Code"
echo "3. Let Claude Code execute the research"
echo

# Open in Cursor if available
if command -v cursor &> /dev/null; then
    read -p "Open in Cursor? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        cursor "$PROJECT_DIR"
    fi
fi