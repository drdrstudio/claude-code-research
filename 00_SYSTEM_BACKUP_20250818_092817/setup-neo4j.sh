#!/bin/bash
#
# setup-neo4j.sh
# Setup script for Neo4j and the Knowledge Graph Builder
#

echo "🔧 Neo4j Setup Script"
echo "===================="

# Check if Neo4j Desktop is installed
if [ -d "/Applications/Neo4j Desktop.app" ]; then
    echo "✅ Neo4j Desktop is already installed"
else
    echo "📥 Neo4j Desktop not found. Opening download page..."
    echo ""
    echo "Please download Neo4j Desktop from: https://neo4j.com/download/"
    echo ""
    echo "Installation steps:"
    echo "1. Download Neo4j Desktop for macOS"
    echo "2. Open the downloaded .dmg file"
    echo "3. Drag Neo4j Desktop to your Applications folder"
    echo "4. Launch Neo4j Desktop and create a new project"
    echo "5. Create a new database with a password you'll remember"
    echo "6. Start the database"
    echo ""
    open "https://neo4j.com/download/"
    echo "Press Enter once you've completed the Neo4j Desktop installation..."
    read
fi

# Check if cypher-shell is available
if command -v cypher-shell &> /dev/null; then
    echo "✅ cypher-shell is available"
else
    echo "⚠️  cypher-shell not found in PATH"
    echo "Neo4j Desktop includes cypher-shell, but it may not be in your PATH."
    echo ""
    echo "Looking for cypher-shell in Neo4j Desktop..."
    
    # Common locations for cypher-shell in Neo4j Desktop
    CYPHER_SHELL_PATHS=(
        "/Applications/Neo4j Desktop.app/Contents/Resources/neo4j/bin/cypher-shell"
        "$HOME/Library/Application Support/Neo4j Desktop/Application/relate-data/dbmss/*/bin/cypher-shell"
    )
    
    FOUND_CYPHER_SHELL=""
    for path in "${CYPHER_SHELL_PATHS[@]}"; do
        if [ -f "$path" ] || compgen -G "$path" > /dev/null; then
            FOUND_CYPHER_SHELL=$(ls $path 2>/dev/null | head -1)
            if [ -n "$FOUND_CYPHER_SHELL" ]; then
                echo "✅ Found cypher-shell at: $FOUND_CYPHER_SHELL"
                break
            fi
        fi
    done
    
    if [ -z "$FOUND_CYPHER_SHELL" ]; then
        echo "❌ Could not find cypher-shell. Installing neo4j-community via Homebrew..."
        brew install neo4j
    else
        echo ""
        echo "To add cypher-shell to your PATH, add this to your ~/.zshrc or ~/.bash_profile:"
        echo "export PATH=\"$(dirname $FOUND_CYPHER_SHELL):\$PATH\""
        echo ""
        echo "Or you can create a symlink:"
        echo "sudo ln -s \"$FOUND_CYPHER_SHELL\" /usr/local/bin/cypher-shell"
    fi
fi

echo ""
echo "📝 Neo4j Configuration"
echo "====================="
echo ""
echo "IMPORTANT: Update the build-knowledge-graph.sh script with your Neo4j password:"
echo ""
echo "1. Open build-knowledge-graph.sh in your editor"
echo "2. Change line 10: NEO4J_PASSWORD=\"password\""
echo "3. Replace \"password\" with your actual Neo4j database password"
echo ""
echo "Default Neo4j connection details:"
echo "- URI: neo4j://localhost:7687"
echo "- Username: neo4j"
echo "- Password: [your password]"
echo ""
echo "✅ Setup complete! You can now use ./build-knowledge-graph.sh <Research_Folder>"