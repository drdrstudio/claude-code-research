# 🚨 CLAUDE CODE CLI - MCP MASTER GUIDE
## The Definitive Solution to "Why Can't Claude See My MCPs?"

**CRITICAL FOR ALL FUTURE CLAUDE SESSIONS - READ THIS FIRST!**

## 📌 HOW TO MAKE CLAUDE READ THIS AT SESSION START

### Option 1: Direct Command (RECOMMENDED)
Start your session with:
```
Read /Users/skipmatheny/Documents/cursor/Claude-Code-Research/00_SYSTEM/CLAUDE_CLI_MCP_MASTER_GUIDE.md and confirm understanding with "Heard, Chef"
```

### Option 2: CLAUDE.md Integration
Add this to your CLAUDE.md file in project root:
```markdown
## MANDATORY FIRST ACTION
Read and follow: 00_SYSTEM/CLAUDE_CLI_MCP_MASTER_GUIDE.md
Confirm with "Heard, Chef" before any other actions.
```

### Option 3: Alias/Function in Shell
Add to ~/.zshrc or ~/.bashrc:
```bash
alias claude-gtm='claude "First, read 00_SYSTEM/CLAUDE_CLI_MCP_MASTER_GUIDE.md and confirm with Heard, Chef"'
```

### Option 4: Project Settings
Create `.claude/settings.local.json` with:
```json
{
  "customInstructions": "MANDATORY: Read 00_SYSTEM/CLAUDE_CLI_MCP_MASTER_GUIDE.md first. Confirm with 'Heard, Chef'",
  "requireConfirmation": true
}
```

---

## 🎯 FOR GTM PROFESSIONALS (NON-DEVELOPERS)

### WORKING REQUIREMENTS - MANDATORY ACKNOWLEDGMENT

**Every Claude session MUST start responses with "Heard, Chef" to confirm these requirements are understood.**

### Your Claude Code Operating Principles

**YOU ARE NOT A DEVELOPER** - Claude must understand this and act accordingly:

1. **Hand-Holding Mode**: Explain technical decisions in business terms
2. **Senior Dev Mode**: Take full ownership like a senior developer would
3. **No Fabrication**: NEVER say "done" without testing. NEVER make up results.
4. **Realistic Expectations**: No false optimism. If something will be hard, say so.
5. **Test Everything**: Every change must be verified before marking complete
6. **NO SIMULATIONS**: We are building PRODUCTS with LIVE DATA, not demos

### Critical Rules for Claude Sessions

```markdown
MANDATORY BEHAVIOR FOR THIS USER:
- I am a GTM expert, NOT a developer
- Start EVERY response with "Heard, Chef" to confirm understanding
- Explain technical concepts in business terms
- Take ownership like a senior dev - don't ask permission for obvious fixes
- ALWAYS test before saying "done"
- Be realistic about challenges and timelines
- If you're not sure something works, SAY SO
- Lost weeks to fabricated "completions" is unacceptable
- NEVER SIMULATE - always use real data and real deployments
```

### Complete Testing Protocol (MANDATORY)

Before EVER saying a task is complete, you MUST:

#### Local Testing
1. Build and run locally
2. Test ALL functionality (not just the part you changed)
3. Check browser console for errors
4. Verify all API calls succeed
5. Test as an actual user would (click buttons, fill forms, etc.)

#### Production Testing
1. Deploy to production environment
2. Actually visit the production URL
3. Test login and all features yourself
4. Pull environment variables back to verify they're set
5. Check production logs for errors
6. Confirm all features work end-to-end

#### Documentation Verification
1. Read the LATEST docs for every platform/service used
2. Verify you're using current APIs (not deprecated)
3. Check for breaking changes in recent updates

**NO EXCEPTIONS. NO "IT SHOULD WORK" STATEMENTS.**

### When Things Break - Debug Protocol

```markdown
STOP AND DEBUG - Don't try multiple fixes:
1. Quote the EXACT error message
2. Explain what the error means in business terms
3. Say "I'm not sure why this is happening, let me investigate" if uncertain
4. Debug the actual root cause before attempting fixes
5. Verify the fix worked by reproducing the original issue
```

### Quality Checklist - BEFORE EVERY "DONE"

Must complete ALL items:
- [ ] Tested the specific feature that was broken
- [ ] Checked for unused imports/variables
- [ ] Verified no new errors were introduced
- [ ] Tested in both local AND production
- [ ] Checked logs in both environments
- [ ] Verified environment variables are correct
- [ ] Tested as a real user would
- [ ] Can show to client immediately

### Expected Standard

```markdown
When you say "done," I should be able to:
1. Show it to a client immediately
2. Have them use it without any issues
3. Not find any errors in console/logs
4. Trust that it works exactly as specified
```

---

## THE CORE PROBLEM

Claude Code CLI sessions CANNOT see MCP tools even when they're configured because:

1. **MCP servers are configured but NOT STARTED** - They exist in config but aren't running
2. **Permissions are set but tools aren't loaded** - `.claude/settings.local.json` shows permissions but tools aren't in session
3. **Project-specific scope** - MCPs are local to each project, not global

## WHERE THINGS ACTUALLY LIVE

### Claude Code CLI Installation
- **Installed via:** `npm install -g @anthropic-ai/claude-code`
- **Location:** `/opt/homebrew/lib/node_modules/@anthropic-ai/claude-code/` (macOS with Homebrew)
- **Binary:** `/opt/homebrew/bin/claude` (symlink)

### MCP Configuration Locations
1. **Project-Level (PRIMARY):**
   - `.claude.json` - Contains MCP server configurations with commands and env vars
   - `.claude/settings.local.json` - Contains permissions for MCPs
   - MCPs are PROJECT-SPECIFIC - each project needs its own setup
   - Scope: "Local config (private to you in this project)"

2. **NOT in these common places:**
   - `~/.config/claude/` - Doesn't exist for CLI
   - `~/.claude/` - Doesn't exist  
   - `~/Library/Application Support/Claude/` - That's Claude Desktop, not CLI

## THE SOLUTION: HOW TO MAKE MCPS VISIBLE

### Step 1: Verify MCP Configuration
```bash
# Check what's configured
claude mcp list

# Should show:
# perplexity: uvx perplexity-mcp - ✓ Connected
# firecrawl-mcp: npx -y firecrawl-mcp - ✓ Connected
# etc.
```

### Step 2: MCPs Load Automatically (UPDATE: No server needed!)
```bash
# MCPs now load automatically when you start Claude CLI
# Just restart Claude to load newly configured MCPs:
exit  # Exit current session
claude  # Start new session - MCPs will be available
```

### Step 3: For New Claude Sessions

**TELL EVERY NEW CLAUDE THIS:**

```markdown
I'm using Claude Code CLI (not Desktop). To access MCP tools:

1. Run: `claude mcp list` to verify they're configured
2. If not visible as tools, the MCP server may need to be started
3. Check `.claude/settings.local.json` for permissions
4. MCPs are project-specific, stored in: Local config (private to this project)
```

## WHY CLAUDE CLI DOESN'T SEE TOOLS "OUT OF THE GATE"

### The Architecture Issue:
1. **Claude Code CLI** starts as a client
2. **MCP servers** are separate processes that must be running
3. **The bridge** between them requires:
   - MCP server to be configured (`claude mcp add`)
   - Permissions to be set (`.claude/settings.local.json`)
   - Server to be running (`claude mcp serve`)
   - Claude session to connect to the server

### What Actually Happens:
- When you run `claude` command, it starts a Claude session
- MCPs configured with `claude mcp add` are loaded at session start
- Tools become available IF the MCP server can connect successfully
- "Connected" in `claude mcp list` doesn't guarantee tools are loaded in current session
- You need to EXIT and RESTART Claude for newly added MCPs to be available

## THE PERMANENT FIX

### Add to your shell profile (~/.zshrc or ~/.bashrc):
```bash
# Quick MCP setup for new projects
claude-mcp-setup() {
    echo "Setting up MCPs for this project..."
    ~/Documents/cursor/Claude-Code-Research/00_SYSTEM/setup-all-mcps.sh
    echo "MCPs configured! Restart Claude to use them."
}

# Alias to remind you about MCP setup
alias claude-check='claude mcp list && echo "If MCPs show failed, exit and restart Claude"'
```

### For Project Setup:
```bash
# 1. Configure all MCPs (one time)
./00_SYSTEM/setup-mcp-servers.sh

# 2. Create project initialization script
cat > init-claude.sh << 'EOF'
#!/bin/bash
echo "Initializing Claude with MCP tools..."
claude mcp list
claude mcp serve -d &
echo "MCP server started. You can now use Claude with full MCP access."
EOF

chmod +x init-claude.sh
```

## VERIFICATION CHECKLIST

When MCP tools ARE working, you should see:
- `mcp__perplexity__perplexity_search_web` in available tools
- `mcp__firecrawl__firecrawl_scrape` in available tools
- `mcp__tavily__` functions available
- etc.

When they're NOT working, you'll only see:
- Basic tools (Read, Write, Bash, WebSearch, WebFetch)
- `mcp__ide__` tools (if in an IDE context)

## TROUBLESHOOTING

### Common MCP Issues & Solutions

#### "MCP tools in permissions but not available"
```bash
# Solution:
claude mcp serve  # Start the server!
```

#### "No MCP servers configured"
```bash
# Solution:
./00_SYSTEM/setup-mcp-servers.sh
# OR
claude mcp add [server-name] [command] [args]
```

#### "MCP server won't start"
```bash
# Check for port conflicts
lsof -i :3000  # Or whatever port MCP uses

# Kill existing MCP processes
pkill -f "claude mcp serve"

# Restart with debug
claude mcp serve --debug
```

#### "Firecrawl/Tavily failing with timeout"
- **Issue**: Large sites or slow servers
- **Solution**: Use smaller crawl depths, specific URL patterns
- **Fallback**: Switch to WebFetch for individual pages

#### "DataForSEO returning empty results"
- **Issue**: Location/language mismatch or API limits
- **Solution**: Use "United States" and "en" as defaults
- **Check**: API credits and rate limits

#### "Playwright browser not launching"
- **Issue**: Missing browser installation or permissions
- **Solution**: `mcp__playwright__browser_install`
- **Alternative**: Use Firecrawl for most scraping needs

#### "Sequential Thinking getting stuck"
- **Issue**: Complex nested logic or infinite loops
- **Solution**: Set clear completion criteria, use simpler prompts
- **Tip**: Break into smaller sequential thinking sessions

#### "Reddit MCP authentication errors"
- **Issue**: Rate limits or API changes
- **Solution**: Wait 60 seconds between requests
- **Fallback**: Use web search for Reddit content

## PRACTICAL MCP USAGE PATTERNS

### When to Use Each MCP (Quick Reference)

#### 🔍 **Web Research & Content (PRIORITY ORDER)**
1. **Perplexity + Firecrawl** (BEST COMBINATION): 
   - Use Perplexity for intelligent search and synthesis
   - Use Firecrawl for deep content extraction
   - This combo provides best research results
   
2. **Firecrawl** (DEEP SCRAPING): Best for crawling entire sites, extracting specific pages
   - `mcp__firecrawl__firecrawl_scrape` - Single page extraction
   - `mcp__firecrawl__firecrawl_search` - Web search with content extraction
   - `mcp__firecrawl__firecrawl_deep_research` - Comprehensive research on a topic

3. **Perplexity** (INTELLIGENT SEARCH): AI-powered search with synthesis
   - Better than Tavily for most use cases
   - Provides contextualized answers, not just links
   
4. **Tavily** (LAST RESORT): Only when Perplexity fails
   - Can be useful for news/current events
   - Generally inferior to Perplexity

#### 💭 **Complex Analysis**
- **Sequential Thinking**: For multi-step problems, planning, hypothesis testing
  - Use when: Breaking down complex issues, need structured thinking
  - Example: Risk assessment, strategic planning, debugging complex issues

#### 🌐 **Community & Social**
- **Reddit**: Community sentiment, user discussions, trend analysis
  - Use for: Product feedback, community research, trending topics

#### 🤖 **Browser Automation**
- **Playwright**: When you need to interact with dynamic websites
  - Login required sites, JavaScript-heavy pages, form submissions
  - Screenshots for visual verification

#### 📊 **SEO & Marketing**
- **DataForSEO**: Keyword research, SERP analysis, backlinks, competitor analysis
  - Use for: SEO audits, content strategy, competitive intelligence
  - Note: Can be expensive, use judiciously

#### 🔧 **Workflow Automation**
- **n8n**: Workflow management, automation chains
  - Use for: Complex multi-step automations, system integrations

### Common MCP Patterns

```bash
# Pattern 1: Deep Research Flow
1. mcp__firecrawl__firecrawl_search → Get initial results
2. mcp__firecrawl__firecrawl_scrape → Extract specific pages
3. mcp__sequential_thinking → Analyze and synthesize

# Pattern 2: SEO Content Research
1. mcp__dataforseo__keywords_data → Find keywords
2. mcp__firecrawl__firecrawl_search → Research top content
3. mcp__reddit → Check community discussions

# Pattern 3: Competitor Analysis
1. mcp__dataforseo__competitors_domain → Find competitors
2. mcp__firecrawl__firecrawl_crawl → Crawl competitor sites
3. mcp__tavily__tavily_extract → Extract specific data
```

## THE GOLDEN RULE

**Every new Claude Code CLI session needs to be told:**

1. Check if MCPs are running: `claude mcp list`
2. If tools aren't available but MCPs show as configured, start server: `claude mcp serve`
3. MCPs are PROJECT-SPECIFIC - each project needs its own configuration
4. The config lives in Claude CLI's internal database, not in visible config files

## 🛠️ CODING MCPs FOR NON-DEVELOPERS

### Recommended Additional MCPs to Install

Given your GTM background and need for senior dev support, consider these:

1. **GitHub Copilot MCP** (if available)
   - Provides code suggestions and completions
   - Helps with common patterns

2. **Stack Overflow MCP** (if available)
   - Quick access to solutions for common problems
   - Community-validated answers

3. **Desktop Commander** (YOU HAVE THIS!)
   - File operations without complex commands
   - Process management simplified
   - Great for non-devs

4. **IDE MCP** (YOU HAVE THIS!)
   - Direct code execution in Jupyter
   - Real-time error diagnostics from VS Code
   - CRITICAL for testing

### How to Use Your Existing MCPs for Coding

#### Desktop Commander (Your Best Friend)
```bash
# Instead of complex bash commands, use:
mcp__desktop-commander__read_file(path="/path/to/file")
mcp__desktop-commander__write_file(path="/path/to/file", content="...")
mcp__desktop-commander__list_directory(path="/path")
mcp__desktop-commander__search_code(path="/", pattern="function_name")
```

#### IDE MCP for Testing
```python
# ALWAYS test code before saying it's done:
mcp__ide__executeCode(code="print('Testing...')")
mcp__ide__getDiagnostics()  # See real errors
```

### Coding Best Practices for GTM Users

1. **Start Simple**: Build incrementally, test each piece
2. **Use Templates**: Find working examples, modify them
3. **Test Constantly**: Every 5-10 lines of code
4. **Document Everything**: Comments explain WHY, not WHAT
5. **Version Control**: Commit working versions before changes

## QUICK REFERENCE - MOST USEFUL MCP COMMANDS

### Essential Commands by Use Case

#### 🔍 Research & Information Gathering
```python
# Quick web search with AI synthesis
mcp__perplexity__perplexity_search_web(query="...", recency="day")

# Deep scrape of a specific page
mcp__firecrawl__firecrawl_scrape(url="...", formats=["markdown"])

# Comprehensive research on a topic
mcp__firecrawl__firecrawl_deep_research(query="...", maxDepth=3)

# Search and extract content
mcp__firecrawl__firecrawl_search(query="...", limit=5, scrapeOptions={"formats": ["markdown"]})
```

#### 📊 SEO & Keywords
```python
# Get search volume for keywords
mcp__dataforseo__keywords_data_google_ads_search_volume(keywords=["..."])

# Find competitor domains
mcp__dataforseo__dataforseo_labs_google_competitors_domain(target="domain.com")

# Keyword suggestions
mcp__dataforseo__dataforseo_labs_google_keyword_suggestions(keyword="...")
```

#### 🤖 Browser Automation
```python
# Navigate and take screenshot
mcp__playwright__browser_navigate(url="...")
mcp__playwright__browser_snapshot()  # Better than screenshot for actions

# Fill forms
mcp__playwright__browser_type(element="...", ref="...", text="...")
mcp__playwright__browser_click(element="...", ref="...")
```

#### 💭 Complex Problem Solving
```python
# Multi-step analysis
mcp__sequential_thinking__sequentialthinking(
    thought="Breaking down the problem...",
    nextThoughtNeeded=True,
    thoughtNumber=1,
    totalThoughts=5
)
```

#### 🌐 Reddit Community Research
```python
# Search Reddit
mcp__reddit__search_reddit(query="...", sort="relevance", limit=10)

# Get subreddit posts
mcp__reddit__get_top_posts(subreddit="...", time_filter="week", limit=10)
```

---

## 🔑 COMPLETE MCP CONFIGURATION WITH API KEYS

### Quick Setup Script for New Projects
Save this as `~/Documents/cursor/Claude-Code-Research/00_SYSTEM/setup-all-mcps.sh`:

```bash
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
```

Then: `chmod +x ~/Documents/cursor/Claude-Code-Research/00_SYSTEM/setup-all-mcps.sh`

## FOR FUTURE CLAUDES - COPY THIS PROMPT:

```
I need to use MCP tools. Please:
1. Run `claude mcp list` to check configuration
2. If tools aren't in your available tools list, note that `claude mcp serve` may need to be run
3. Check `.claude/settings.local.json` for permissions
4. Remember MCPs are project-specific in Claude Code CLI

Quick MCP priority:
- Research: Perplexity + Firecrawl combo (BEST)
- Web scraping: Firecrawl > WebFetch (skip Tavily)
- Search: Perplexity > Firecrawl > Tavily (last resort)
- SEO: DataForSEO (use sparingly - expensive)
- Complex analysis: Sequential Thinking
- Browser automation: Playwright
- Coding help: Desktop Commander + IDE MCP for testing

CRITICAL FOR GTM USER:
- You're NOT a developer - explain in business terms
- Act like a senior dev - take ownership
- ALWAYS test before saying "done"
- Be realistic about challenges
- NO fabrication or false completions
```

---

**Last Updated:** January 2025
**Applies to:** Claude Code CLI (NOT Claude Desktop)
**Critical File:** Save this as `00_SYSTEM/CLAUDE_CLI_MCP_MASTER_GUIDE.md`