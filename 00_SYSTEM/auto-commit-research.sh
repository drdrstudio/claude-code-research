#!/bin/bash

# Auto-commit research results to GitHub
# Called after each research completes on Railway

PROJECT_FOLDER="$1"
RESEARCH_TYPE="${2:-research}"
TARGET_NAME="${3:-Unknown}"

echo "📦 Auto-committing research: $PROJECT_FOLDER"

# Configure git (Railway environment)
git config user.email "railway-bot@claude-code-research.com"
git config user.name "Railway Research Bot"

# Add the new research folder
git add "03_PROJECTS/$PROJECT_FOLDER" 2>/dev/null || git add "$PROJECT_FOLDER"

# Commit with descriptive message
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
git commit -m "🔬 Research completed: $TARGET_NAME ($RESEARCH_TYPE)

Project: $PROJECT_FOLDER
Type: $RESEARCH_TYPE
Target: $TARGET_NAME
Completed: $TIMESTAMP
Environment: Railway Production

Auto-committed by Railway deployment"

# Push to GitHub
git push origin main || {
    echo "⚠️ Push failed, trying with token..."
    # If regular push fails, try with token
    if [ -n "$GITHUB_TOKEN" ]; then
        git remote set-url origin https://${GITHUB_TOKEN}@github.com/drdrstudio/claude-code-research.git
        git push origin main
    else
        echo "❌ No GITHUB_TOKEN set, cannot push"
        exit 1
    fi
}

echo "✅ Research committed to GitHub successfully"