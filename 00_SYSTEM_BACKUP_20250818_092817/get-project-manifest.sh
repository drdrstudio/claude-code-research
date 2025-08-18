#!/bin/bash
#
# Script to generate a project manifest and format it as a prompt
# for the System Architect (Gemini), then copy it to the clipboard.
#

# Check if a project folder was provided
if [ -z "$1" ]; then
  echo "Usage: ./get-project-manifest.sh <Research_Folder_Name>"
  exit 1
fi

PROJECT_FOLDER="$1"

if [ ! -d "$PROJECT_FOLDER" ]; then
  echo "Error: Project folder '${PROJECT_FOLDER}' not found."
  exit 1
fi

# Prepare the prompt text and the file list, then pipe to clipboard
{
  echo "Architect, the research for '${PROJECT_FOLDER}' is complete."
  echo "Here is the project manifest. Please prepare the Mega-Analysis blueprint."
  echo ""
  echo "--- PROJECT MANIFEST ---"
  find "${PROJECT_FOLDER}" -type f
  echo "--- END MANIFEST ---"
} | pbcopy

echo "✅ Success! The Mega-Analysis prompt has been prepared and copied to your clipboard."
echo "You can now paste it into your chat with the Architect."