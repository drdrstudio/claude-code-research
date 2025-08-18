# MRP System Status Report
Generated: Thu Aug 14 16:31:44 PDT 2025

## Current Version
- **Protocol**: MRP v6.1.2
- **Status**: Production Ready
- **Location**: 00_SYSTEM/MRP_v6.1.2.md

## System Components

### Core Entry Points
- `mrp-launcher.sh` - Unified launcher with recipe selection
- `web-api-server.py` - Web interface (http://localhost:5000)
- `research-pdf-api.py` - CLI API interface

### Available Recipes
1. **Reputational Intelligence** - Individual due diligence
2. **Organizational Intelligence** - Company analysis
3. **GTM Marketing Research** - Go-to-market strategy

### Key Scripts
- **Citation System**: auto-citation-extractor.sh, auto-insert-citations.py
- **PDF Generation**: generate-research-pdf-automated.sh
- **Research Pipeline**: run-mega-analysis.sh
- **Knowledge Graph**: build-knowledge-graph.sh

### Templates Available
- Corporate (default)
- Tufte (academic)
- Sakura (minimal)
- Classic (traditional)

### MCP Tools Configured
Checking MCP server health...

perplexity: uvx perplexity-mcp - ✓ Connected
firecrawl-mcp: npx -y firecrawl-mcp - ✓ Connected
tavily-mcp: npx -y tavily-mcp@latest - ✓ Connected
sequential-thinking: npx -y @modelcontextprotocol/server-sequential-thinking - ✓ Connected
reddit-mcp: npx -y reddit-mcp-server - ✓ Connected
playwright: npx @playwright/mcp@latest - ✓ Connected
dataforseo: npx -y dataforseo-mcp-server - ✓ Connected
n8n: npx -y supergateway --sse https://transport.waterloo.digital/mcp/mcp/sse - ✓ Connected
desktop-commander: npx @wonderwhy-er/desktop-commander@latest - ✓ Connected
arxiv-mcp-server: npx -y arxiv-mcp-server - ✗ Failed to connect

## Quick Start
```bash
# Launch unified interface
./00_SYSTEM/mrp-launcher.sh

# Start web interface
python 00_SYSTEM/web-api-server.py

# Direct CLI usage
python 00_SYSTEM/research-pdf-api.py --help
```
