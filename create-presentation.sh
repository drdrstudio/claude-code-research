#!/bin/bash

# create-presentation.sh - Automated Marp presentation workflow
# This script pre-processes a markdown file and converts it to PDF using Marp

# Check for correct number of arguments
if [ $# -ne 1 ]; then
    echo "Usage: ./create-presentation.sh <input_file.md>"
    exit 1
fi

# Store input file path
INPUT_FILE="$1"

# Verify input file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: Input file '$INPUT_FILE' not found"
    exit 1
fi

# Verify input file has .md extension
if [[ ! "$INPUT_FILE" =~ \.md$ ]]; then
    echo "Error: Input file must have .md extension"
    exit 1
fi

# Check if preprocess.sh exists and is executable
if [ ! -f "./preprocess.sh" ]; then
    echo "Error: preprocess.sh not found in current directory"
    exit 1
fi

if [ ! -x "./preprocess.sh" ]; then
    echo "Error: preprocess.sh is not executable"
    echo "Run: chmod +x preprocess.sh"
    exit 1
fi

# Check if marp is installed
if ! command -v marp &> /dev/null; then
    echo "Error: marp-cli is not installed"
    echo "Install with: npm install -g @marp-team/marp-cli"
    exit 1
fi

# Check if theme file exists
if [ ! -f "./waterloo-light-theme.css" ]; then
    echo "Error: waterloo-light-theme.css not found in current directory"
    exit 1
fi

# Define filenames based on input
# Remove directory path and .md extension, then add appropriate suffixes
BASENAME=$(basename "$INPUT_FILE" .md)
DIRNAME=$(dirname "$INPUT_FILE")
TEMP_FILE="$DIRNAME/${BASENAME}.marp.md"
OUTPUT_FILE="$DIRNAME/${BASENAME}.pdf"

# Step 1: Run preprocessor
echo "📝 Pre-processing markdown file..."
if ! ./preprocess.sh "$INPUT_FILE" > "$TEMP_FILE"; then
    echo "Error: Failed to pre-process file"
    exit 1
fi

# Step 2: Generate PDF with Marp
echo "🎨 Converting to PDF with Marp..."
if ! marp "$TEMP_FILE" --pdf --theme-set waterloo-light-theme.css --allow-local-files -o "$OUTPUT_FILE"; then
    echo "Error: Failed to generate PDF"
    # Clean up temp file even on failure
    rm -f "$TEMP_FILE"
    exit 1
fi

# Step 3: Clean up temporary file
echo "🧹 Cleaning up temporary files..."
rm -f "$TEMP_FILE"

# Step 4: Success message
echo ""
echo "✅ Presentation successfully created at: $OUTPUT_FILE"
echo ""

# Optional: Display file info
if command -v ls &> /dev/null; then
    ls -lh "$OUTPUT_FILE"
fi