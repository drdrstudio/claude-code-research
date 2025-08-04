# Claude Code CLI MCP Setup Guide

## How to Add MCP Servers to Claude Code CLI

Claude Code CLI supports adding MCP servers directly! Here's how to add marketing MCP servers:

## Installation Commands for Marketing MCP Servers

### 1. Firecrawl MCP (Web Scraping)
```bash
# First, get your Firecrawl API key from https://firecrawl.dev
claude mcp add firecrawl npx firecrawl-mcp -e FIRECRAWL_API_KEY=your_api_key
```

### 2. Perplexity MCP (AI Search)
```bash
# Get API key from https://perplexity.ai
claude mcp add perplexity uvx perplexity-mcp -e PERPLEXITY_API_KEY=your_api_key
```

### 3. Tavily MCP (Web Research)
```bash
# Get API key from https://tavily.com
claude mcp add tavily npx tavily-mcp@latest -e TAVILY_API_KEY=your_api_key
```

### 4. Reddit MCP
```bash
# No API key required for basic usage
claude mcp add reddit npx reddit-mcp-server
```

### 5. DataForSEO MCP
```bash
# Get credentials from https://dataforseo.com
claude mcp add dataforseo npx dataforseo-mcp-server \
  -e DATAFORSEO_USERNAME=your_username \
  -e DATAFORSEO_PASSWORD=your_password
```

### 6. Playwright MCP (Browser Automation)
```bash
# No API key required
claude mcp add playwright npx @playwright/mcp@latest
```

### 7. Web3 Research MCP
```bash
claude mcp add web3 npx @tamago-labs/web3-mcp --agent_mode=agent-base
```

### 8. Sequential Thinking MCP
```bash
claude mcp add sequential npx @sequentialai/mcp-server-sequential-thinking
```

### 9. MCP Compass (Navigation)
```bash
claude mcp add compass npx @liuyoshio/mcp-compass
```

### 10. YouTube Transcript MCP
```bash
# Via Smithery platform
claude mcp add youtube npx @smithery/cli@latest run @sinco-lab/mcp-youtube-transcript
```

## Marketing MCP Servers Requiring Manual Setup

### HubSpot MCP
```bash
# Clone and setup
git clone https://github.com/peakmojo/mcp-hubspot
cd mcp-hubspot
npm install
# Then add with your API key
claude mcp add hubspot node /path/to/mcp-hubspot/index.js \
  -e HUBSPOT_API_KEY=your_api_key
```

### Mailchimp MCP
```bash
# Requires OAuth setup through Cloudflare Workers
# More complex installation - see specific docs
```

### Salesforce MCP
```bash
# Requires Salesforce Connected App setup
# OAuth flow required
```

## Scope Options

Add servers with different scopes:
```bash
# User scope (available in all projects)
claude mcp add -s user firecrawl npx firecrawl-mcp -e FIRECRAWL_API_KEY=key

# Project scope (shared with team)
claude mcp add -s project reddit npx reddit-mcp-server

# Local scope (default, project-specific)
claude mcp add -s local tavily npx tavily-mcp@latest -e TAVILY_API_KEY=key
```

## Verifying Installation

After adding servers:
```bash
# List all configured MCP servers
claude mcp list

# Remove a server
claude mcp remove server-name
```

## Usage in Claude Code

Once added, you can reference MCP resources with @:
- `@firecrawl` - Access firecrawl tools
- `@reddit` - Access Reddit search
- `@tavily` - Web research

## Free vs Paid MCP Servers

### Free (No API Key Required):
- Reddit MCP
- Playwright MCP
- Sequential Thinking
- MCP Compass
- Basic Web3 Research

### Require API Keys (Free Tiers Available):
- Firecrawl (free tier: 500 pages/month)
- Tavily (free tier: 1000 searches/month)
- Perplexity (free tier available)
- DataForSEO (paid only)

### Enterprise/Paid:
- HubSpot (requires HubSpot account)
- Salesforce (requires Salesforce account)
- Mailchimp (requires account)

## Important Notes

1. **API Keys**: Most marketing MCPs require API keys from their respective services
2. **npx vs uvx**: 
   - `npx` for Node.js-based servers
   - `uvx` for Python-based servers (like Perplexity)
3. **Updates**: Servers update automatically when using npx/uvx
4. **Multiple Servers**: You can add multiple MCP servers simultaneously
5. **Environment Variables**: Use `-e` flag for each environment variable needed

## Quick Start (Free Options)

```bash
# Add free MCP servers that don't require API keys
claude mcp add -s user reddit npx reddit-mcp-server
claude mcp add -s user playwright npx @playwright/mcp@latest
claude mcp add -s user sequential npx @sequentialai/mcp-server-sequential-thinking
claude mcp add -s user compass npx @liuyoshio/mcp-compass

# Verify they're added
claude mcp list
```

Now you can use these in Claude Code CLI with @ mentions!