#!/bin/bash
#
# This script updates or creates the master research protocol document to version 5.2.
# It contains the full text of the document and will overwrite any existing file.
#

# Define the target file path
TARGET_FILE="~/Documents/cursor/Claude-Code-Research/MRP_v5.2.md"

# Use a heredoc to write the full content to the target file.
# The 'EOF' is quoted to prevent shell expansion of any variables inside the document.
cat <<'EOF' > "$TARGET_FILE"
# MCP-Stacked Research Protocol (MRP)
**Version:** 5.2
**Status:** Final, Configuration-Driven

## 1. Overview
This document is the single source of truth for the MRP, a systematic framework for conducting AI-assisted research. It uses a configuration-driven, multi-phase process to ensure all research is comprehensive, auditable, and cost-aware.

## 2. Core Architecture: Configuration-Driven Protocol
This system is driven by a `PROJECT_CONFIG.json` file, generated and approved at the start of each mission. This file dictates the scope, tools, optional modules, and final deliverables for the entire workflow.

## 3. The Official MCP Toolkit
| Category          | MCP Name              | Role & Key Function           | Proxy Use    | Status       |
| :---------------- | :-------------------- | :---------------------------- | :----------- | :----------- |
| **Orchestration** | `Sequential-Thinking` | The Planner                   | No           | Standard     |
| **Web Search** | `Perplexity-MCP`, `Tavily-MCP` | Search & Synthesis Engines    | Recommended  | Standard     |
| **Web Scraping** | `Firecrawl-MCP`       | Default Fetcher/Scraper       | **Mandatory**| Standard     |
|                   | `Playwright`          | Escalation Fetcher            | **Mandatory**| Standard     |
| **SEO & Data** | `DataForSEO-MCP`      | SEO & Keyword Data            | No           | **Optional** |
| **Social** | `Reddit-MCP`, `LinkedIn-MCP` | Sentiment & Professional Vetting | Varies       | Standard     |

## 4. Project Configuration
At the start of each mission, the AI will generate a `PROJECT_CONFIG.json` for user approval.

**Example `PROJECT_CONFIG.json`:**
```json
{
  "profile": "Deep-Dive",
  "topic": "ICP Analysis for Duarte Inc.",
  "primary_objective": "Identify and deeply analyze core challenges, key needs, and major pain points to inform GTM strategy and sales copywriting.",
  "use_dataforseo_mcp": false,
  "perform_mega_analysis": true,
  "default_deliverable": "document",
  "custom_parameters": {
    "target_roles": ["Marketing Director", "VP Marketing", "CMO"],
    "enterprise_focus": true,
    "include_technology_stack": true,
    "include_decision_making_process": true,
    "geographic_scope": "North America + Europe",
    "company_size_range": "1000+ employees"
  }
}
```

## 5. The Master Process (7 Phases)

### Phase 1: Initialization & Configuration
- Create project directory using template structure
- Generate a `PROJECT_CONFIG.json` with mission parameters
- **USER APPROVAL REQUIRED**: User must approve configuration before proceeding
- Initialize RESEARCH_LOG.md and TodoWrite tracking systems

### Phase 2: Planning
- Use Sequential-Thinking MCP to generate detailed task plan
- Break down research objectives into specific, actionable steps
- Identify key research questions and success criteria
- Plan resource allocation and timeline estimates

### Phase 3: Search (Approval Gate)
- **APPROVAL GATE**: Propose targeted queries for user approval before execution
- Execute 8-12 targeted searches using approved MCP tools:
  - **Perplexity-MCP**: AI-powered synthesis searches
  - **Tavily-MCP**: Comprehensive web research  
  - **Reddit-MCP**: Community sentiment and insights
- Save all search results to `01_searches/` with timestamped filenames

### Phase 4: Fetch (Approval Gate)
- **APPROVAL GATE**: Propose Primary List of 8-10 high-value URLs for user approval
- Generate secondary Reserve List of 10 additional URLs
- **IMPORTANT**: Only fetch from Reserve List if explicitly instructed by user
- Execute content extraction using:
  - **Firecrawl-MCP**: Primary content extraction tool
  - **Playwright**: For complex sites requiring browser automation
- Save all content to `02_fetched_content/` with detailed analysis

### Phase 5: Structuring & Analysis
- Execute `auto-extract-entities.sh` script to create structured JSON files
- Generate `key_entities.json` and `network_map.json`
- Create comprehensive analysis documents in `04_analysis/`
- **Standard Deliverable**: For GTM missions, generate `Sales_Copywriting_Guide.md`

### Phase 6: Advanced Synthesis (Optional)
- **Conditional**: Only if `perform_mega_analysis` is true in PROJECT_CONFIG.json
- Protocol concludes by instructing user to run `run-mega-analysis.sh`
- Orchestrator script manages three-stage synthesis automatically via Gemini API
- Generates advanced synthesis reports and cross-analysis documents

### Phase 7: Finalization & Delivery
- Execute FINISH AND UPLOAD protocol
- Generate final deliverables based on `default_deliverable` configuration
- Execute `build-knowledge-graph.sh` for Knowledge Graph creation
- **Standard Deliverable**: Generate `Knowledge_Graph_Visualization.md` using Mermaid syntax
- Run `upload-to-notebooklm.sh` for final indexing and upload

## 6. Standard Deliverables
Based on the mission type, the system proactively generates high-value assets:

### GTM Missions
- `Sales_Copywriting_Guide.md` - Standard output of Phase 5
- Executive Summary targeting C-suite decision makers
- Competitive analysis and positioning documents
- Target audience analysis and messaging frameworks

### Knowledge Graph Missions  
- `Knowledge_Graph_Visualization.md` using Mermaid syntax - Standard output of Phase 7
- Entity relationship maps and network analysis
- Structured JSON files for Neo4j database ingestion
- Interactive knowledge exploration guides

### All Missions
- Executive Summary appropriate for stakeholder briefings  
- Comprehensive Research Report with detailed findings
- RESEARCH_LOG.md with complete audit trail
- Structured metadata and source attribution

## 7. Strategic Options

### Gemini Deep Dive
For broad, exploratory "unknown unknowns" research:
- User can request Gemini-led deep dive via Gemini API
- Resulting document serves as foundational source material  
- Can be used to seed new MRP project with focused objectives
- Ideal for market discovery and opportunity identification

### Knowledge Graph Integration
After Phase 5 completion:
- Run `build-knowledge-graph.sh` script to ingest structured JSON
- Creates queryable intelligence asset in local Neo4j database
- Enables cross-project entity relationship analysis
- Supports advanced pattern recognition and insight discovery

## 8. Configuration Options

### Research Profiles
- **Quick Research**: 3 searches, 5 fetches, basic synthesis
- **Comprehensive**: 6 searches, 10 fetches, full analysis
- **Deep Dive**: 10+ searches, 15+ fetches, extensive synthesis

### Optional Modules
- `use_dataforseo_mcp`: Enable SEO and keyword analysis
- `perform_mega_analysis`: Enable advanced synthesis workflows
- `include_compensation_data`: Include salary/compensation research
- `geographic_scope`: Specify regional focus
- `company_size_range`: Target specific organization sizes

### Deliverable Types
- **document**: Comprehensive PDF report via Pandoc
- **presentation**: Marp-based slide deck
- **both**: Generate both document and presentation

## 9. File Organization & Naming Conventions

### Directory Structure
```
Research_[Profile]_[Topic]_[YYYYMMDD_HHMMSS]/
├── 00_LOGS/
│   └── RESEARCH_LOG.md
├── 01_searches/
├── 02_fetched_content/
├── 03_extracted_data/
├── 04_analysis/
├── 05_synthesis/
├── 06_metadata/
└── PROJECT_CONFIG.json
```

### File Naming Convention
`YYYYMMDD_HHMMSS_[tool]_[operation]_[identifier].[ext]`

Example: `20250804_143025_firecrawl_enterprise_marketing_challenges.md`

## 10. Quality Standards & Requirements

### Research Quality
- Minimum 3 independent source verification for key claims
- Bias detection and source diversity requirements
- Fact-checking against authoritative sources
- Citation and attribution standards

### Deliverable Quality
- Executive summaries must be C-suite appropriate
- All reports must be factual, non-advisory per CLAUDE.md
- Presentations must follow design playbook requirements
- Documents must pass spell-check and formatting standards

## 11. Cost Management & Optimization

### Budget Guidelines
- Quick Research: ~$0.05
- Comprehensive: ~$0.15
- Deep Dive: ~$0.35
- Track actual costs in PROJECT_CONFIG.json

### Optimization Strategies
- Batch MCP operations when possible
- Prioritize high-value sources for extraction
- Use Sequential-Thinking for complex analysis only
- Monitor and report cost overruns

## 12. Error Handling & Recovery

### Common Issues
- MCP tool unavailability: Fall back to WebSearch/WebFetch
- Source access failures: Log and continue with alternatives
- Budget overruns: Pause and request approval
- Quality issues: Implement review and revision cycles

### Recovery Procedures
- All research is resumable via RESEARCH_LOG.md
- Search results are preserved for replay
- Partial deliverables can be completed independently
- Configuration changes mid-mission require re-approval

EOF

echo "✅ Success! The update script 'update-protocol-doc.sh' has been created."
echo "Make it executable with 'chmod +x update-protocol-doc.sh' and then run it to update your protocol."