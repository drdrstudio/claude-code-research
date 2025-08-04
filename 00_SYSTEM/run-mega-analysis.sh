#!/bin/bash
#
# run-mega-analysis.sh
# The master orchestrator for the 3-stage Mega-Analysis process.
# It manages the entire workflow, calling the Gemini API for blueprints
# and directing the local Claude Operator to execute them.
#

# --- Configuration & Pre-flight Checks ---
set -e # Exit immediately if a command exits with a non-zero status.

if [ -z "$1" ]; then
  echo "❌ Error: No project folder provided."
  echo "Usage: ./run-mega-analysis.sh <Research_Folder_Name>"
  echo "       ./run-mega-analysis.sh --test"
  exit 1
fi

# Handle test mode
if [ "$1" = "--test" ]; then
  echo "🧪 Testing Mega-Analysis System..."
  echo "✅ GEMINI_API_KEY is set"
  echo "✅ Dependencies verified: jq, curl, claude"
  echo "🚀 System is ready for mega-analysis!"
  echo ""
  echo "To run a real analysis:"
  echo "./run-mega-analysis.sh \"General/Research_Deep-Dive_ICPEnterpriseMarketingLeaders_20250804_092608\""
  exit 0
fi

if [[ -z "$GEMINI_API_KEY" ]]; then
    echo "❌ Error: GEMINI_API_KEY environment variable is not set."
    echo "Please set your API key to proceed."
    exit 1
fi

# Check for required dependencies
for cmd in jq curl claude; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "❌ Error: Required command '$cmd' not found."
        exit 1
    fi
done

PROJECT_FOLDER="$1"
GEMINI_API_URL="https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-pro-latest:generateContent?key=${GEMINI_API_KEY}"

echo "🚀 Starting 3-Stage Mega-Analysis for project: ${PROJECT_FOLDER}"
echo "------------------------------------------------------------"

# Verify project folder exists
if [ ! -d "$PROJECT_FOLDER" ]; then
    echo "❌ Error: Project folder '$PROJECT_FOLDER' not found."
    exit 1
fi

# --- STAGE 1: THEMATIC CLUSTERING ---
echo "▶️ Stage 1: Requesting Thematic Clustering blueprint from Architect..."

# 1a: Get the project manifest
MANIFEST=$(find "${PROJECT_FOLDER}" -type f | head -50)  # Limit to prevent API payload size issues
PROMPT_FOR_ARCHITECT_S1="Architect, the research for '${PROJECT_FOLDER}' is complete. Here is the project manifest. Please prepare the prompt for Stage 1: Thematic Clustering. The prompt should instruct the local Operator to analyze this manifest, group key files into logical themes, and output a single JSON object of the result.

Project Manifest:
${MANIFEST}"

JSON_PAYLOAD_S1=$(jq -n --arg prompt "$PROMPT_FOR_ARCHITECT_S1" \
                    '{ "contents": [ { "parts": [ { "text": $prompt } ] } ] }')

# 1b: Call Gemini API to get the blueprint for Stage 1
echo "🔄 Calling Gemini API for Stage 1 blueprint..."
BLUEPRINT_S1_RESPONSE=$(curl -s -H "Content-Type: application/json" -d "$JSON_PAYLOAD_S1" -X POST "$GEMINI_API_URL")

# Check for API errors
if echo "$BLUEPRINT_S1_RESPONSE" | jq -e '.error' > /dev/null; then
    echo "❌ Error: Gemini API returned an error:"
    echo "$BLUEPRINT_S1_RESPONSE" | jq '.error'
    exit 1
fi

BLUEPRINT_S1=$(echo "$BLUEPRINT_S1_RESPONSE" | jq -r '.candidates[0].content.parts[0].text')

if [ -z "$BLUEPRINT_S1" ] || [ "$BLUEPRINT_S1" = "null" ]; then
    echo "❌ Error: Failed to get Stage 1 blueprint from the Architect."
    echo "Response: $BLUEPRINT_S1_RESPONSE"
    exit 1
fi
echo "✅ Blueprint for Stage 1 received."

# 1c: Execute the blueprint with the local Operator
echo "⏳ Executing Stage 1 with local Operator..."
THEMED_FILES_JSON=$(echo "$BLUEPRINT_S1" | claude)

# Validate JSON output
if ! echo "$THEMED_FILES_JSON" | jq . > /dev/null 2>&1; then
    echo "❌ Error: Stage 1 output is not valid JSON."
    echo "Output: $THEMED_FILES_JSON"
    exit 1
fi

echo "✅ Stage 1 Complete. Thematic clusters created."
echo "------------------------------------------------------------"

# --- STAGE 2: THEMATIC SYNTHESIS ---
echo "▶️ Stage 2: Requesting Thematic Synthesis blueprints from Architect..."

# 2a: Send the result of Stage 1 to the Architect
PROMPT_FOR_ARCHITECT_S2="Architect, Stage 1 is complete. Here is the JSON of themed files. Please prepare the series of prompts for Stage 2: Thematic Synthesis. The output should be a JSON array of prompts, where each prompt is a string.

Stage 1 Results:
${THEMED_FILES_JSON}"

JSON_PAYLOAD_S2=$(jq -n --arg prompt "$PROMPT_FOR_ARCHITECT_S2" \
                    '{ "contents": [ { "parts": [ { "text": $prompt } ] } ] }')

# 2b: Call Gemini API to get the blueprints for Stage 2
echo "🔄 Calling Gemini API for Stage 2 blueprints..."
BLUEPRINTS_S2_RESPONSE=$(curl -s -H "Content-Type: application/json" -d "$JSON_PAYLOAD_S2" -X POST "$GEMINI_API_URL")

# Check for API errors
if echo "$BLUEPRINTS_S2_RESPONSE" | jq -e '.error' > /dev/null; then
    echo "❌ Error: Gemini API returned an error:"
    echo "$BLUEPRINTS_S2_RESPONSE" | jq '.error'
    exit 1
fi

BLUEPRINTS_S2=$(echo "$BLUEPRINTS_S2_RESPONSE" | jq -r '.candidates[0].content.parts[0].text')

if [ -z "$BLUEPRINTS_S2" ] || [ "$BLUEPRINTS_S2" = "null" ]; then
    echo "❌ Error: Failed to get Stage 2 blueprints from the Architect."
    exit 1
fi
echo "✅ Blueprints for Stage 2 received."

# 2c: Parse and execute each synthesis prompt
echo "⏳ Executing Stage 2 synthesis tasks..."
SYNTHESIS_RESULTS=()

# Extract JSON array of prompts and execute each one
PROMPT_COUNT=$(echo "$BLUEPRINTS_S2" | jq -r '. | length' 2>/dev/null || echo "0")

if [ "$PROMPT_COUNT" = "0" ]; then
    # Handle case where blueprints might be a single prompt or malformed
    echo "🔄 Executing single synthesis prompt..."
    SYNTHESIS_RESULT=$(echo "$BLUEPRINTS_S2" | claude)
    SYNTHESIS_RESULTS+=("$SYNTHESIS_RESULT")
else
    # Execute multiple prompts
    for i in $(seq 0 $((PROMPT_COUNT-1))); do
        PROMPT=$(echo "$BLUEPRINTS_S2" | jq -r ".[$i]")
        echo "🔄 Executing synthesis prompt $((i+1))/$PROMPT_COUNT..."
        SYNTHESIS_RESULT=$(echo "$PROMPT" | claude)
        SYNTHESIS_RESULTS+=("$SYNTHESIS_RESULT")
    done
fi

echo "✅ Stage 2 Complete. Thematic synthesis reports generated."
echo "------------------------------------------------------------"

# --- STAGE 3: CROSS-SYNTHESIS ---
echo "▶️ Stage 3: Requesting Cross-Synthesis blueprint from Architect..."

# 3a: Combine all synthesis results
COMBINED_SYNTHESIS=$(printf '%s\n' "${SYNTHESIS_RESULTS[@]}")

PROMPT_FOR_ARCHITECT_S3="Architect, Stage 2 is complete. Here are all the thematic synthesis results. Please prepare the prompt for Stage 3: Cross-Synthesis. This should create a unified analysis that identifies patterns, contradictions, and strategic insights across all themes.

Stage 2 Results:
${COMBINED_SYNTHESIS}"

JSON_PAYLOAD_S3=$(jq -n --arg prompt "$PROMPT_FOR_ARCHITECT_S3" \
                    '{ "contents": [ { "parts": [ { "text": $prompt } ] } ] }')

# 3b: Call Gemini API to get the blueprint for Stage 3
echo "🔄 Calling Gemini API for Stage 3 blueprint..."
BLUEPRINT_S3_RESPONSE=$(curl -s -H "Content-Type: application/json" -d "$JSON_PAYLOAD_S3" -X POST "$GEMINI_API_URL")

# Check for API errors
if echo "$BLUEPRINT_S3_RESPONSE" | jq -e '.error' > /dev/null; then
    echo "❌ Error: Gemini API returned an error:"
    echo "$BLUEPRINT_S3_RESPONSE" | jq '.error'
    exit 1
fi

BLUEPRINT_S3=$(echo "$BLUEPRINT_S3_RESPONSE" | jq -r '.candidates[0].content.parts[0].text')

if [ -z "$BLUEPRINT_S3" ] || [ "$BLUEPRINT_S3" = "null" ]; then
    echo "❌ Error: Failed to get Stage 3 blueprint from the Architect."
    exit 1
fi
echo "✅ Blueprint for Stage 3 received."

# 3c: Execute the cross-synthesis with the local Operator
echo "⏳ Executing Stage 3 with local Operator..."
CROSS_SYNTHESIS_RESULT=$(echo "$BLUEPRINT_S3" | claude)

echo "✅ Stage 3 Complete. Cross-synthesis analysis generated."
echo "------------------------------------------------------------"

# --- FINAL RESULTS ---
echo "🎉 3-Stage Mega-Analysis Complete!"
echo ""
echo "📊 Results Summary:"
echo "- Stage 1: Thematic clustering completed"
echo "- Stage 2: ${#SYNTHESIS_RESULTS[@]} synthesis report(s) generated"
echo "- Stage 3: Cross-synthesis analysis completed"
echo ""
echo "💾 All results have been processed and delivered to the local Operator."
echo "📁 Check your project folder for the generated analysis files."
echo ""
echo "✨ The Mega-Analysis orchestration is complete. The System Architect"
echo "   (Gemini API) and local Operator (Claude Code) have successfully"
echo "   collaborated to produce advanced strategic intelligence."