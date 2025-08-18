#!/bin/bash
#
# build-knowledge-graph.sh
# An MRP tool to ingest structured JSON data into a local Neo4j Knowledge Graph.
#

# --- Configuration ---
# The user should change this password to match their Neo4j database password.
NEO4J_USER="neo4j"
NEO4J_PASSWORD="T0tustuus!!@"
NEO4J_URI="neo4j://localhost:7687"

# --- Script Logic ---

# 1. Check for Input
if [ -z "$1" ]; then
  echo "❌ Error: No project folder provided."
  echo "Usage: ./build-knowledge-graph.sh <Research_Folder_Name>"
  exit 1
fi

PROJECT_FOLDER="$1"
if [ ! -d "$PROJECT_FOLDER" ]; then
  echo "❌ Error: Project folder '${PROJECT_FOLDER}' not found."
  exit 1
fi

echo "▶️ Starting Knowledge Graph build for project: ${PROJECT_FOLDER}"

# 2. Define Paths to Source JSON Files
ENTITIES_FILE="${PROJECT_FOLDER}/03_extracted_data/key_entities.json"
NETWORK_FILE="${PROJECT_FOLDER}/03_extracted_data/network_map.json"

# Verify that source files exist before proceeding
if [ ! -f "$ENTITIES_FILE" ] || [ ! -f "$NETWORK_FILE" ]; then
  echo "❌ Error: Required JSON files (key_entities.json, network_map.json) not found in project."
  exit 1
fi

# 3. Generate Cypher Script
# We will build a single Cypher script in a temporary file.
CYPHER_SCRIPT=$(mktemp)
echo "📝 Generating Cypher script..."

# Add commands to clear old graph data for this project and set constraints.
# Using a project_id ensures we only clear data relevant to this import.
PROJECT_ID=$(basename "${PROJECT_FOLDER}")
echo "MATCH (n {project_id: '${PROJECT_ID}'}) DETACH DELETE n;" > "$CYPHER_SCRIPT"
echo "CREATE CONSTRAINT person_name IF NOT EXISTS FOR (p:Person) REQUIRE p.name IS UNIQUE;" >> "$CYPHER_SCRIPT"
echo "CREATE CONSTRAINT company_name IF NOT EXISTS FOR (c:Company) REQUIRE c.name IS UNIQUE;" >> "$CYPHER_SCRIPT"

# Use jq to parse the JSON files and create Cypher MERGE statements.
# This ensures nodes are created once and adds the project_id property.
jq -r --arg pid "$PROJECT_ID" '.people[] | "MERGE (p:Person {name: \(.name|@sh)}) SET p.project_id = \($pid|@sh), p.role = \(.role|@sh);"' "$ENTITIES_FILE" >> "$CYPHER_SCRIPT"
jq -r --arg pid "$PROJECT_ID" '.companies[] | "MERGE (c:Company {name: \(.name|@sh)}) SET c.project_id = \($pid|@sh), c.industry = \(.industry|@sh);"' "$ENTITIES_FILE" >> "$CYPHER_SCRIPT"
jq -r --arg pid "$PROJECT_ID" '.relationships[] | "MATCH (a {name: \(.source|@sh)}), (b {name: \(.target|@sh)}) MERGE (a)-[:RELATES_TO {type: \(.type|@sh), project_id: \($pid|@sh)}]->(b);"' "$NETWORK_FILE" >> "$CYPHER_SCRIPT"

echo "✅ Cypher script generated."

# 4. Execute Cypher Script
echo "⏳ Ingesting data into Neo4j... (Requires Neo4j Desktop to be running)"
cat "$CYPHER_SCRIPT" | cypher-shell -u "${NEO4J_USER}" -p "${NEO4J_PASSWORD}" -a "${NEO4J_URI}"

# Check the exit code of the cypher-shell command
if [ $? -eq 0 ]; then
  echo "🚀 Success! Knowledge Graph for '${PROJECT_ID}' has been built."
else
  echo "❌ Error: Failed to ingest data into Neo4j. Is the database running and are the credentials correct?"
fi

# 5. Cleanup
rm "$CYPHER_SCRIPT"