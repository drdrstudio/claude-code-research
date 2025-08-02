# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## WORKING REQUIREMENTS - READ FIRST

I am NOT a developer and need careful, tested solutions. You MUST follow these rules:

1. **VERIFY EVERYTHING WORKS** before saying "done" or "complete"
2. Test ALL functionality locally AND in production
3. Actually visit URLs and test login/features yourself
4. Check logs for errors
5. Pull environment variables back to verify they're set correctly
6. Read the latest docs on EVERY platform when using any service (you listed above)
7. If something might fail, test it first

DO NOT tell me something is "ready" or "working" until you have:
- Built and deployed successfully
- Tested the actual deployed site
- Verified all environment variables are correct
- Confirmed all features work end-to-end
- Checked for console errors and API failures

If you encounter an error:
- Debug it completely before moving on
- Don't assume a fix worked - verify it
- Test the EXACT same way a user would

Your role: Act as my senior developer who takes full ownership. I should be able to show this to a client immediately after you say "done."

Before ANY Code Changes:

1. TEST LOCALLY FIRST - Never push code without testing. Tell me explicitly: "I tested this locally and it works"
2. SHOW ME THE TEST - Include the actual terminal output of your local test
3. ONE THING AT A TIME - Make one small change, test it, verify it works, then move to the next

For Every Solution:

1. If I ask - Explain Like I'm Five - I don't know coding. Explain what you're doing and why in simple terms
2. Check Before Assuming - Ask me to verify things instead of guessing (e.g., "Can you check if X is set in Vercel?")
3. Show Your Work - Include the commands you ran and their output
4. Finally when and where possible since I am not a dev, act like a senior developer and own the project and its success or failure based on your work.

When Things Break:

1. Stop and Debug - Don't try multiple fixes. Debug the actual error first
2. Read Error Messages - Quote the exact error and explain what it means
3. Admit Uncertainty - Say "I'm not sure why this is happening, let me investigate" instead of guessing

Quality Checklist - Complete Before EVERY Push:

- Ran npm run build locally - BUILD PASSED
- Tested the specific feature that was broken
- Checked for unused imports/variables
- Verified no new errors were introduced

Example of What I Expect:

"I'm going to fix the chat API error. First, let me test the current endpoint locally:

$ curl http://localhost:3000/api/chat -X POST -d '{"message":"test"}'
Error: OpenAI API key not found

I see the issue. The code is looking for the API key in the wrong place. Let me make a small fix and test it:

[Shows code change]

Now testing locally:
$ npm run build
✓ Build successful
$ curl http://localhost:3000/api/chat -X POST -d '{"message":"test"}'
{"response": "Hello! How can I help?"}

---
It's critical that you start every response by confirming you've done each step and have followed these requirements by saying "Ten-Four good buddy".

## CLI Access Requirements

I am always (or should always be) logged in to the following CLIs:
- **Vercel CLI** - For deployments, env vars, logs, and project management
- **Cloudflare Wrangler** - For Workers, KV, R2, and edge functions
- **Supabase CLI** - For database, auth, and backend services
- **Stripe CLI** - For payments, webhooks, products, and testing
- **NPM CLI** - For package publishing and management
- **GitHub CLI (gh)** - For repos, PRs, issues, and Actions
- **Redis CLI** - For cache management and data operations
- **Playwright** - For browser automation and testing
- **ngrok** - For secure tunnels and webhook testing
- **Inngest CLI** - For event-driven workflows and background jobs

**IMPORTANT**: Do EVERYTHING you can via these CLIs. I need you to work in the background with minimal manual intervention.

**CRITICAL - START OF CHAT VERIFICATION**: At the beginning of EVERY chat session, I MUST check all CLI access by running quick verification commands. If ANY CLI is not working, I must alert you immediately with: "⚠️ CLI Access Issue: [CLI name] is not responding. Please check your login."

Requirements:
1. **USE CLI FIRST** - Always attempt tasks via CLI before asking for manual steps
2. **VERIFY ACCESS** - If you get permission errors, tell me immediately
3. **ASK FOR MORE** - If you need access to other CLIs (e.g., AWS, GCP, Stripe), ask me to login
4. **AUTOMATE EVERYTHING** - The goal is zero manual work for deployment and management

Common CLI Commands You Should Use:
```bash
# Vercel
vercel --version          # Check if logged in
vercel whoami            # Verify account
vercel env pull          # Get environment variables
vercel env add NAME      # Add env var
vercel deploy            # Deploy project
vercel logs              # Check logs

# Cloudflare Wrangler
wrangler whoami          # Check login status
wrangler kv:namespace list   # List KV namespaces
wrangler r2 bucket list      # List R2 buckets
wrangler deploy          # Deploy Workers

# Supabase
supabase --version       # Check if installed
supabase projects list   # List projects
supabase db push        # Push migrations
supabase functions deploy # Deploy functions

# Stripe
stripe --version         # Check version
stripe login --interactive # Verify login
stripe products list     # List products
stripe listen --forward-to localhost:3000/webhook # Test webhooks
stripe trigger payment_intent.succeeded # Test events

# NPM
npm whoami               # Check login
npm publish              # Publish package
npm version patch        # Bump version
npm access ls-packages   # List package access

# GitHub (gh)
gh auth status           # Check authentication
gh repo create           # Create repository
gh pr create             # Create pull request
gh issue list            # List issues
gh workflow run          # Trigger Actions

# Redis
redis-cli ping           # Check connection
redis-cli INFO server    # Get server info
redis-cli KEYS "*"       # List all keys
redis-cli FLUSHDB        # Clear current database

# Playwright
playwright --version     # Check version
playwright install       # Install browsers
playwright test          # Run tests
playwright show-report   # Show test report

# ngrok
ngrok version           # Check version
ngrok authtoken         # Verify auth
ngrok http 3000         # Create tunnel
ngrok status            # Check active tunnels

# Inngest
inngest --version       # Check version
inngest whoami          # Verify login
inngest dev             # Start dev server
inngest deploy          # Deploy functions
```

### CLI Verification Checklist (Run at Start of Chat)
```bash
# Quick verification commands to run at beginning of EVERY chat:
vercel whoami
wrangler whoami
supabase projects list
stripe --version
npm whoami
gh auth status
redis-cli ping
playwright --version
ngrok version
inngest whoami
```

If any CLI command fails with authentication errors, immediately ask: "Can you verify you're logged into [CLI name]? Try running `[cli] whoami` and let me know what it shows."

## Quick Reference Commands

```bash
# Start new research project
./quick_research.sh

# Switch Klaviyo MCP accounts
./switch-klaviyo.sh [waterloo|acme|retail]

# PublicRecordsMCP commands (if working in that subsystem)
cd /Users/skipmatheny/Documents/cursor/Waterloo/PublicRecordsMCP
npm run dev              # Start development server
npm run build            # Build for production
npm run lint             # Run linter
```

## Repository Overview

This is the Claude Code Research automation system - a streamlined framework for conducting systematic research using Claude Code in Cursor. The system provides automated research protocols triggered by specific "magic words" that execute comprehensive information gathering, analysis, and synthesis workflows.

**IMPORTANT**: Always check for and use available MCP (Model Context Protocol) tools in Cursor! The following MCP tools are currently enabled and should be prioritized:
- `mcp__firecrawl__` for web scraping
- `mcp__perplexity__` for AI-powered search
- `mcp__tavily__` for web research
- `mcp__playwright__` for browser automation
- `mcp__reddit__` for Reddit searches
- `mcp__web3_research__` for crypto/blockchain research

Only use WebSearch and WebFetch as fallbacks when MCP tools are unavailable or fail.

## Key Commands and Magic Words

When users type these exact phrases, execute the corresponding research protocol:

1. **COMPREHENSIVE RESEARCH on [TOPIC]** - Full research with multiple searches (~$0.10 budget)
2. **QUICK RESEARCH on [TOPIC]** - Fast overview (3 searches, 5 fetches max, ~$0.02)
3. **RESUME RESEARCH [NAME]** - Continue existing research without repeating searches
4. **DEEP DIVE on [TOPIC]** - In-depth analysis with extensive fetching (~$0.25)
5. **NEWS SCAN on [TOPIC]** - Latest developments and current events (~$0.05)

## Available Tools

### MCP Tools (PRIORITIZE THESE - Currently enabled in Cursor):
- **firecrawl-mcp** (8 tools) - Advanced web scraping and crawling
- **perplexity-mcp** (1 tool) - AI-powered search and synthesis  
- **Playwright** (24 tools) - Browser automation for complex scraping
- **sequential-thinking** (1 tool) - For complex reasoning tasks
- **mcp-compass** (1 tool) - Navigation and search assistance
- **web3-research** (10 tools) - Web3/crypto research tools
- **reddit-mcp** (12 tools) - Reddit search and analysis
- **tavily-mcp** (4 tools) - Web search and research

### Core Research Tools (Always available):
- **WebSearch** - Search the web for information
- **WebFetch** - Fetch and analyze web content with AI
- **TodoWrite** - Track research tasks and progress

### File Management:
- **Read/Write/Edit** - File operations
- **Bash** - System commands
- **Grep/Glob** - File searching

## Research Project Structure

```
Research_[TOPIC]_[DATE]/
├── 01_searches/              # WebSearch results (JSON)
├── 02_fetched_content/       # WebFetch results (markdown)
├── 03_extracted_data/        # Structured data (JSON, CSV)
├── 04_analysis/              # Analysis documents
├── 05_synthesis/             # Final reports
├── 06_metadata/              # Search tracking and metadata
├── RESEARCH_LOG.md           # Progress tracker
└── PROJECT_CONFIG.json       # Configuration
```

## File Naming Convention

`YYYYMMDD_HHMMSS_[tool]_[operation]_[identifier].md`

Example: `20250119_143025_websearch_quantum_computing.md`

## Research Protocol Execution

### COMPREHENSIVE RESEARCH Protocol:

1. **Setup Phase**
   - Create project folder from template
   - Initialize PROJECT_CONFIG.json
   - Create TodoWrite task list with all phases

2. **Search Phase** (use WebSearch)
   - General search: "[TOPIC]"
   - Recent news: "[TOPIC] news 2024 2025"
   - Technical: "[TOPIC] technology research"
   - Market: "[TOPIC] market analysis"
   - Expert views: "[TOPIC] expert opinion"
   - Save all results to `01_searches/` immediately

3. **Fetch Phase** (use WebFetch)
   - Fetch top 10-15 URLs from searches
   - Use prompts like:
     - "Extract key facts about [TOPIC]"
     - "What are the main challenges?"
     - "List opportunities and risks"
     - "Summarize expert opinions"
   - Save all fetched content to `02_fetched_content/`

4. **Analysis Phase**
   - Compile findings into structured documents
   - Create comparison tables
   - Generate timelines
   - Build resource lists
   - Save to `04_analysis/`

5. **Synthesis Phase**
   - Create executive summary
   - Generate comprehensive report
   - List actionable insights
   - Save to `05_synthesis/`

### QUICK RESEARCH Protocol:

1. **Setup** - Create project folder and TodoWrite list
2. **Search** - Run 3 targeted searches maximum
3. **Fetch** - Fetch 5 most relevant URLs only
4. **Synthesize** - Create single summary document

### DEEP DIVE Protocol:

1. **Setup** - Create project folder with extended scope
2. **Initial Search** - Comprehensive searches across all aspects
3. **Deep Fetch** - Fetch 20-30 URLs with detailed prompts
4. **Expert Analysis** - Create detailed technical documents
5. **Academic Search** - Find and analyze research papers
6. **Synthesis** - Create detailed technical report

### NEWS SCAN Protocol:

1. **Setup** - Create lightweight project folder
2. **Time-bound Search** - Focus on last 30 days
3. **Quick Fetch** - Fetch 5-10 latest news articles
4. **Trend Analysis** - Create timeline and trend report

## Search Tracking

Track all searches in `06_metadata/search_log.csv`:
```csv
timestamp,tool,query,result_count,status
2025-01-19T14:30:00,websearch,quantum computing,10,success
```

## Cost Estimates

- WebSearch: ~$0.001 per search (estimated)
- WebFetch: ~$0.002 per fetch (estimated)
- Quick Research: ~$0.02 total
- Comprehensive Research: ~$0.10 total

## Resume Capability

To resume research:
1. Read RESEARCH_LOG.md
2. Check 06_metadata/search_log.csv
3. Load existing search results from 01_searches/
4. Continue from last incomplete task

## Best Practices

1. **Always use TodoWrite** to track progress
2. **Save search results immediately** before processing
3. **Use specific search queries** for better results
4. **Batch WebFetch calls** when possible
5. **Update RESEARCH_LOG.md** after each phase

## Commands

### Quick Setup Script
```bash
./quick_research.sh
```
This interactive script:
- Prompts for research topic
- Creates project folder with proper naming convention
- Copies template structure
- Updates PROJECT_CONFIG.json and RESEARCH_LOG.md
- Copies the appropriate magic command to clipboard
- Optionally opens project in Cursor

### Manual Commands
```bash
# Start new research
mkdir Research_[TOPIC]_$(date +%Y%m%d_%H%M%S)

# Copy template
cp -r Claude_Code_Research_Template/* Research_[TOPIC]_[DATE]/

# Track searches
echo "timestamp,tool,query,result_count,status" > 06_metadata/search_log.csv

# Create all subdirectories
mkdir -p {01_searches,02_fetched_content,03_extracted_data,04_analysis,05_synthesis,06_metadata}
```

### Utility Scripts
```bash
# Switch between Klaviyo accounts (for MCP testing)
./switch-klaviyo.sh [waterloo|acme|retail]
```

## Important Implementation Details

1. **CHECK FOR MCP TOOLS FIRST**: Always check if MCP tools are available (look for `mcp__` prefixed functions). If Firecrawl or other MCP tools are available, use them instead of WebSearch/WebFetch
2. **Project Creation**: When a user types a magic command, immediately create the project folder using the template unless resuming
3. **File Saving**: Always save search results and fetched content immediately after obtaining them
4. **Error Handling**: If WebFetch fails on a URL, log it and continue with remaining URLs
5. **Progress Updates**: Update RESEARCH_LOG.md after completing each major phase
6. **Cost Tracking**: Update actual costs in PROJECT_CONFIG.json after execution

## Tool Priority Order

When conducting research, use tools in this priority:
1. **MCP Tools (ALWAYS CHECK FIRST)**:
   - `mcp__firecrawl__` for web scraping
   - `mcp__perplexity__` for AI search
   - `mcp__tavily__` for web research
   - `mcp__playwright__` for complex page interactions
   - `mcp__reddit__` for Reddit-specific searches
   - `mcp__web3_research__` for crypto/blockchain topics
2. **WebSearch** - Only use if MCP search tools fail or are unavailable
3. **WebFetch** - Only use if MCP scraping tools fail or are unavailable
4. **Native tools** for file operations (always available)

## WebFetch Prompts Reference

### For General Information:
- "Extract the key facts, statistics, and main points about [TOPIC] from this content"
- "What are the most important insights about [TOPIC] mentioned in this article?"

### For Technical Content:
- "Extract technical specifications, implementation details, and architecture information"
- "What technologies, frameworks, or methodologies are discussed?"

### For Market Analysis:
- "Extract market size, growth projections, key players, and competitive landscape"
- "What financial data, trends, or forecasts are mentioned?"

### For News Content:
- "Summarize the key developments, announcements, and their implications"
- "What are the dates, companies, and people mentioned in this news?"

## Project Architecture

### Core System Components

1. **Research Automation Engine**
   - Magic word command processor
   - Protocol execution framework
   - Task tracking with TodoWrite
   - Progress logging and resume capability

2. **Template System**
   - `Claude_Code_Research_Template/` - Standard project structure
   - Pre-configured PROJECT_CONFIG.json
   - RESEARCH_LOG.md for progress tracking
   - Organized folder hierarchy for outputs

3. **Tool Integration Layer**
   - MCP tool detection and prioritization
   - Fallback to WebSearch/WebFetch when MCP unavailable
   - Unified interface for search and scraping operations

### PublicRecordsMCP Subsystem

**MOVED TO**: `/Users/skipmatheny/Documents/cursor/Waterloo/PublicRecordsMCP/`

The PublicRecordsMCP subsystem is a complete Next.js application for aggregating public records:

- **Purpose**: Real estate intelligence platform
- **Tech Stack**: Next.js, TypeScript, Vercel Postgres, Stripe
- **Data Sources**: CKAN portals, FBI API, EPA data, Census data
- **Key Features**: 
  - CSV intelligence with smart indexing
  - API key management system
  - Subscription handling via Stripe
  - Background data ingestion processes

**Note**: This is a separate project now located in the Waterloo directory.

## Common Errors and Troubleshooting

### MCP Tool Failures

#### Error: "mcp__[tool]__ is not a function"
**Cause**: MCP tool not available in current Cursor session
**Solutions**:
1. Check if tool is installed: `claude mcp list`
2. Restart Cursor to reload MCP tools
3. Fall back to WebSearch/WebFetch as specified in protocols

#### Error: "API key invalid" for MCP tools
**Cause**: Expired or incorrect API keys
**Solutions**:
1. Check MCP_SETUP_STATUS.md for correct keys
2. Update keys: `claude mcp remove [tool]` then re-add with new key
3. For Firecrawl/Tavily/Perplexity, verify keys are still active

### Research Protocol Issues

#### Error: "WebFetch failed on URL"
**Cause**: Site blocking automated access or timeout
**Solutions**:
1. Log the error and continue with remaining URLs
2. Try using MCP tools (Firecrawl, Playwright) for difficult sites
3. Use different search queries to find alternative sources

#### Error: "Search returned 0 results"
**Cause**: Too specific query or API issue
**Solutions**:
1. Broaden search terms
2. Remove year filters if searching historical data
3. Try alternative search tools (Perplexity, Tavily)

### File System Errors

#### Error: "Permission denied" when creating research folders
**Cause**: File system permissions
**Solutions**:
1. Check write permissions in Claude-Code-Research directory
2. Run: `chmod 755 quick_research.sh`
3. Manually create folder if script fails

#### Error: "Template not found"
**Cause**: Claude_Code_Research_Template missing or moved
**Solutions**:
1. Verify template exists: `ls Claude_Code_Research_Template/`
2. Check path in quick_research.sh script
3. Recreate template structure if missing

### Shell Script Errors

#### Error: "command not found: pbcopy" (non-macOS)
**Cause**: pbcopy is macOS-specific
**Solutions**:
1. Linux: Install xclip and use `xclip -selection clipboard`
2. Windows: Use `clip` command
3. Manually copy the magic command from terminal output

#### Error: "bad substitution" in quick_research.sh
**Cause**: Shell compatibility issue
**Solutions**:
1. Ensure using bash: `#!/bin/bash` at script start
2. Run explicitly: `bash quick_research.sh`
3. Check for special characters in topic name

### Klaviyo MCP Errors

#### Error: "API key not set" for switch-klaviyo.sh
**Cause**: Placeholder keys in script
**Solutions**:
1. Replace `pk_waterloo_key_here` with actual keys
2. Store keys in environment variables for security
3. Use: `export KLAVIYO_WATERLOO_KEY=your_key`

### Cost Tracking Issues

#### Error: "Exceeded budget" warnings
**Cause**: More searches/fetches than estimated
**Solutions**:
1. Use QUICK RESEARCH instead of COMPREHENSIVE
2. Limit fetches to most relevant URLs
3. Check PROJECT_CONFIG.json for actual vs estimated costs

### Resume Function Errors

#### Error: "Cannot resume - no search data found"
**Cause**: Search results not saved properly
**Solutions**:
1. Always save to `01_searches/` immediately after searching
2. Check search_log.csv for completed searches
3. Re-run searches if data is missing

### PublicRecordsMCP Subsystem Errors

#### Error: "Database connection failed"
**Cause**: Missing environment variables
**Solutions**:
1. Run: `npm run env:pull` to get Vercel vars
2. Check `.env.local` has all required values
3. Test with: `npm run test:db`

#### Error: "Type errors" during build
**Cause**: TypeScript strict mode issues
**Solutions**:
1. Run: `npx tsc --noEmit` to check types
2. Fix errors before deploying
3. Use `npm run dev:clean` for fresh start