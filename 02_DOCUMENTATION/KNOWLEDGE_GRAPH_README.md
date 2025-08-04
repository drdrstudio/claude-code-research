# Neo4j Knowledge Graph Builder for MRP Research

## Overview
The `build-knowledge-graph.sh` script transforms MRP research JSON data into a visual Neo4j knowledge graph, allowing you to explore relationships between people, companies, and other entities discovered during research.

## Prerequisites

✅ **Already Installed:**
- `jq` - JSON processor (installed via Homebrew)
- `cypher-shell` - Neo4j command-line interface (installed via Homebrew)

❌ **Still Needed:**
- Neo4j Desktop - Download from https://neo4j.com/download/

## Quick Setup

1. **Install Neo4j Desktop** (if not already installed):
   - Download from https://neo4j.com/download/
   - Install the app to your Applications folder
   - Launch Neo4j Desktop
   - Create a new project
   - Create a new database with a memorable password
   - Start the database

2. **Configure Password**:
   ```bash
   ./configure-neo4j-password.sh
   ```
   This will test your connection and update the script with your password.

## Usage

To build a knowledge graph from any MRP research project:

```bash
./build-knowledge-graph.sh Pharos/Research_DeepDive_PharosReputationalLiability_20250804_001604
```

The script will:
1. Read JSON files from `03_extracted_data/` directory
2. Generate Cypher queries to create nodes and relationships
3. Load the data into your Neo4j database
4. Tag all data with the project ID for easy filtering

## Viewing Your Graph

1. Open Neo4j Desktop
2. Open your database browser
3. Run queries like:
   - `MATCH (n) RETURN n LIMIT 100` - View all nodes
   - `MATCH (p:Person)-[r]->(c:Company) RETURN p, r, c` - View person-company relationships
   - `MATCH (n {project_id: 'Research_DeepDive_PharosReputationalLiability_20250804_001604'}) RETURN n` - View specific project

## Required JSON Structure

The script expects these files in your research project:

**03_extracted_data/key_entities.json:**
```json
{
  "people": [
    {"name": "Bob Crants", "role": "Chief Investment Officer"},
    {"name": "Kneeland Youngblood", "role": "Founder"}
  ],
  "companies": [
    {"name": "Pharos Capital Group", "industry": "Private Equity"},
    {"name": "CoreCivic", "industry": "Private Prisons"}
  ]
}
```

**03_extracted_data/network_map.json:**
```json
{
  "relationships": [
    {"source": "Bob Crants", "target": "Pharos Capital Group", "type": "works_for"},
    {"source": "Bob Crants", "target": "Prison Realty Trust", "type": "former_president"}
  ]
}
```

## Troubleshooting

**"Failed to ingest data into Neo4j"**
- Ensure Neo4j Desktop is running
- Check your database is started
- Verify password is correct using `./configure-neo4j-password.sh`

**"Required JSON files not found"**
- Ensure you've run the complete MRP research protocol
- Check that Phase 4 (Analysis & Structuring) was completed
- Verify files exist in `03_extracted_data/` directory

## Advanced Usage

To query specific projects in Neo4j:
```cypher
// Show all people from a specific research project
MATCH (p:Person {project_id: 'Research_DeepDive_PharosReputationalLiability_20250804_001604'})
RETURN p.name, p.role

// Show relationship network for a specific person
MATCH (p:Person {name: 'Bob Crants'})-[r]-(connected)
RETURN p, r, connected

// Find all private prison connections
MATCH (c:Company {industry: 'Private Prisons'})-[r]-(connected)
RETURN c, r, connected
```