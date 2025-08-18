#!/bin/bash

# Enhanced Reputational Scan Dispatcher v4.0
# Implements the Mission Briefing requirements for deep reputational intelligence

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'
BOLD='\033[1m'

# Arguments
PROJECT_PATH="$1"
TARGET_NAME="$2"

# System paths
SYSTEM_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SYSTEM_DIR")"

echo -e "${CYAN}${BOLD}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}${BOLD}║   $5K REPUTATIONAL INTELLIGENCE SCAN v5.0                   ║${NC}"
echo -e "${CYAN}${BOLD}║   Premium Forensic-Level Deep Research                      ║${NC}"
echo -e "${CYAN}${BOLD}╚══════════════════════════════════════════════════════════════╝${NC}"

echo -e "\n${GREEN}Target:${NC} ${BOLD}${TARGET_NAME}${NC}"
echo -e "${GREEN}Project:${NC} ${PROJECT_PATH}"
echo -e "${GREEN}Protocol:${NC} MRP v6.1.2 with Mission Briefing v4.0"

# Create project structure
echo -e "\n${YELLOW}Creating enhanced project structure...${NC}"
mkdir -p "${PROJECT_PATH}/01_searches"
mkdir -p "${PROJECT_PATH}/02_fetched_content"
mkdir -p "${PROJECT_PATH}/03_extracted_data"
mkdir -p "${PROJECT_PATH}/04_analysis"
mkdir -p "${PROJECT_PATH}/05_synthesis"
mkdir -p "${PROJECT_PATH}/06_metadata"
mkdir -p "${PROJECT_PATH}/07_network_analysis"
mkdir -p "${PROJECT_PATH}/08_second_level_scans"
mkdir -p "${PROJECT_PATH}/09_verification"
mkdir -p "${PROJECT_PATH}/PDFs"

# Copy the mission briefing to the project
cp "${SYSTEM_DIR}/recipe-prompts/reputational-intelligence-prompt.md" "${PROJECT_PATH}/MISSION_BRIEFING.md"

# Create enhanced research log
cat > "${PROJECT_PATH}/RESEARCH_LOG.md" << EOF
# Reputational Intelligence Research Log
## Target: ${TARGET_NAME}
## Protocol: MRP v6.1.2 | Mission Briefing v4.0
## Started: $(date)

---

### Phase 1: Initialization ✅
- Project structure created
- Mission briefing deployed
- PROJECT_CONFIG.json generated with enhanced parameters

### Phase 2: Planning & Strategy
- Status: Pending
- Sequential Thinking engagement required

### Phase 3: Search Execution
- Status: Pending
- Search Strategist to execute comprehensive queries

### Phase 4: Source Vetting
- Status: Pending
- Librarian to assign SQS scores

### Phase 5: Synthesis
- Status: Pending
- Content stream categorization

### Phase 5.5: Verification
- Status: Pending
- Fact-Checker maximum depth analysis

### Phase 6: Advanced Synthesis
- Status: Pending
- Mega-analysis with Gemini API

### Phase 7: Finalization
- Status: Pending
- Master dossier generation

---

## Investigation Areas Checklist

### Professional History & Business Conduct
- [ ] Employment timeline verification
- [ ] Board positions identified
- [ ] Business ventures catalogued
- [ ] Professional achievements verified
- [ ] Ethics patterns analyzed

### Public Statements & Media
- [ ] Speeches and interviews collected
- [ ] Social media archived
- [ ] Published works catalogued
- [ ] Controversial statements documented
- [ ] Media coverage analyzed

### Online Discourse & Sentiment
- [ ] Reddit discussions analyzed
- [ ] Twitter/X mentions collected
- [ ] LinkedIn activity reviewed
- [ ] News comments analyzed
- [ ] Forum discussions catalogued

### Legal & Financial Records
- [ ] Court filings searched
- [ ] Regulatory actions checked
- [ ] Property records reviewed
- [ ] Political contributions tracked
- [ ] Financial indicators assessed

### Network Analysis
- [ ] Key associates identified
- [ ] Second-level scan targets selected
- [ ] Family members researched
- [ ] Political connections mapped
- [ ] Business partners analyzed

---

## Quality Control Metrics
- Target Pages: 20-50
- Target Citations: 50+
- Source Quality Minimum: 3/5
- Triangulation: Required
- Second-Level Scans: Required

EOF

# Create Source Manifest template
cat > "${PROJECT_PATH}/06_metadata/Source_Manifest.md" << EOF
# Source Manifest for ${TARGET_NAME}
## Quality Standards: SQS 3+ Required

### Tier 1 Sources (SQS 5) - Primary Authority
_Government records, court documents, SEC filings, official biographies_

### Tier 2 Sources (SQS 4) - Established Media
_Major news outlets, established publications, verified interviews_

### Tier 3 Sources (SQS 3) - Professional Networks
_LinkedIn, professional associations, industry publications_

### Tier 4 Sources (SQS 2) - Community Discussion
_Reddit, forums, social media (requires triangulation)_

### Tier 5 Sources (SQS 1) - Unverified
_Blogs, comments, anonymous sources (citation with disclaimer only)_

---

## Approval Status: PENDING
EOF

# Create the instruction file for Claude
cat > "${PROJECT_PATH}/CLAUDE_INSTRUCTIONS.md" << EOF
# Instructions for Claude - Reputational Intelligence Scan

## YOUR MISSION - $5,000 VALUE PROPOSITION
You are conducting a forensic-level reputational intelligence scan of ${TARGET_NAME}.
Think like an opposition researcher, deliver like a trusted advisor.
This scan must uncover what a competitor would pay $5K to know about the target.
DEPTH IS EVERYTHING - Speed and cost are irrelevant.

## IMMEDIATE ACTIONS

### 1. Read Required Documents
- Read the MISSION_BRIEFING.md in this project folder
- Read the PROJECT_CONFIG.json to understand all parameters
- Review MRP v6.1.2 protocol requirements

### 2. Engage Sequential Thinking
Use the Sequential Thinking MCP to create a comprehensive research strategy for ${TARGET_NAME}.
This should include:
- Identification of all name variations and aliases
- Priority source identification
- Search query optimization
- Network mapping strategy

### 3. Execute Search Phase
Using the Search Strategist approach, execute searches across:
- Professional databases
- News archives
- Social media platforms
- Legal databases
- Academic repositories

### 4. Source Vetting Protocol
For EVERY source discovered:
1. Assign SQS score (1-5)
2. Extract relevant content
3. Note contradictions
4. Mark for triangulation needs

### 5. Second-Level Scanning
Identify top 5-10 key associates of ${TARGET_NAME} and conduct:
- Criminal record checks
- Controversial statement searches
- Financial scandal searches
- Reputational liability assessment

### 6. Verification Requirements
- Every claim needs 2+ sources
- Contradictions must be documented
- Single-source items labeled as "allegations"
- Generate Verification_Report.md

### 7. Output Generation
The final dossier must include:
- Executive Summary with risk matrix
- Complete biographical overview
- Detailed findings by investigation area
- Network visualization
- Strategic recommendations
- Full citation bibliography (50+ sources)

## QUALITY GATES
Before proceeding between phases, verify:
- Source approval obtained (if interactive mode)
- Outline approval obtained (if required)
- Minimum source count met
- Triangulation completed
- Second-level scans done

## MCP TOOL USAGE - $5K DEPTH PRIORITY
PRIMARY TOOLS (USE FIRST - MAXIMUM EXTRACTION):
- Firecrawl: Deep forensic web scraping (50+ pages per target)
- Perplexity: AI-powered comprehensive search (all variations)

SUPPLEMENTARY DEPTH:
- DataForSEO: Competitive intelligence, keyword vulnerabilities
- Sequential Thinking: Pattern analysis and strategy
- Playwright: Dynamic site extraction
- Reddit MCP: Underground sentiment analysis

LAST RESORT:
- Tavily: Only if all other methods exhausted

## REMEMBER
This is NOT a simulation. Every URL must be real and verified.
Every fact must be sourced. The output must be defensible and professional.
Target: 20-50 pages, 50+ citations, complete triangulation.

Project Path: ${PROJECT_PATH}
Target Individual: ${TARGET_NAME}
Start Time: $(date)
EOF

# Display next steps
echo -e "\n${GREEN}${BOLD}✓ Enhanced reputational scan initialized!${NC}"
echo -e "\n${CYAN}Project Structure Created:${NC}"
echo "  • 9 specialized directories for investigation areas"
echo "  • Mission briefing deployed"
echo "  • Enhanced research log with quality metrics"
echo "  • Source manifest template ready"
echo "  • Claude instructions generated"

echo -e "\n${YELLOW}${BOLD}Next Steps for Claude:${NC}"
echo "1. Read ${PROJECT_PATH}/CLAUDE_INSTRUCTIONS.md"
echo "2. Review PROJECT_CONFIG.json parameters"
echo "3. Engage Sequential Thinking for strategy"
echo "4. Begin Phase 3: Search Execution"

echo -e "\n${CYAN}${BOLD}Quality Standards Enforced:${NC}"
echo "  • Minimum 20 pages required"
echo "  • 50+ source citations mandatory"
echo "  • SQS 3+ for all primary sources"
echo "  • Triangulation required for key claims"
echo "  • Second-level associate scanning required"

echo -e "\n${GREEN}Ready to begin opposition research level scan of ${TARGET_NAME}${NC}"
echo -e "Monitor progress in: ${PROJECT_PATH}/RESEARCH_LOG.md"

# Log the initialization
echo "[$(date)] Reputational Intelligence Scan initialized for ${TARGET_NAME}" >> "${PROJECT_ROOT}/00_SYSTEM/GLOBAL_RESEARCH_INDEX.csv"