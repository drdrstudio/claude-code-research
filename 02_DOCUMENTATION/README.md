# Claude Code Research System

A streamlined research automation framework for conducting systematic research using Claude Code in Cursor. This framework leverages all available tools including MCP (Model Context Protocol) integrations when available in Cursor, with WebSearch and WebFetch as reliable fallbacks.

## 🚀 Quick Start

```bash
./quick_research.sh
```

Enter your topic and the script will:
1. Create a research project folder
2. Copy the command to your clipboard
3. Open in Cursor (optional)

## 📚 Available Commands

### Magic Words for Claude Code:

- **COMPREHENSIVE RESEARCH on [TOPIC]** - Full research with multiple searches
- **QUICK RESEARCH on [TOPIC]** - Fast overview (3 searches, 5 fetches)
- **RESUME RESEARCH [NAME]** - Continue existing research
- **DEEP DIVE on [TOPIC]** - Extended analysis
- **NEWS SCAN on [TOPIC]** - Latest developments

## 🛠️ Tools Used

### MCP Tools (Currently enabled in Cursor):
- **Firecrawl** (`mcp__firecrawl__`) - Advanced web scraping (8 tools)
- **Perplexity** (`mcp__perplexity__`) - AI search and synthesis (1 tool)
- **Playwright** (`mcp__playwright__`) - Browser automation (24 tools)
- **Tavily** (`mcp__tavily__`) - Web research (4 tools)
- **Reddit** (`mcp__reddit__`) - Reddit search/analysis (12 tools)
- **Web3 Research** (`mcp__web3_research__`) - Crypto/blockchain (10 tools)

### Core Tools (Always available):
- **WebSearch** - Web searching capability
- **WebFetch** - Content fetching and AI analysis
- **TodoWrite** - Task tracking
- Native file operations (Read, Write, Edit)

## 📁 Project Structure

```
Research_[TOPIC]_[DATE]/
├── 01_searches/          # WebSearch results
├── 02_fetched_content/   # WebFetch results
├── 03_extracted_data/    # Structured data
├── 04_analysis/          # Analysis documents
├── 05_synthesis/         # Final reports
├── 06_metadata/          # Tracking data
├── RESEARCH_LOG.md       # Progress tracker
└── PROJECT_CONFIG.json   # Configuration
```

## 🔧 Tools Used in This Framework

- **WebSearch** - Claude Code's built-in web search capability
- **WebFetch** - Content fetching and AI-powered analysis
- **TodoWrite** - Task tracking and progress management
- **Native file operations** - Read, Write, Edit, MultiEdit
- **Bash** - System commands and automation
- **Grep/Glob** - File searching and pattern matching

## 💡 Best Practices

1. **Always use TodoWrite** to track progress
2. **Save search results immediately** 
3. **Use specific search queries**
4. **Batch operations when possible**
5. **Update RESEARCH_LOG.md regularly**

## 📊 Example Workflow

1. Run `./quick_research.sh`
2. Enter topic: "quantum computing"
3. Paste command in Claude Code
4. Claude Code will:
   - Search for information
   - Fetch relevant content
   - Analyze findings
   - Generate reports

## 🔧 Manual Setup

```bash
# Create project
mkdir Research_YourTopic_$(date +%Y%m%d)
cd Research_YourTopic_*

# Copy template
cp -r ../Claude_Code_Research_Template/* .

# Start research
# Tell Claude Code: "COMPREHENSIVE RESEARCH on YourTopic"
```

## 📈 Cost Estimates

- Quick Research: ~$0.02
- Comprehensive Research: ~$0.10
- Deep Dive: ~$0.25

## 🤝 Contributing

This system is designed to be extended. Feel free to:
- Add new research protocols
- Create specialized templates
- Improve automation scripts