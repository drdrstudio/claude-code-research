#!/bin/bash

# Sync Railway research back to local machine
# Run this locally to pull all research from Railway

echo "🔄 Syncing research from Railway to local..."
echo "==========================================="

# Make sure we're on main branch
git checkout main

# Fetch latest from GitHub (includes Railway's commits)
git fetch origin main

# Pull with rebase to avoid merge commits
git pull --rebase origin main

# Count new research folders
NEW_RESEARCH=$(find 03_PROJECTS -type d -name "Research_*" -mtime -1 2>/dev/null | wc -l)

if [ "$NEW_RESEARCH" -gt 0 ]; then
    echo "✅ Found $NEW_RESEARCH new research project(s) from the last 24 hours"
    echo ""
    echo "Recent research projects:"
    find 03_PROJECTS -type d -name "Research_*" -mtime -1 2>/dev/null | head -10
else
    echo "📝 No new research in the last 24 hours"
fi

echo ""
echo "💡 To see all research projects:"
echo "   ls -la 03_PROJECTS/"
echo ""
echo "💡 To view a specific research:"
echo "   open 03_PROJECTS/[PROJECT_NAME]/PDFs/"