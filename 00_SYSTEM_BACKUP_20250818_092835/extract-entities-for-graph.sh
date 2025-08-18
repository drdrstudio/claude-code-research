#!/bin/bash
#
# extract-entities-for-graph.sh
# MRP Phase 4 helper: Extracts entities and relationships from research documents
# and creates JSON files for the Neo4j knowledge graph builder
#

# Check for input
if [ -z "$1" ]; then
  echo "❌ Error: No project folder provided."
  echo "Usage: ./extract-entities-for-graph.sh <Research_Folder_Name>"
  exit 1
fi

PROJECT_FOLDER="$1"
if [ ! -d "$PROJECT_FOLDER" ]; then
  echo "❌ Error: Project folder '${PROJECT_FOLDER}' not found."
  exit 1
fi

echo "🔍 Entity Extraction for Knowledge Graph"
echo "======================================="
echo "Project: ${PROJECT_FOLDER}"

# Create output directory
OUTPUT_DIR="${PROJECT_FOLDER}/03_extracted_data"
mkdir -p "$OUTPUT_DIR"

# Define paths
ENTITIES_FILE="${OUTPUT_DIR}/key_entities.json"
NETWORK_FILE="${OUTPUT_DIR}/network_map.json"
TIMELINE_FILE="${OUTPUT_DIR}/timeline.json"

# Initialize JSON structures
echo "📊 Initializing JSON structures..."

cat > "$ENTITIES_FILE" << 'EOF'
{
  "people": [],
  "companies": [],
  "organizations": [],
  "locations": [],
  "events": [],
  "legal_entities": [],
  "products": [],
  "technologies": []
}
EOF

cat > "$NETWORK_FILE" << 'EOF'
{
  "relationships": []
}
EOF

cat > "$TIMELINE_FILE" << 'EOF'
{
  "events": []
}
EOF

echo "✅ JSON files initialized"

# Create extraction prompt file
EXTRACTION_PROMPT="${OUTPUT_DIR}/extraction_instructions.md"
cat > "$EXTRACTION_PROMPT" << 'EOF'
# Entity Extraction Instructions

## For the AI Assistant:

Please analyze all research documents in this project and extract:

### 1. KEY ENTITIES (→ key_entities.json)

**People:**
- Format: {"name": "Full Name", "role": "Title/Description"}
- Include: Executives, founders, board members, key personnel, investigators, regulators

**Companies:**
- Format: {"name": "Company Name", "industry": "Industry Type"}
- Include: Target companies, portfolio companies, competitors, partners, subsidiaries

**Organizations:**
- Format: {"name": "Org Name", "type": "Organization Type"}
- Include: Government agencies, NGOs, industry associations, universities

**Legal Entities:**
- Format: {"name": "Entity Name", "type": "Court/Agency/Firm"}
- Include: Courts, regulatory bodies, law firms

### 2. RELATIONSHIPS (→ network_map.json)

**Format:** {"source": "Entity A", "target": "Entity B", "type": "relationship_type"}

**Common relationship types:**
- Employment: works_for, former_employee, founder, ceo, board_member
- Ownership: owns, invested_in, acquired, portfolio_company
- Family: son_of, daughter_of, spouse_of, sibling_of
- Legal: sued_by, investigating, regulated_by, represented_by
- Business: partner_with, competitor_of, customer_of, supplier_to
- Educational: alumnus_of, professor_at, graduated_from

### 3. TIMELINE (→ timeline.json)

**Format:** {"date": "YYYY-MM-DD", "event": "Description", "entities": ["Entity1", "Entity2"]}

## IMPORTANT NOTES:
- Extract from ALL documents in the project (searches, fetched content, analysis)
- Use exact names consistently (e.g., always "Bob Crants III" not "Bob Crants")
- Include historical relationships with past tense markers (former_, ex_)
- Capture both positive and negative relationships
- Include dates where available in timeline
EOF

echo ""
echo "📋 Next Steps:"
echo "============="
echo ""
echo "1. The JSON files have been created in:"
echo "   ${OUTPUT_DIR}/"
echo ""
echo "2. TO POPULATE THE FILES:"
echo "   - Review all documents in folders 01_searches, 02_fetched_content, 04_analysis"
echo "   - Extract entities and relationships according to the instructions in:"
echo "     ${EXTRACTION_PROMPT}"
echo "   - Update the JSON files with the extracted data"
echo ""
echo "3. ALTERNATIVELY, use this AI prompt:"
echo "   'Please read all documents in this research project and populate the"
echo "   JSON files in 03_extracted_data/ according to extraction_instructions.md'"
echo ""
echo "4. Once populated, run:"
echo "   ./build-knowledge-graph.sh ${PROJECT_FOLDER}"
echo ""
echo "✅ Entity extraction framework ready!"