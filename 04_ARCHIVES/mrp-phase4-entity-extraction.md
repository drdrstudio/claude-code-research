# MRP v4.0 - Phase 4 Entity Extraction Enhancement

## Integration Instructions

Add this to your MRP v4.0 Phase 4 (Analysis & Structuring) to automatically generate knowledge graph files:

### Phase 4: Analysis & Structuring (ENHANCED)

After processing fetched content into structured documents, ADD these steps:

1. **Entity Extraction for Knowledge Graph**
   ```bash
   # Run automated extraction
   ./auto-extract-entities.sh [Project_Folder]
   ```

2. **The AI should then:**
   - Read all documents in 01_searches, 02_fetched_content, 04_analysis
   - Extract ALL entities into `03_extracted_data/key_entities.json`:
     - People (with roles)
     - Companies (with industries)
     - Organizations (with types)
     - Legal entities (courts, agencies)
   
   - Map ALL relationships into `03_extracted_data/network_map.json`:
     - Employment (works_for, former_employee, ceo, board_member)
     - Ownership (owns, invested_in, portfolio_company)
     - Family (son_of, daughter_of, spouse_of)
     - Legal (sued_by, investigating, regulated_by)
     - Business (partner_with, competitor_of, customer_of)
     - Educational (alumnus_of, graduated_from)

3. **Validation Check:**
   - Ensure consistent entity naming
   - Verify all key relationships captured
   - Check for completeness

4. **Build Knowledge Graph** (Post-Phase 4):
   ```bash
   ./build-knowledge-graph.sh [Project_Folder]
   ```

## Example Entity Extraction Output

### key_entities.json:
```json
{
  "people": [
    {"name": "John Smith", "role": "CEO - Target Company"},
    {"name": "Jane Doe", "role": "Former CFO - Competitor Inc"}
  ],
  "companies": [
    {"name": "Target Company", "industry": "Technology"},
    {"name": "Competitor Inc", "industry": "Technology"}
  ]
}
```

### network_map.json:
```json
{
  "relationships": [
    {"source": "John Smith", "target": "Target Company", "type": "ceo"},
    {"source": "Jane Doe", "target": "Competitor Inc", "type": "former_cfo"},
    {"source": "Target Company", "target": "Competitor Inc", "type": "competitor_of"}
  ]
}
```

## Benefits

1. **Visual Analysis**: See complex relationship networks in Neo4j
2. **Pattern Discovery**: Identify hidden connections across entities
3. **Cross-Project Intelligence**: Build master graph from all research
4. **Reusable Data**: Structured data ready for further analysis

## Quick Reference Commands

```bash
# Extract entities from research
./auto-extract-entities.sh [Research_Folder]

# Build Neo4j knowledge graph
./build-knowledge-graph.sh [Research_Folder]

# Query all projects in Neo4j
MATCH (n) RETURN DISTINCT n.project_id

# Find cross-project connections
MATCH (p:Person)
WHERE SIZE(COLLECT(DISTINCT p.project_id)) > 1
RETURN p.name, COLLECT(DISTINCT p.project_id)
```