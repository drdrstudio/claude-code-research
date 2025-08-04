#!/bin/bash
#
# configure-neo4j-password.sh
# Helper script to configure Neo4j password for the knowledge graph builder
#

echo "🔐 Neo4j Password Configuration"
echo "=============================="
echo ""
echo "This script will help you set up the Neo4j password for the knowledge graph builder."
echo ""
echo "First, make sure Neo4j Desktop is running and you have a database started."
echo ""
echo "Enter your Neo4j database password (or press Enter to use default 'password'):"
read -s NEO4J_PASS

if [ -z "$NEO4J_PASS" ]; then
    NEO4J_PASS="password"
    echo "(Using default password)"
else
    echo "(Password entered)"
fi

# Test the connection
echo ""
echo "Testing Neo4j connection..."
echo "RETURN 'Connection successful' AS message;" | cypher-shell -u neo4j -p "$NEO4J_PASS" -a neo4j://localhost:7687 2>/dev/null

if [ $? -eq 0 ]; then
    echo "✅ Connection successful!"
    echo ""
    echo "Updating build-knowledge-graph.sh with your password..."
    
    # Create a backup
    cp build-knowledge-graph.sh build-knowledge-graph.sh.bak
    
    # Update the password in the script
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS sed requires -i ''
        sed -i '' "s/NEO4J_PASSWORD=\".*\"/NEO4J_PASSWORD=\"$NEO4J_PASS\"/" build-knowledge-graph.sh
    else
        # Linux sed
        sed -i "s/NEO4J_PASSWORD=\".*\"/NEO4J_PASSWORD=\"$NEO4J_PASS\"/" build-knowledge-graph.sh
    fi
    
    echo "✅ Password updated in build-knowledge-graph.sh"
    echo ""
    echo "You're all set! You can now use:"
    echo "./build-knowledge-graph.sh <Research_Folder_Name>"
    
else
    echo "❌ Connection failed!"
    echo ""
    echo "Please check:"
    echo "1. Neo4j Desktop is running"
    echo "2. You have a database created and started"
    echo "3. The password is correct"
    echo "4. The database is listening on neo4j://localhost:7687"
    echo ""
    echo "If you haven't set up Neo4j Desktop yet, visit: https://neo4j.com/download/"
fi