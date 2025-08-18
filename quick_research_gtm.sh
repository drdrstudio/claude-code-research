#!/bin/bash

# REAL Market/GTM Research Script - Actually runs research with API calls
# NO DEMO, NO MOCK, NO SLEEP - REAL RESEARCH

TARGET="${1:-Market_Research}"
RESEARCH_TYPE="${RESEARCH_TYPE:-market}"
DEPTH="${DEPTH:-standard}"
TEMPLATE="${TEMPLATE:-corporate}"

echo "🔍 Starting REAL Market/GTM Research"
echo "=================================="
echo "📋 Target: $TARGET"
echo "📊 Type: $RESEARCH_TYPE"
echo ""

# Create project directory
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
PROJECT_FOLDER="Research_${RESEARCH_TYPE}_${TARGET}_${TIMESTAMP}"
PROJECT_DIR="03_PROJECTS/$PROJECT_FOLDER"
mkdir -p "$PROJECT_DIR"

# Run REAL research using Node.js engine
echo "🚀 Running actual API calls..."
node 00_SYSTEM/api/real-research-engine.js "$TARGET" "$RESEARCH_TYPE" "$PROJECT_FOLDER" "$PROJECT_DIR"

# Check if research succeeded
if [ $? -eq 0 ]; then
    echo "✅ Research completed successfully"
    echo "📁 Results in: $PROJECT_DIR"
else
    echo "❌ Research failed - check API keys"
    exit 1
fi