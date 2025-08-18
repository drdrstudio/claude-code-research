#!/bin/bash

# Enhanced Organizational Scan Dispatcher v1.0
# Implements the Mission Briefing requirements for deep organizational intelligence

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BLUE='\033[0;34m'
NC='\033[0m'
BOLD='\033[1m'

# Arguments
PROJECT_PATH="$1"
TARGET_NAME="$2"

# System paths
SYSTEM_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SYSTEM_DIR")"

echo -e "${BLUE}${BOLD}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}${BOLD}║   ORGANIZATIONAL INTELLIGENCE SCAN v1.0                     ║${NC}"
echo -e "${BLUE}${BOLD}║   Opposition Research Level Corporate Analysis              ║${NC}"
echo -e "${BLUE}${BOLD}╚══════════════════════════════════════════════════════════════╝${NC}"

echo -e "\n${GREEN}Target Organization:${NC} ${BOLD}${TARGET_NAME}${NC}"
echo -e "${GREEN}Project:${NC} ${PROJECT_PATH}"
echo -e "${GREEN}Protocol:${NC} MRP v6.1.2 with Mission Briefing v1.0"

# Create comprehensive project structure
echo -e "\n${YELLOW}Creating organizational intelligence project structure...${NC}"
mkdir -p "${PROJECT_PATH}/01_searches"
mkdir -p "${PROJECT_PATH}/02_fetched_content/financial"
mkdir -p "${PROJECT_PATH}/02_fetched_content/media"
mkdir -p "${PROJECT_PATH}/02_fetched_content/regulatory"
mkdir -p "${PROJECT_PATH}/03_extracted_data"
mkdir -p "${PROJECT_PATH}/04_analysis/financial"
mkdir -p "${PROJECT_PATH}/04_analysis/market"
mkdir -p "${PROJECT_PATH}/04_analysis/operational"
mkdir -p "${PROJECT_PATH}/05_synthesis"
mkdir -p "${PROJECT_PATH}/06_metadata"
mkdir -p "${PROJECT_PATH}/07_leadership_vetting"
mkdir -p "${PROJECT_PATH}/08_competitor_analysis"
mkdir -p "${PROJECT_PATH}/09_verification"
mkdir -p "${PROJECT_PATH}/PDFs"
mkdir -p "${PROJECT_PATH}/assets/logos"

# Copy the mission briefing
cp "${SYSTEM_DIR}/recipe-prompts/organizational-intelligence-prompt.md" "${PROJECT_PATH}/MISSION_BRIEFING.md"

# Create comprehensive research log
cat > "${PROJECT_PATH}/RESEARCH_LOG.md" << EOF
# Organizational Intelligence Research Log
## Target: ${TARGET_NAME}
## Protocol: MRP v6.1.2 | Mission Briefing v1.0
## Started: $(date)

---

### Phase 1: Initialization ✅
- Project structure created
- Mission briefing deployed
- PROJECT_CONFIG.json generated with enhanced parameters

### Phase 2: Planning & Strategy
- Status: Pending
- Company structure mapping required
- Leadership identification matrix needed

### Phase 3: Search Execution
- Status: Pending
- Financial databases to query
- Media coverage timeline needed

### Phase 4: Source Vetting
- Status: Pending
- Financial verification required
- Source quality assessment

### Phase 5: Synthesis
- Status: Pending
- Four investigation vectors

### Phase 5.5: Verification
- Status: Pending
- Financial data triangulation
- Leadership claims verification

### Phase 6: Advanced Synthesis
- Status: Pending
- Competitive intelligence generation

### Phase 7: Finalization
- Status: Pending
- Master dossier with company logo

---

## Investigation Vectors Checklist

### A. Corporate & Financial Health
- [ ] SEC filings downloaded (10-K, 10-Q, 8-K)
- [ ] Annual reports analyzed
- [ ] M&A history documented
- [ ] Funding rounds tracked
- [ ] Stock performance analyzed
- [ ] Analyst reports collected

### B. Market Position & Public Perception
- [ ] Media coverage timeline created
- [ ] Customer reviews aggregated
- [ ] BBB complaints reviewed
- [ ] Social media sentiment analyzed
- [ ] Reddit discussions collected
- [ ] Brand perception assessed

### C. Operational & Cultural Health
- [ ] Glassdoor analysis completed
- [ ] Indeed reviews analyzed
- [ ] Layoff history documented
- [ ] Litigation records searched
- [ ] Supply chain risks assessed
- [ ] Employee sentiment gauged

### D. Leadership Vetting (Two-Level)
#### Level 1: Identification
- [ ] C-suite executives identified
- [ ] Board of Directors mapped
- [ ] Key SVPs documented
- [ ] Recent departures noted

#### Level 2: Deep Dives
- [ ] CEO background checked
- [ ] CFO financial history reviewed
- [ ] CTO technical credibility assessed
- [ ] Board member conflicts analyzed
- [ ] Past failures documented
- [ ] Legal issues searched

---

## Quality Control Metrics
- Target Pages: 20-50
- Target Citations: 50+
- Source Quality Minimum: 3/5
- Financial Verification: Required
- Leadership Scan Depth: 2 levels
- Competitor Analysis: Required
- Company Logo: Required

EOF

# Create Source Manifest with financial focus
cat > "${PROJECT_PATH}/06_metadata/Source_Manifest.md" << EOF
# Source Manifest for ${TARGET_NAME}
## Quality Standards: SQS 3+ Required | Financial Verification Mandatory

### Tier 1 Sources (SQS 5) - Official Records
_SEC filings, court documents, regulatory filings, patents_
- [ ] SEC EDGAR database
- [ ] State incorporation records
- [ ] Federal court records (PACER)
- [ ] USPTO patent database

### Tier 2 Sources (SQS 4) - Financial & Business
_Bloomberg, Reuters, WSJ, analyst reports, Crunchbase_
- [ ] Financial news outlets
- [ ] Analyst reports
- [ ] Earnings call transcripts
- [ ] Industry reports

### Tier 3 Sources (SQS 3) - Media & Professional
_Major news outlets, trade publications, LinkedIn_
- [ ] Business media coverage
- [ ] Trade publication articles
- [ ] Executive interviews
- [ ] Conference presentations

### Tier 4 Sources (SQS 2) - Employee & Customer
_Glassdoor, Indeed, Reddit, customer reviews_
- [ ] Employee review platforms
- [ ] Customer forums
- [ ] Social media discussions
- [ ] Consumer complaints

### Tier 5 Sources (SQS 1) - Unverified
_Blogs, anonymous sources (requires disclaimer)_

---

## Financial Data Verification Checklist
- [ ] Revenue figures cross-referenced
- [ ] Profit margins verified
- [ ] Debt levels confirmed
- [ ] Cash flow validated
- [ ] Market cap accurate

## Approval Status: PENDING
EOF

# Create leadership vetting template
cat > "${PROJECT_PATH}/07_leadership_vetting/LEADERSHIP_MATRIX.md" << EOF
# Leadership Vetting Matrix - ${TARGET_NAME}

## Level 1: Leadership Identification

### C-Suite Executives
| Name | Title | Tenure | Previous Role | Risk Flags |
|------|-------|--------|---------------|------------|
| TBD | CEO | TBD | TBD | TBD |
| TBD | CFO | TBD | TBD | TBD |
| TBD | CTO | TBD | TBD | TBD |
| TBD | COO | TBD | TBD | TBD |

### Board of Directors
| Name | Role | Other Boards | Conflicts | Risk Level |
|------|------|--------------|-----------|------------|
| TBD | Chairman | TBD | TBD | TBD |

### Recent Departures (Last 2 Years)
| Name | Former Title | Departure Date | Reason | Current Role |
|------|--------------|----------------|--------|--------------|
| TBD | TBD | TBD | TBD | TBD |

## Level 2: Individual Deep Dives

### Priority Targets for Scanning
1. CEO - Full reputational scan required
2. CFO - Financial history emphasis
3. Board Chairman - Conflict analysis
4. Recent high-profile departures

### Risk Categories to Investigate
- Professional failures/bankruptcies
- Legal issues/litigation
- Regulatory violations
- Controversial statements
- Personal scandals
- Network liabilities

EOF

# Create competitor analysis template
cat > "${PROJECT_PATH}/08_competitor_analysis/COMPETITOR_LANDSCAPE.md" << EOF
# Competitor Analysis Framework - ${TARGET_NAME}

## Direct Competitors
| Company | Market Cap | Key Advantages | Key Weaknesses | Threat Level |
|---------|------------|----------------|----------------|--------------|
| TBD | TBD | TBD | TBD | High/Medium/Low |

## Market Position Analysis
- Market Share: TBD%
- Growth Rate: TBD%
- Competitive Advantages: TBD
- Competitive Weaknesses: TBD

## Comparative Financial Metrics
| Metric | ${TARGET_NAME} | Competitor 1 | Competitor 2 | Industry Avg |
|--------|----------------|--------------|--------------|--------------|
| Revenue Growth | TBD | TBD | TBD | TBD |
| Profit Margin | TBD | TBD | TBD | TBD |
| P/E Ratio | TBD | TBD | TBD | TBD |
| Debt/Equity | TBD | TBD | TBD | TBD |

EOF

# Create Claude instructions
cat > "${PROJECT_PATH}/CLAUDE_INSTRUCTIONS.md" << EOF
# Instructions for Claude - Organizational Intelligence Scan

## YOUR MISSION
You are conducting an opposition research level deep scan of ${TARGET_NAME}.
This requires exhaustive investigation of the organization and its leadership following Mission Briefing v1.0.

## IMMEDIATE ACTIONS

### 1. Read Required Documents
- Read the MISSION_BRIEFING.md in this project folder
- Read the PROJECT_CONFIG.json to understand all parameters
- Review MRP v6.1.2 protocol requirements

### 2. Company Structure Mapping
- Identify all subsidiaries and business units
- Map organizational structure
- Identify key products/services
- Document geographic presence

### 3. Execute Four-Vector Investigation

#### Vector A: Corporate & Financial Health
- Download all SEC filings (if public)
- Analyze financial statements
- Document M&A history
- Track funding rounds
- Assess stock performance

#### Vector B: Market Position & Public Perception
- Create media coverage timeline
- Aggregate customer reviews
- Analyze social sentiment
- Document brand perception

#### Vector C: Operational & Cultural Health
- Deep dive Glassdoor/Indeed
- Search for layoff patterns
- Find employee litigation
- Assess supply chain risks

#### Vector D: Leadership Vetting (CRITICAL)
**Level 1**: Identify ALL leadership
**Level 2**: Conduct condensed scans of each leader focusing on:
- Business failures
- Legal issues
- Controversies
- Reputational risks

### 4. Financial Verification Protocol
- Every financial figure must be verified from multiple sources
- SEC filings are primary truth source
- Triangulate with news reports and analyst coverage
- Document any discrepancies

### 5. Logo Acquisition
Try to acquire the company logo from:
- Company website
- Press kit/media resources
- Wikipedia/Wikidata
- Save to assets/logos/ directory

### 6. Competitor Analysis
Identify top 3-5 direct competitors and analyze:
- Market share comparison
- Financial metrics comparison
- Competitive advantages/disadvantages
- Strategic positioning

### 7. Output Generation
The final dossier must include:
- Executive Summary with risk matrix
- Complete company overview
- Financial health assessment
- Market position analysis
- Operational risk evaluation
- Leadership liability assessment
- Competitive intelligence
- Strategic recommendations
- Full citation bibliography (50+ sources)

## MCP TOOL USAGE
Primary (Heavy Use):
- Firecrawl for financial documents
- DataForSEO for market analysis
- Perplexity for business intelligence

Secondary:
- Tavily for news coverage
- Reddit MCP for employee sentiment
- Playwright for dynamic sites

## QUALITY GATES
- Minimum 20 pages required
- 50+ citations mandatory
- All financial data verified
- All C-suite vetted
- Competitor analysis complete
- Company logo acquired

## SPECIAL FOCUS AREAS
- Any recent crisis events
- Regulatory investigations
- Major lawsuits
- Leadership turnover
- Financial irregularities
- Customer complaints patterns

Project Path: ${PROJECT_PATH}
Target Organization: ${TARGET_NAME}
Start Time: $(date)
EOF

# Display completion message
echo -e "\n${GREEN}${BOLD}✓ Organizational intelligence scan initialized!${NC}"
echo -e "\n${CYAN}Project Structure Created:${NC}"
echo "  • 9 specialized directories with financial focus"
echo "  • Mission briefing deployed"
echo "  • Leadership vetting matrix ready"
echo "  • Competitor analysis framework"
echo "  • Financial verification checklist"

echo -e "\n${YELLOW}${BOLD}Four Investigation Vectors:${NC}"
echo "  A. Corporate & Financial Health"
echo "  B. Market Position & Public Perception"
echo "  C. Operational & Cultural Health"
echo "  D. Leadership Vetting (Two-Level Scan)"

echo -e "\n${BLUE}${BOLD}Quality Standards Enforced:${NC}"
echo "  • Minimum 20 pages required"
echo "  • 50+ source citations mandatory"
echo "  • Financial verification required"
echo "  • Two-level leadership scanning"
echo "  • Competitor analysis required"
echo "  • Company logo acquisition"

echo -e "\n${GREEN}Ready to begin organizational deep scan of ${TARGET_NAME}${NC}"
echo -e "Monitor progress in: ${PROJECT_PATH}/RESEARCH_LOG.md"

# Log the initialization
echo "[$(date)] Organizational Intelligence Scan initialized for ${TARGET_NAME}" >> "${PROJECT_ROOT}/00_SYSTEM/GLOBAL_RESEARCH_INDEX.csv"