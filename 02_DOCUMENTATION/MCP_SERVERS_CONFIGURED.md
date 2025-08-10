# MCP Servers Configuration Documentation

## ✅ Successfully Configured MCP Servers

As of today, the following MCP servers have been added to Claude Code CLI:

### Research & Intelligence Tools
1. **perplexity** - AI-powered search and synthesis ✓ Connected
2. **firecrawl-mcp** - Web scraping and content extraction ✓ Connected
3. **tavily-mcp** - Research and web search ✓ Connected
4. **sequential-thinking** - Complex planning and analysis ✓ Connected
5. **reddit-mcp** - Reddit community insights ✓ Connected
6. **dataforseo** - SEO and keyword data ✓ Connected
7. **arxiv-mcp-server** - Academic paper research (connection issues)

### Automation & Control
8. **playwright** - Browser automation ✓ Connected
9. **desktop-commander** - Desktop control ✓ Connected
10. **n8n** - Workflow automation ✓ Connected

## Configuration Storage Locations

Claude Code CLI stores MCP server configurations in:

### Local Config (User-specific)
The configurations are stored in the Claude Code CLI's internal config, which persists across sessions. The exact location varies by OS but is managed by Claude Code CLI internally.

### To View Current Configuration:
```bash
claude mcp list
```

### To Add New Servers:
```bash
# Using JSON format (recommended)
claude mcp add-json "server-name" '{"command":"npx","args":["package-name"],"env":{"API_KEY":"value"}}'

# Using command format
claude mcp add "server-name" "command" "arg1" "arg2"
```

### To Remove a Server:
```bash
claude mcp remove "server-name"
```

## Environment Variables Required

These API keys need to be set in your shell environment (`.zshrc` or `.bashrc`):

```bash
# Perplexity
export PERPLEXITY_API_KEY="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"

# Firecrawl
export FIRECRAWL_API_KEY="fc-99ce2e081f9644c4aa9a669d86073f73"

# Tavily
export TAVILY_API_KEY="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"

# Reddit
export REDDIT_CLIENT_ID="D4jHShqeKpzpSR-OhB-oww"
export REDDIT_CLIENT_SECRET="n2AjAKBzIYw3otpP7INatjGe-WZFHQ"

# DataForSEO
export DATAFORSEO_USERNAME="accounts@waterloo.digital"
export DATAFORSEO_PASSWORD="ca55f5e604bc59b0"
```

## Quick Setup Script

A setup script has been created at:
```
/00_SYSTEM/setup-mcp-servers.sh
```

Run it to configure all MCP servers at once:
```bash
./00_SYSTEM/setup-mcp-servers.sh
```

## Troubleshooting

### If MCP servers don't appear:
1. Restart your Claude Code CLI session
2. Run `claude mcp list` to verify configuration
3. Check that required environment variables are set
4. Ensure npm/npx and uvx are installed

### If a specific server fails:
1. Check the server's specific requirements
2. Verify API keys are correct
3. Try removing and re-adding the server
4. Check network connectivity

## Testing MCP Availability

After configuration, these tools should be available in Claude Code:
- `mcp__perplexity__` functions
- `mcp__firecrawl__` functions
- `mcp__tavily__` functions
- `mcp__sequential_thinking__` functions
- `mcp__reddit__` functions
- `mcp__playwright__` functions
- `mcp__dataforseo__` functions

## Important Note

These configurations are stored in Claude Code CLI's local config and will persist across sessions. However, they are specific to your user account and this Claude Code CLI installation. If you use Claude Code CLI on another machine or user account, you'll need to run the setup script again.