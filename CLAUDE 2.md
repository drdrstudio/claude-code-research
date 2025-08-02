# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

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

The PublicRecordsMCP subsystem (moved to `/Users/skipmatheny/Documents/cursor/Waterloo/PublicRecordsMCP/`) contains a complete Next.js application for aggregating public records:

- **Purpose**: Real estate intelligence platform
- **Tech Stack**: Next.js, TypeScript, Vercel Postgres, Stripe
- **Data Sources**: CKAN portals, FBI API, EPA data, Census data
- **Key Features**: 
  - CSV intelligence with smart indexing
  - API key management system
  - Subscription handling via Stripe
  - Background data ingestion processes

**Note**: This is a separate project included for reference and testing of MCP integrations.