#!/bin/bash
echo "Setting up all MCPs with API keys..."

# Perplexity
claude mcp add perplexity uvx perplexity-mcp \
  --env PERPLEXITY_API_KEY=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

# Firecrawl  
claude mcp add firecrawl-mcp "npx -y firecrawl-mcp" \
  --env FIRECRAWL_API_KEY=fc-99ce2e081f9644c4aa9a669d86073f73

# Cloudinary
claude mcp add cloudinary "npx @felores/cloudinary-mcp-server@latest" \
  --env CLOUDINARY_CLOUD_NAME=dvqygzyld \
  --env CLOUDINARY_API_KEY=926882284414835 \
  --env CLOUDINARY_API_SECRET=LESTR8EuFG1zOzxRo2rPMj_NKaA

# Reddit
claude mcp add reddit-mcp "npx -y reddit-mcp-server" \
  --env REDDIT_CLIENT_ID=D4jHShqeKpzpSR-OhB-oww \
  --env REDDIT_CLIENT_SECRET=n2AjAKBzIYw3otpP7INatjGe-WZFHQ

# Tavily
claude mcp add tavily "npx -y tavily-mcp@latest" \
  --env TAVILY_API_KEY=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

# DataForSEO
claude mcp add dataforseo "npx -y dataforseo-mcp-server" \
  --env DATAFORSEO_USERNAME=accounts@waterloo.digital \
  --env DATAFORSEO_PASSWORD=ca55f5e604bc59b0

# Webflow
claude mcp add webflow "npx -y webflow-mcp-server" \
  --env WEBFLOW_TOKEN=9ef28d18df04fe74767c53fa57897a718f614b538518055172173f261357eca4

# No API keys needed
claude mcp add arxiv "npx -y arxiv-mcp-server"
claude mcp add sequential-thinking "npx -y @modelcontextprotocol/server-sequential-thinking"
claude mcp add playwright "npx @playwright/mcp@latest"
claude mcp add desktop-commander "npx @wonderwhy-er/desktop-commander@latest"

# MCP Compass (local)
claude mcp add mcp-compass "node /Users/skipmatheny/mcp-compass/build/index.js"

echo "✅ All MCPs configured! Exit and restart Claude to use them."