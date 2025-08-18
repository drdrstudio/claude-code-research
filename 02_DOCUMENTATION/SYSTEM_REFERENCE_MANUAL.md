1. System Status & Capabilities
Current Version: MRP v6.1 - Production Ready

Architecture: Factory → Architect → Lab (Fully Automated)

Key Feature: Automated Mega-Analysis via run-mega-analysis.sh

Advanced Synthesis: Gemini API integration for strategic intelligence

Knowledge Graphs: Neo4j integration with automated entity extraction

Available MCP Tools (Priority Order)
Sequential-Thinking - Complex analysis and planning

Firecrawl-MCP - Primary web scraping (mandatory)

Perplexity-MCP - AI-powered search and synthesis

Tavily-MCP - Comprehensive web research

Playwright - Browser automation for complex sites

Reddit-MCP - Community insights and sentiment

CLI Access Requirements
The system requires verified access to the following CLIs: Vercel, Wrangler, Supabase, Stripe, NPM, GitHub (gh), Redis, Playwright, ngrok, Ingest, nlm, pandoc, tectonic, jq, and the Gemini API.

2. First Session Checklist for New Claudes
When starting a new session, the Operator must immediately verify:

✅ 1. Constitution Acknowledgment: Begin with "Heard Chef." + MD5 checksum from claude.md.
✅ 2. Protocol Access: Confirm you can read the latest MRP_v6.1.md.
✅ 3. Environment Variables: Verify GEMINI_API_KEY is set.
✅ 4. MCP Tools: Check available tools with claude mcp list.
✅ 5. Script Access: Confirm executable scripts in the research directory.
✅ 6. Project Context: If resuming work, read RESEARCH_LOG.md and PROJECT_CONFIG.json.

3. Quick Reference - Most Common Commands
Research Initiation
DEEP DIVE on [TOPIC]              # Full 7-phase research with Gemini synthesis
COMPREHENSIVE RESEARCH on [TOPIC] # Standard research without mega-analysis  
GTM-CAMPAIGN on [TOPIC]          # Go-to-market focused research
Project Management
FINISH AND UPLOAD [Project_Name]  # Complete finalization protocol
RESUME RESEARCH [Project_Name]    # Continue existing research
Utility Scripts
./run-mega-analysis.sh [Project]  # Automated 3-stage advanced synthesis
./build-knowledge-graph.sh [Project] # Create Neo4j knowledge graph
./get-project-manifest.sh [Project]  # Prepare for Architect handoff
4. Environment Setup Guide
Required Environment Variables
Bash

# Essential for automated mega-analysis
export GEMINI_API_KEY="your_gemini_api_key_here"

# Optional but recommended
export FIRECRAWL_API_KEY="your_firecrawl_key"  
export PERPLEXITY_API_KEY="your_perplexity_key"
export TAVILY_API_KEY="your_tavily_key"
Secure API Key Setup
NEVER share API keys in chat. Set them securely in your shell profile (.zshrc, .bashrc, etc.):

Bash

echo 'export GEMINI_API_KEY="your_key_here"' >> ~/.zshrc
source ~/.zshrc
5. Troubleshooting Guide
"GEMINI_API_KEY not set":

Solution: Set the environment variable as shown in the setup guide.

"MCP tool not available":

Solution: Run claude mcp list to check available tools. Use WebSearch/WebFetch as a fallback.

"Project folder not found":

Solution: Verify the full path from the research directory root.

"Knowledge graph build failed":

Solution: Requires key_entities.json and network_map.json in 03_extracted_data/. Run ./auto-extract-entities.sh [Project] first.

6. System Changelog
(This section should be updated as you make major changes to the system)

v6.1: Refactored system into Constitution/Protocol/Manuals. Added verifiability checks (SQS, Cross-Verification), optional approval gates, and explicit sub-agent definitions.

v6.0.3: Fixed PDF generation logo display and citation implementation.

v6.0.2: Implemented enterprise PDF generation system with client branding.

v6.0.1: Enhanced run-mega-analysis.sh with robust batch processing.