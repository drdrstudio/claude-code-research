#!/bin/bash
#
# auto-extract-entities.sh
# Automated entity extraction for MRP research projects
# This script analyzes research documents and generates knowledge graph JSON files
#

set -e

# Check for input
if [ -z "$1" ]; then
  echo "❌ Error: No project folder provided."
  echo "Usage: ./auto-extract-entities.sh <Research_Folder_Name>"
  exit 1
fi

PROJECT_FOLDER="$1"
if [ ! -d "$PROJECT_FOLDER" ]; then
  echo "❌ Error: Project folder '${PROJECT_FOLDER}' not found."
  exit 1
fi

echo "🤖 Automated Entity Extraction for Neo4j Knowledge Graph"
echo "======================================================"
echo "Project: ${PROJECT_FOLDER}"
echo ""

# Create output directory
OUTPUT_DIR="${PROJECT_FOLDER}/03_extracted_data"
mkdir -p "$OUTPUT_DIR"

# Create a combined document for analysis
COMBINED_DOC="${OUTPUT_DIR}/combined_research.tmp"
echo "📚 Combining research documents..."

# Combine all relevant documents
{
  echo "# Combined Research Documents for Entity Extraction"
  echo "# Project: ${PROJECT_FOLDER}"
  echo ""
  
  # Add search results if they exist
  if [ -d "${PROJECT_FOLDER}/01_searches" ]; then
    echo "## SEARCH RESULTS"
    echo "================"
    find "${PROJECT_FOLDER}/01_searches" -name "*.json" -o -name "*.md" | while read -r file; do
      echo "### Source: $(basename "$file")"
      cat "$file"
      echo -e "\n---\n"
    done
  fi
  
  # Add fetched content
  if [ -d "${PROJECT_FOLDER}/02_fetched_content" ]; then
    echo "## FETCHED CONTENT"
    echo "=================="
    find "${PROJECT_FOLDER}/02_fetched_content" -name "*.md" | while read -r file; do
      echo "### Source: $(basename "$file")"
      cat "$file"
      echo -e "\n---\n"
    done
  fi
  
  # Add analysis documents
  if [ -d "${PROJECT_FOLDER}/04_analysis" ]; then
    echo "## ANALYSIS DOCUMENTS"
    echo "===================="
    find "${PROJECT_FOLDER}/04_analysis" -name "*.md" | while read -r file; do
      echo "### Source: $(basename "$file")"
      cat "$file"
      echo -e "\n---\n"
    done
  fi
  
  # Add final reports
  if [ -d "${PROJECT_FOLDER}/FINAL_REPORTS" ]; then
    echo "## FINAL REPORTS"
    echo "==============="
    find "${PROJECT_FOLDER}/FINAL_REPORTS" -name "*.md" | while read -r file; do
      echo "### Source: $(basename "$file")"
      cat "$file"
      echo -e "\n---\n"
    done
  fi
} > "$COMBINED_DOC"

# Count words for size estimate
WORD_COUNT=$(wc -w < "$COMBINED_DOC")
echo "📊 Combined document size: ${WORD_COUNT} words"

# Create the extraction prompt
EXTRACTION_PROMPT="${OUTPUT_DIR}/auto_extraction_prompt.txt"
cat > "$EXTRACTION_PROMPT" << 'PROMPT_END'
Analyze the provided research documents and extract ALL entities and relationships to create a comprehensive knowledge graph. Generate TWO JSON files:

1. key_entities.json with this EXACT structure:
{
  "people": [
    {"name": "Full Name", "role": "Their role or title"}
  ],
  "companies": [
    {"name": "Company Name", "industry": "Industry sector"}
  ],
  "organizations": [
    {"name": "Organization Name", "type": "Type of organization"}
  ],
  "legal_entities": [
    {"name": "Entity Name", "type": "Court/Agency/Law Firm"}
  ]
}

2. network_map.json with this EXACT structure:
{
  "relationships": [
    {"source": "Person/Company A", "target": "Person/Company B", "type": "relationship_type"}
  ]
}

EXTRACTION RULES:
- Extract EVERY person, company, organization mentioned
- Use consistent naming (e.g., always "Bob Crants III" not variations)
- Relationship types should be lowercase with underscores: works_for, owns, sued_by, invested_in, former_ceo, board_member, alumnus_of, etc.
- Include ALL relationships: employment, ownership, family, legal, business, educational
- Capture both current and historical relationships (use former_, ex_ prefixes)
- Include negative relationships (sued_by, investigating, bankrupt)

Focus on completeness - better to include too much than miss important connections.
PROMPT_END

echo ""
echo "🔄 Processing..."
echo ""
echo "⚡ MANUAL STEP REQUIRED:"
echo "========================"
echo ""
echo "The research has been combined into a single document for analysis."
echo "Please use your AI assistant to extract entities by:"
echo ""
echo "1. Copy this prompt:"
echo "   cat '${EXTRACTION_PROMPT}'"
echo ""
echo "2. Provide the combined research document:"
echo "   cat '${COMBINED_DOC}'"
echo ""
echo "3. Save the AI's response for key_entities.json to:"
echo "   ${OUTPUT_DIR}/key_entities.json"
echo ""
echo "4. Save the AI's response for network_map.json to:"
echo "   ${OUTPUT_DIR}/network_map.json"
echo ""
echo "5. Then run: ./build-knowledge-graph.sh ${PROJECT_FOLDER}"
echo ""

# Optional: Create template files
echo "📝 Creating template files as backup..."
cat > "${OUTPUT_DIR}/key_entities.json" << 'EOF'
{
  "people": [],
  "companies": [],
  "organizations": [],
  "legal_entities": []
}
EOF

cat > "${OUTPUT_DIR}/network_map.json" << 'EOF'
{
  "relationships": []
}
EOF

# Cleanup
rm -f "$COMBINED_DOC"

echo "✅ Entity extraction prepared!"
echo ""
echo "🎯 Quick Copy Commands:"
echo "====================="
echo "# View extraction instructions:"
echo "cat '${EXTRACTION_PROMPT}'"
echo ""
echo "# After AI extraction, build the graph:"
echo "./build-knowledge-graph.sh ${PROJECT_FOLDER}"