#!/bin/bash
#
# setup-mcp-servers.sh
# Configures all MCP servers for Claude Code CLI
# This ensures consistent MCP availability across sessions
#

set -e

echo "🚀 Setting up MCP servers for Claude Code CLI"
echo "=============================================="
echo ""

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to add MCP server with environment variables
add_mcp_server() {
    local name="$1"
    local command="$2"
    shift 2
    local args=("$@")
    
    echo -e "${YELLOW}Adding MCP server: $name${NC}"
    
    # Build the command
    local cmd="claude mcp add '$name' '$command'"
    for arg in "${args[@]}"; do
        cmd="$cmd '$arg'"
    done
    
    # Execute
    eval $cmd 2>/dev/null && echo -e "${GREEN}✓ $name added successfully${NC}" || echo -e "${RED}✗ Failed to add $name${NC}"
}

# Remove existing servers to ensure clean setup
echo "Cleaning up existing MCP configurations..."
claude mcp list 2>/dev/null | grep -v "No MCP servers" | while read -r server; do
    if [ ! -z "$server" ]; then
        claude mcp remove "$server" 2>/dev/null || true
    fi
done

echo ""
echo "Adding MCP servers..."
echo ""

# Core Research Tools
add_mcp_server "perplexity" "uvx" "perplexity-mcp"
export PERPLEXITY_API_KEY="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"

add_mcp_server "firecrawl-mcp" "npx" "-y" "firecrawl-mcp"
export FIRECRAWL_API_KEY="fc-99ce2e081f9644c4aa9a669d86073f73"

add_mcp_server "tavily-mcp" "npx" "-y" "tavily-mcp@latest"
export TAVILY_API_KEY="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"

add_mcp_server "sequential-thinking" "npx" "-y" "@modelcontextprotocol/server-sequential-thinking"

add_mcp_server "reddit-mcp" "npx" "-y" "reddit-mcp-server"
export REDDIT_CLIENT_ID="D4jHShqeKpzpSR-OhB-oww"
export REDDIT_CLIENT_SECRET="n2AjAKBzIYw3otpP7INatjGe-WZFHQ"

add_mcp_server "dataforseo" "npx" "-y" "dataforseo-mcp-server"
export DATAFORSEO_USERNAME="accounts@waterloo.digital"
export DATAFORSEO_PASSWORD="ca55f5e604bc59b0"

# Browser Automation
add_mcp_server "playwright" "npx" "@playwright/mcp@latest"

# Desktop Control
add_mcp_server "desktop-commander" "npx" "@wonderwhy-er/desktop-commander@latest"

# Additional Tools
add_mcp_server "n8n" "npx" "-y" "supergateway" "--sse" "https://transport.waterloo.digital/mcp/mcp/sse"

add_mcp_server "cloudinary" "npx" "@felores/cloudinary-mcp-server@latest"
export CLOUDINARY_CLOUD_NAME="dvqygzyld"
export CLOUDINARY_API_KEY="926882284414835"
export CLOUDINARY_API_SECRET="LESTR8EuFG1zOzxRo2rPMj_NKaA"

add_mcp_server "webflow" "npx" "-y" "webflow-mcp-server"
export WEBFLOW_TOKEN="9ef28d18df04fe74767c53fa57897a718f614b538518055172173f261357eca4"

add_mcp_server "mcp-compass" "npx" "-y" "@liuyoshio/mcp-compass"

add_mcp_server "web3-research" "npx" "-y" "@tamago-labs/web3-mcp" "--agent_mode=agent-base"

add_mcp_server "arxiv-mcp-server" "npx" "-y" "arxiv-mcp-server"

echo ""
echo "=============================================="
echo "MCP Server Setup Complete!"
echo ""
echo "Configured servers:"
claude mcp list

echo ""
echo "Environment variables have been set for this session."
echo "To make them permanent, add the following to your ~/.zshrc or ~/.bashrc:"
echo ""
echo "# MCP API Keys"
echo "export PERPLEXITY_API_KEY=\"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\""
echo "export FIRECRAWL_API_KEY=\"fc-99ce2e081f9644c4aa9a669d86073f73\""
echo "export TAVILY_API_KEY=\"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\""
echo "export REDDIT_CLIENT_ID=\"D4jHShqeKpzpSR-OhB-oww\""
echo "export REDDIT_CLIENT_SECRET=\"n2AjAKBzIYw3otpP7INatjGe-WZFHQ\""
echo "export DATAFORSEO_USERNAME=\"accounts@waterloo.digital\""
echo "export DATAFORSEO_PASSWORD=\"ca55f5e604bc59b0\""
echo "export CLOUDINARY_CLOUD_NAME=\"dvqygzyld\""
echo "export CLOUDINARY_API_KEY=\"926882284414835\""
echo "export CLOUDINARY_API_SECRET=\"LESTR8EuFG1zOzxRo2rPMj_NKaA\""
echo "export WEBFLOW_TOKEN=\"9ef28d18df04fe74767c53fa57897a718f614b538518055172173f261357eca4\""
echo ""