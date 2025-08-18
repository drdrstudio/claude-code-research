#!/bin/bash

# upload-to-notebooklm.sh
# Script to upload research deliverables to NotebookLM
# Usage: ./upload-to-notebooklm.sh [Research_Folder_Name]

set -e  # Exit on any error

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if research folder name provided
if [ -z "$1" ]; then
    print_error "Usage: ./upload-to-notebooklm.sh [Research_Folder_Name]"
    print_error "Example: ./upload-to-notebooklm.sh Research_QuantumComputing_20250803_120000"
    exit 1
fi

RESEARCH_FOLDER="$1"
NOTEBOOK_NAME=$(echo "$RESEARCH_FOLDER" | sed 's/Research_//' | sed 's/_[0-9]*_[0-9]*$//')

# Verify research folder exists
if [ ! -d "$RESEARCH_FOLDER" ]; then
    print_error "Research folder '$RESEARCH_FOLDER' not found in current directory"
    exit 1
fi

print_status "Starting NotebookLM upload for: $RESEARCH_FOLDER"

# Check if nlm CLI is available and authenticated
print_status "Checking NotebookLM CLI access..."
if ! command -v nlm &> /dev/null; then
    print_error "NotebookLM CLI (nlm) not found. Please install it first:"
    print_error "go install github.com/manno/nlm@latest"
    exit 1
fi

# Test authentication
if ! nlm whoami &> /dev/null; then
    print_error "NotebookLM CLI not authenticated. Please run: nlm login"
    exit 1
fi

print_success "NotebookLM CLI is ready"

# Create notebook (name based on research topic)
print_status "Creating NotebookLM notebook: $NOTEBOOK_NAME"

# Try to create notebook, capture output
NOTEBOOK_OUTPUT=$(nlm create notebook "$NOTEBOOK_NAME" 2>&1)
if [ $? -ne 0 ]; then
    # Check if notebook already exists
    if echo "$NOTEBOOK_OUTPUT" | grep -q "already exists" || echo "$NOTEBOOK_OUTPUT" | grep -q "duplicate"; then
        print_warning "Notebook '$NOTEBOOK_NAME' already exists, using existing notebook"
    else
        print_error "Failed to create notebook: $NOTEBOOK_OUTPUT"
        exit 1
    fi
else
    print_success "Created notebook: $NOTEBOOK_NAME"
fi

# Find documents to upload
print_status "Scanning for documents to upload..."

UPLOAD_COUNT=0
UPLOAD_LIST=""

# Upload documents from different folders in priority order
declare -a FOLDERS=("FINAL_DELIVERABLES" "05_synthesis" "04_analysis" "02_fetched_content")
declare -a EXTENSIONS=("*.pdf" "*.md" "*.txt" "*.csv")

for folder in "${FOLDERS[@]}"; do
    FOLDER_PATH="$RESEARCH_FOLDER/$folder"
    if [ -d "$FOLDER_PATH" ]; then
        print_status "Checking folder: $folder"
        
        for ext in "${EXTENSIONS[@]}"; do
            for file in "$FOLDER_PATH"/$ext; do
                if [ -f "$file" ]; then
                    # Skip certain files
                    basename_file=$(basename "$file")
                    case "$basename_file" in
                        search_log.csv|PROJECT_CONFIG.json|.*) 
                            continue ;;
                    esac
                    
                    print_status "Uploading: $basename_file"
                    
                    # Upload to NotebookLM
                    if nlm upload "$NOTEBOOK_NAME" "$file" 2>/dev/null; then
                        print_success "✓ Uploaded: $basename_file"
                        UPLOAD_COUNT=$((UPLOAD_COUNT + 1))
                        UPLOAD_LIST="$UPLOAD_LIST\n  - $basename_file"
                    else
                        print_warning "⚠ Failed to upload: $basename_file"
                    fi
                fi
            done
        done
    fi
done

# Upload key markdown files from root if they exist
for file in "$RESEARCH_FOLDER/RESEARCH_LOG.md" "$RESEARCH_FOLDER/README.md"; do
    if [ -f "$file" ]; then
        basename_file=$(basename "$file")
        print_status "Uploading: $basename_file"
        
        if nlm upload "$NOTEBOOK_NAME" "$file" 2>/dev/null; then
            print_success "✓ Uploaded: $basename_file"
            UPLOAD_COUNT=$((UPLOAD_COUNT + 1))
            UPLOAD_LIST="$UPLOAD_LIST\n  - $basename_file"
        else
            print_warning "⚠ Failed to upload: $basename_file"
        fi
    fi
done

# Get notebook URL/ID for sharing
print_status "Getting notebook link..."
NOTEBOOK_LINK=""

# Try to get notebooks list and extract URL
if NOTEBOOKS_JSON=$(nlm list notebooks 2>/dev/null); then
    # This is a placeholder - actual implementation depends on nlm CLI output format
    print_status "Notebook created successfully. Check your NotebookLM dashboard for the link."
    NOTEBOOK_LINK="https://notebooklm.google.com/ (Check your dashboard for: $NOTEBOOK_NAME)"
else
    print_warning "Could not retrieve notebook link automatically"
    NOTEBOOK_LINK="https://notebooklm.google.com/ (Manual: Find '$NOTEBOOK_NAME' in your dashboard)"
fi

# Update RESEARCH_LOG.md with NotebookLM information
RESEARCH_LOG="$RESEARCH_FOLDER/RESEARCH_LOG.md"
if [ -f "$RESEARCH_LOG" ]; then
    print_status "Updating RESEARCH_LOG.md with NotebookLM information..."
    
    # Add NotebookLM section to research log
    {
        echo ""
        echo "## NotebookLM Integration"
        echo ""
        echo "**Upload Date:** $(date '+%Y-%m-%d %H:%M:%S')"
        echo "**Notebook Name:** $NOTEBOOK_NAME"
        echo "**Notebook URL:** $NOTEBOOK_LINK"
        echo "**Documents Uploaded:** $UPLOAD_COUNT"
        echo ""
        echo "### Uploaded Files:"
        echo -e "$UPLOAD_LIST"
        echo ""
        echo "### AI Analysis Available"
        echo "Visit the NotebookLM notebook to:"
        echo "- Ask questions about the research"
        echo "- Generate additional summaries"
        echo "- Create custom study guides"
        echo "- Get AI-powered insights across all documents"
    } >> "$RESEARCH_LOG"
    
    print_success "Updated RESEARCH_LOG.md with NotebookLM details"
fi

# Final summary
echo ""
echo "=================================="
print_success "NotebookLM Upload Complete!"
echo "=================================="
echo ""
print_status "Summary:"
echo "  📁 Research Folder: $RESEARCH_FOLDER"
echo "  📔 Notebook Name: $NOTEBOOK_NAME"
echo "  📄 Files Uploaded: $UPLOAD_COUNT"
echo "  🔗 Notebook URL: $NOTEBOOK_LINK"
echo ""
print_status "Next Steps:"
echo "  1. Visit NotebookLM: https://notebooklm.google.com/"
echo "  2. Open notebook: $NOTEBOOK_NAME"  
echo "  3. Start asking questions about your research!"
echo "  4. Generate summaries, study guides, and get AI insights"
echo ""

# Return the notebook link for use by calling scripts
echo "NOTEBOOK_LINK=$NOTEBOOK_LINK"