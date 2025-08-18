#!/bin/bash

# GTM Marketing Intelligence Dispatcher v1.0
# Implements the Comprehensive Audience & Segmentation Audit requirements

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
TARGET_MARKET="$3"

# System paths
SYSTEM_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SYSTEM_DIR")"

echo -e "${BLUE}${BOLD}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}${BOLD}║   GTM MARKETING INTELLIGENCE v1.0                           ║${NC}"
echo -e "${BLUE}${BOLD}║   Comprehensive Audience & Segmentation Audit               ║${NC}"
echo -e "${BLUE}${BOLD}╚══════════════════════════════════════════════════════════════╝${NC}"

echo -e "\n${GREEN}Target Client/Product:${NC} ${BOLD}${TARGET_NAME}${NC}"
echo -e "${GREEN}Target Market:${NC} ${BOLD}${TARGET_MARKET}${NC}"
echo -e "${GREEN}Project:${NC} ${PROJECT_PATH}"
echo -e "${GREEN}Protocol:${NC} MRP v6.1.2 with GTM Mission Briefing v1.0"

# Create comprehensive GTM project structure
echo -e "\n${YELLOW}Creating GTM intelligence project structure...${NC}"
mkdir -p "${PROJECT_PATH}/01_searches/keywords"
mkdir -p "${PROJECT_PATH}/01_searches/competitors"
mkdir -p "${PROJECT_PATH}/01_searches/audience"
mkdir -p "${PROJECT_PATH}/02_fetched_content/market_research"
mkdir -p "${PROJECT_PATH}/02_fetched_content/competitor_analysis"
mkdir -p "${PROJECT_PATH}/02_fetched_content/audience_insights"
mkdir -p "${PROJECT_PATH}/03_extracted_data/segments"
mkdir -p "${PROJECT_PATH}/03_extracted_data/personas"
mkdir -p "${PROJECT_PATH}/04_analysis/market_sizing"
mkdir -p "${PROJECT_PATH}/04_analysis/segmentation"
mkdir -p "${PROJECT_PATH}/04_analysis/channel_strategy"
mkdir -p "${PROJECT_PATH}/05_synthesis/playbooks"
mkdir -p "${PROJECT_PATH}/05_synthesis/experiments"
mkdir -p "${PROJECT_PATH}/06_metadata"
mkdir -p "${PROJECT_PATH}/07_deliverables/csv_exports"
mkdir -p "${PROJECT_PATH}/08_measurement"
mkdir -p "${PROJECT_PATH}/09_creative_assets"
mkdir -p "${PROJECT_PATH}/PDFs"
mkdir -p "${PROJECT_PATH}/assets/competitor_logos"

# Copy the mission briefing
cp "${SYSTEM_DIR}/recipe-prompts/gtm-marketing-intelligence-prompt.md" "${PROJECT_PATH}/MISSION_BRIEFING.md"

# Create comprehensive research log
cat > "${PROJECT_PATH}/RESEARCH_LOG.md" << EOF
# GTM Marketing Intelligence Research Log
## Client/Product: ${TARGET_NAME}
## Target Market: ${TARGET_MARKET}
## Protocol: MRP v6.1.2 | GTM Mission Briefing v1.0
## Started: $(date)

---

### Phase 1: Initialization ✅
- Project structure created
- Mission briefing deployed
- PROJECT_CONFIG.json generated with GTM parameters

### Phase 2: Market Intelligence & Competitive Analysis
- Status: Pending
- TAM/SAM/SOM sizing required
- Competitor decomposition needed

### Phase 3: Audience Discovery & Segmentation
- Status: Pending
- Segmentation model development
- ICP definition required

### Phase 4: Channel Strategy & Tactical Planning
- Status: Pending
- Channel-audience fit analysis
- Platform playbooks needed

### Phase 5: Message Development & Testing Framework
- Status: Pending
- Message matrix creation
- A/B test prioritization

### Phase 5.5: Data & Measurement Architecture
- Status: Pending
- Tracking plan development
- Attribution model design

### Phase 6: Synthesis & Roadmap Development
- Status: Pending
- 90-day experiment roadmap
- Resource planning

### Phase 7: Deliverable Production
- Status: Pending
- Executive summary
- Channel playbooks
- CSV exports

---

## 12-Step Methodology Checklist

### Step 1: Market Map & Sizing
- [ ] Category boundaries defined
- [ ] TAM calculated with sources
- [ ] SAM calculated with assumptions
- [ ] SOM estimated with constraints
- [ ] Growth drivers identified
- [ ] Inhibitors documented

### Step 2: Demand & Jobs-To-Be-Done
- [ ] Primary jobs identified
- [ ] Pain points mapped
- [ ] Trigger events documented
- [ ] Buying committee mapped (B2B)
- [ ] High-intent signals identified

### Step 3: Segmentation Construction
- [ ] Firmographic segments defined
- [ ] Technographic analysis complete
- [ ] Demographic profiles created
- [ ] Psychographic insights gathered
- [ ] Behavioral patterns identified
- [ ] Intent signals mapped
- [ ] Lifecycle stages defined

### Step 4: ICP & Tiering
- [ ] 1-3 ICPs defined
- [ ] Tier 1 criteria established
- [ ] Tier 2 criteria established
- [ ] Tier 3 criteria established
- [ ] Disqualification rules set

### Step 5: Competitor Audience Decomposition
- [ ] Top 5 competitors analyzed
- [ ] Audience mix identified
- [ ] Positioning gaps found
- [ ] Channel strategies mapped
- [ ] Whitespace opportunities

### Step 6: Channel-Audience Fit
- [ ] Search strategy defined
- [ ] Social platforms prioritized
- [ ] Display/programmatic planned
- [ ] Video strategy outlined
- [ ] Partnership opportunities
- [ ] Email/SMS approach

### Step 7: Keyword & Topic Taxonomy
- [ ] Transactional keywords identified
- [ ] Problem keywords mapped
- [ ] Solution keywords listed
- [ ] Brand terms tracked
- [ ] Competitor terms noted
- [ ] Negative keywords defined

### Step 8: Message & Offer Matrix
- [ ] Persona hooks created
- [ ] Pain-based messaging
- [ ] Proof points gathered
- [ ] Offers structured
- [ ] Objection handlers

### Step 9: Data & Tracking Plan
- [ ] Pixel requirements defined
- [ ] UTM schema created
- [ ] Lead scoring model v1
- [ ] Enrichment fields identified
- [ ] Privacy compliance checked

### Step 10: Experiment Roadmap
- [ ] 10-20 tests defined
- [ ] ICE scores assigned
- [ ] Sample sizes calculated
- [ ] Success metrics set
- [ ] Decision rules established

### Step 11: Measurement Framework
- [ ] North-star metrics defined
- [ ] Guardrail metrics set
- [ ] Dashboard specs created
- [ ] CAC/LTV models built
- [ ] Leading indicators identified

### Step 12: Risk Assessment
- [ ] Top 10 assumptions listed
- [ ] Invalidation triggers defined
- [ ] Mitigation plans created
- [ ] Validation timeline set

---

## Quality Control Metrics
- Target Pages: 20-40
- Target Citations: 50+
- Segments Required: 5+
- Channel Playbooks: 5+
- Experiments Defined: 10-20
- Source Quality Minimum: 3/5

EOF

# Create Source Manifest with GTM focus
cat > "${PROJECT_PATH}/06_metadata/Source_Manifest.md" << EOF
# Source Manifest for ${TARGET_NAME} GTM Research
## Quality Standards: SQS 3+ Required | Market Data Verification Mandatory

### Tier 1 Sources (SQS 5) - Primary Research
_Industry reports, analyst firms, government data_
- [ ] Gartner/Forrester reports
- [ ] Government statistics
- [ ] Industry associations
- [ ] Academic research

### Tier 2 Sources (SQS 4) - Market Intelligence
_SEMrush, Ahrefs, SimilarWeb, Crunchbase_
- [ ] Keyword research tools
- [ ] Traffic analytics platforms
- [ ] Competitive intelligence tools
- [ ] Market sizing databases

### Tier 3 Sources (SQS 3) - Media & Analysis
_TechCrunch, industry publications, case studies_
- [ ] Industry news coverage
- [ ] Company case studies
- [ ] Thought leadership content
- [ ] Conference presentations

### Tier 4 Sources (SQS 2) - Community Insights
_Reddit, forums, review sites, social media_
- [ ] Reddit discussions
- [ ] Industry forums
- [ ] Review platforms
- [ ] Social media analysis

### Tier 5 Sources (SQS 1) - Unverified
_Blogs, opinions (requires disclaimer)_

---

## Data Verification Checklist
- [ ] Market size triangulated
- [ ] Growth rates verified
- [ ] Competitor data confirmed
- [ ] Keyword volumes validated
- [ ] Channel costs benchmarked

## Approval Status: PENDING
EOF

# Create segmentation template
cat > "${PROJECT_PATH}/03_extracted_data/segments/SEGMENTATION_MATRIX.md" << EOF
# Segmentation Matrix - ${TARGET_NAME}

## Segment Definition Framework

### Segment 1: [Name]
- **Firmographic**: 
- **Technographic**: 
- **Demographic**: 
- **Psychographic**: 
- **Behavioral**: 
- **Size**: [% of TAM]
- **ACV/AOV**: $
- **LTV**: $
- **CAC Target**: $
- **Payback**: [months]
- **Online Reachability**: [%]
- **Priority**: [High/Medium/Low]

### Segment 2: [Name]
[Template repeats...]

## ICP Definition

### Tier 1 (Primary ICP)
**Must Have:**
- 
- 
- 

**Nice to Have:**
- 
- 

**Disqualifiers:**
- 
- 

### Tier 2 (Secondary)
[Template continues...]

### Tier 3 (Tertiary)
[Template continues...]

EOF

# Create channel playbook template
cat > "${PROJECT_PATH}/05_synthesis/playbooks/CHANNEL_PLAYBOOKS.md" << EOF
# Channel Playbooks - ${TARGET_NAME}

## Search (Google Ads, Bing)
### Target Audiences
- Keywords: [List]
- Negatives: [List]
- Match Types: [Strategy]

### Expected Performance
- Volume: [Monthly searches]
- CPC Range: $[X-Y]
- CTR Benchmark: [%]
- CVR Expectation: [%]

### Creative Guidelines
- Headlines: [Examples]
- Descriptions: [Examples]
- Extensions: [Required]

---

## Social - LinkedIn
### Target Audiences
- Job Titles: [List]
- Companies: [List/Size]
- Industries: [List]
- Skills/Interests: [List]

### Expected Performance
- CPM Range: $[X-Y]
- CTR Benchmark: [%]
- CPL Target: $[X]

### Creative Formats
- Single Image: [Specs]
- Carousel: [Specs]
- Video: [Specs]
- Copy Hooks: [Examples]

---

## Social - Meta (Facebook/Instagram)
### Target Audiences
- Interests: [List]
- Behaviors: [List]
- Lookalikes: [Seed lists]
- Custom Audiences: [Sources]

### Expected Performance
- CPM Range: $[X-Y]
- CTR Benchmark: [%]
- CPA Target: $[X]

### Creative Strategy
- Formats: [Priority]
- Copy Angles: [List]
- Social Proof: [Types]

---

## Additional Channels
[Templates for Reddit, TikTok, Display, YouTube, Email, etc.]

EOF

# Create experiment backlog
cat > "${PROJECT_PATH}/05_synthesis/experiments/EXPERIMENT_BACKLOG.md" << EOF
# Experiment Backlog - ${TARGET_NAME}

## Prioritization Framework
ICE Score = (Impact × Confidence × Ease) / 10

## High Priority Tests (ICE > 7)

### Test 1: [Name]
- **Hypothesis**: 
- **Segment**: 
- **Channel**: 
- **Impact**: [1-10]
- **Confidence**: [1-10]
- **Ease**: [1-10]
- **ICE Score**: 
- **Success Metric**: 
- **Sample Size**: 
- **Duration**: 

### Test 2: [Name]
[Template repeats...]

## Medium Priority Tests (ICE 4-7)
[Tests listed...]

## Low Priority Tests (ICE < 4)
[Tests listed...]

## Test Categories
- Audience Discovery: [Count]
- Message/Offer: [Count]
- Landing/Flow: [Count]
- Pricing/Packaging: [Count]
- Lifecycle/Retention: [Count]

EOF

# Create measurement plan
cat > "${PROJECT_PATH}/08_measurement/MEASUREMENT_PLAN.md" << EOF
# Measurement Plan - ${TARGET_NAME}

## North Star Metrics
- Primary: [Metric]
- Secondary: [Metric]
- Tertiary: [Metric]

## Guardrail Metrics
- CAC Ceiling: $
- Payback Maximum: [Months]
- LTV:CAC Minimum: [Ratio]

## Channel-Specific KPIs
### Search
- CTR Target: %
- CPC Maximum: $
- Quality Score Minimum: 

### Social
- CPM Target: $
- Engagement Rate: %
- CPL Maximum: $

### Email
- Open Rate: %
- CTR: %
- Conversion Rate: %

## Attribution Model
- Model Type: [First/Last/Multi/Data-driven]
- Lookback Window: [Days]
- View-Through: [Hours]

## Dashboard Requirements
### Executive Dashboard
- [Metric 1]
- [Metric 2]
- [Metric 3]

### Channel Performance
- [By channel metrics]

### Segment Performance
- [By segment metrics]

## UTM Schema
- Source: [Convention]
- Medium: [Convention]
- Campaign: [Convention]
- Content: [Convention]
- Term: [Convention]

EOF

# Create Claude instructions
cat > "${PROJECT_PATH}/CLAUDE_INSTRUCTIONS.md" << EOF
# Instructions for Claude - GTM Marketing Intelligence Scan

## YOUR MISSION
You are conducting a comprehensive audience & segmentation audit for ${TARGET_NAME} targeting ${TARGET_MARKET}.
This requires rigorous market analysis, audience segmentation, and channel strategy development following the GTM Mission Briefing v1.0.

## IMMEDIATE ACTIONS

### 1. Read Required Documents
- Read the MISSION_BRIEFING.md in this project folder
- Read the PROJECT_CONFIG.json to understand all parameters
- Review MRP v6.1.2 protocol requirements

### 2. Context Gathering
Gather the following information about ${TARGET_NAME}:
- Company description and value proposition
- Product details and pricing model
- Business model (B2B/B2C/PLG/etc.)
- Current customer base
- Revenue goals and constraints
- Competitive landscape

### 3. Execute 12-Step Methodology

#### Step 1: Market Map & Sizing
- Define TAM/SAM/SOM with DataForSEO
- Identify growth drivers and inhibitors
- Document market maturity

#### Step 2: Demand & JTBD Analysis
- Research customer jobs and pains
- Map buying committees/decision makers
- Identify intent signals

#### Step 3: Segmentation Construction
- Build multi-dimensional segments
- Size each segment
- Calculate economics per segment

#### Step 4: ICP & Tiering
- Define 1-3 ICPs with clear criteria
- Create tier system with rules
- Document expansion paths

#### Step 5: Competitor Analysis
- Analyze 5-7 key competitors
- Map their audience strategies
- Find positioning whitespace

#### Step 6: Channel-Audience Fit
- Evaluate 5+ channels for fit
- Define targeting strategies
- Estimate performance metrics

#### Step 7: Keyword & Topic Research
- Use DataForSEO for keyword research
- Cluster by intent and journey stage
- Identify content opportunities

#### Step 8: Message & Offer Development
- Create persona-specific messaging
- Develop hook variations
- Design offer matrix

#### Step 9: Tracking & Data Plan
- Define measurement architecture
- Create UTM schema
- Design lead scoring model

#### Step 10: Experiment Design
- Create 10-20 prioritized tests
- Calculate sample sizes
- Define success criteria

#### Step 11: Measurement Framework
- Set north-star metrics
- Build CAC/LTV models
- Define leading indicators

#### Step 12: Risk Assessment
- Document key assumptions
- Create mitigation plans
- Set validation timeline

### 4. Deliverable Production

Create all required deliverables:
- Executive Summary (1-2 pages)
- Segmentation Matrix (CSV format)
- ICP & Tiering Rules
- Channel Playbooks (5+ channels)
- Keyword Clusters (CSV)
- Message & Offer Matrix
- Experiment Backlog (10-20 tests)
- Measurement Plan
- Risk Assessment

### 5. Quality Standards
- Minimum 20 pages of content
- 50+ source citations
- 5+ defined segments
- 5+ channel playbooks
- 10+ experiments defined
- Complete measurement framework

## MCP TOOL USAGE
Primary (Heavy Use):
- DataForSEO for keyword and SERP analysis
- Perplexity for market research
- Firecrawl for competitor intelligence

Secondary:
- Tavily for industry news
- Reddit MCP for community insights
- Sequential-Thinking for complex analysis

## CRITICAL SUCCESS FACTORS
- Evidence-based recommendations only
- Tie everything to economics (CAC/LTV/Payback)
- Prioritize actionable over theoretical
- Provide specific, not generic, guidance
- Include implementation details

## OUTPUT FORMAT
- Use clear headings and sections
- Include CSV-ready tables
- Provide formulas for calculations
- Flag assumptions explicitly
- Keep tone decisive and pragmatic

Project Path: ${PROJECT_PATH}
Target: ${TARGET_NAME}
Market: ${TARGET_MARKET}
Start Time: $(date)
EOF

# Display completion message
echo -e "\n${GREEN}${BOLD}✓ GTM Marketing Intelligence scan initialized!${NC}"
echo -e "\n${CYAN}Project Structure Created:${NC}"
echo "  • 9 specialized directories for GTM research"
echo "  • Mission briefing deployed"
echo "  • Segmentation matrix template"
echo "  • Channel playbook frameworks"
echo "  • Experiment backlog structure"
echo "  • Measurement plan template"

echo -e "\n${YELLOW}${BOLD}12-Step Methodology:${NC}"
echo "  1. Market Map & Sizing"
echo "  2. Demand & Jobs-To-Be-Done"
echo "  3. Segmentation Construction"
echo "  4. ICP & Tiering"
echo "  5. Competitor Decomposition"
echo "  6. Channel-Audience Fit"
echo "  7. Keyword & Topic Taxonomy"
echo "  8. Message & Offer Matrix"
echo "  9. Data & Tracking Plan"
echo "  10. Experiment Roadmap"
echo "  11. Measurement Framework"
echo "  12. Risk Assessment"

echo -e "\n${BLUE}${BOLD}Quality Standards Enforced:${NC}"
echo "  • Minimum 20 pages required"
echo "  • 50+ source citations mandatory"
echo "  • 5+ segments required"
echo "  • 5+ channel playbooks"
echo "  • 10-20 experiments defined"
echo "  • Complete measurement framework"

echo -e "\n${GREEN}Ready to begin GTM intelligence scan for ${TARGET_NAME}${NC}"
echo -e "Target Market: ${TARGET_MARKET}"
echo -e "Monitor progress in: ${PROJECT_PATH}/RESEARCH_LOG.md"

# Log the initialization
echo "[$(date)] GTM Marketing Intelligence Scan initialized for ${TARGET_NAME} targeting ${TARGET_MARKET}" >> "${PROJECT_ROOT}/00_SYSTEM/GLOBAL_RESEARCH_INDEX.csv"