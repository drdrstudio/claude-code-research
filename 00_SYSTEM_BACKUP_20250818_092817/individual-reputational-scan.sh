#!/bin/bash

# Individual Reputational Scan Recipe v4.0
# Purpose: Automated opposition-research level scanning with quality gates
# Author: MRP System v6.1.2

set -e

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default configuration
QUALITY_GATES="on"
IDENTITY_GATE="on"
SOURCE_GATE="on"
NETWORK_GATE="on"
DATA_GATE="on"
CITATION_GATE="on"
OUTPUT_FORMAT="pdf"
VERBOSE="false"

# Parse command line arguments
TARGET_NAME="$1"
shift

while [[ $# -gt 0 ]]; do
    case $1 in
        --quality-gates=*)
            QUALITY_GATES="${1#*=}"
            shift
            ;;
        --identity-gate=*)
            IDENTITY_GATE="${1#*=}"
            shift
            ;;
        --source-gate=*)
            SOURCE_GATE="${1#*=}"
            shift
            ;;
        --network-gate=*)
            NETWORK_GATE="${1#*=}"
            shift
            ;;
        --output=*)
            OUTPUT_FORMAT="${1#*=}"
            shift
            ;;
        --verbose)
            VERBOSE="true"
            shift
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

# Validate target name
if [ -z "$TARGET_NAME" ]; then
    echo -e "${RED}Error: No target name provided${NC}"
    echo "Usage: $0 \"Person Name\" [options]"
    echo "Options:"
    echo "  --quality-gates=[on|off]     Toggle all quality gates (default: on)"
    echo "  --identity-gate=[on|off]     Toggle identity verification (default: on)"
    echo "  --source-gate=[on|off]       Toggle source credibility checks (default: on)"
    echo "  --network-gate=[on|off]      Toggle network analysis gates (default: on)"
    echo "  --output=[pdf|html|both]     Output format (default: pdf)"
    echo "  --verbose                    Show detailed progress"
    exit 1
fi

echo -e "${BLUE}================================================${NC}"
echo -e "${BLUE}  INDIVIDUAL REPUTATIONAL SCAN v4.0${NC}"
echo -e "${BLUE}================================================${NC}"
echo -e "Target: ${GREEN}$TARGET_NAME${NC}"
echo -e "Quality Gates: ${YELLOW}$QUALITY_GATES${NC}"
echo ""

# Create project directory with timestamp
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
PROJECT_NAME="Research_ReputationalScan_${TARGET_NAME// /_}_${TIMESTAMP}"
PROJECT_DIR="03_PROJECTS/ReputationalScans/${PROJECT_NAME}"

echo -e "${BLUE}Creating project structure...${NC}"
mkdir -p "${PROJECT_DIR}"/{01_planning,02_raw_intelligence,03_verified_sources,04_network_analysis,05_synthesis,06_output}

# Generate PROJECT_CONFIG.json with quality gate settings
cat > "${PROJECT_DIR}/PROJECT_CONFIG.json" << EOF
{
  "project_id": "${PROJECT_NAME}",
  "research_type": "individual_reputational_scan",
  "target": {
    "name": "${TARGET_NAME}",
    "type": "individual",
    "classification": "reputational_assessment"
  },
  "quality_gates": {
    "enabled": $([ "$QUALITY_GATES" = "on" ] && echo "true" || echo "false"),
    "mode": "interactive",
    "gates": {
      "identity_verification": $([ "$IDENTITY_GATE" = "on" ] && echo "true" || echo "false"),
      "source_credibility": $([ "$SOURCE_GATE" = "on" ] && echo "true" || echo "false"),
      "data_completeness": $([ "$DATA_GATE" = "on" ] && echo "true" || echo "false"),
      "network_correlation": $([ "$NETWORK_GATE" = "on" ] && echo "true" || echo "false"),
      "citation_availability": $([ "$CITATION_GATE" = "on" ] && echo "true" || echo "false")
    },
    "thresholds": {
      "identity_confidence": 0.8,
      "source_credibility": 0.6,
      "data_completeness": 0.7,
      "network_relevance": 0.5,
      "auto_proceed_above": 0.9
    }
  },
  "investigation_vectors": [
    "professional_history_business_conduct",
    "public_statements_media_presence",
    "online_discourse_public_sentiment",
    "legal_financial_records",
    "network_analysis_second_level"
  ],
  "output_requirements": {
    "format": "${OUTPUT_FORMAT}",
    "length": "20-50 pages",
    "citation_style": "markdown_footnotes",
    "knowledge_graph": true
  },
  "mcp_stack": {
    "orchestrator": "sequential_thinking",
    "primary_search": ["perplexity", "firecrawl"],
    "deep_fetch": ["firecrawl", "playwright"],
    "social_sentiment": ["reddit", "perplexity"],
    "verification": ["tavily", "firecrawl"]
  },
  "created_at": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
  "status": "initialized"
}
EOF

echo -e "${GREEN}✓ Project structure created${NC}"
echo -e "${GREEN}✓ Configuration saved${NC}"
echo ""

# Phase 1: Identity Verification (with quality gate)
echo -e "${BLUE}Phase 1: Identity Verification${NC}"
if [ "$IDENTITY_GATE" = "on" ]; then
    echo -e "${YELLOW}⚡ Identity Verification Gate Active${NC}"
    
    # Create identity verification prompt for Sequential Thinking
    cat > "${PROJECT_DIR}/01_planning/identity_verification.md" << EOF
# Identity Verification for ${TARGET_NAME}

## Objective
Confirm the identity of the target individual with high confidence before proceeding.

## Required Verification Points
1. Full legal name (including middle name/initial if available)
2. Current primary affiliation (company/organization)
3. Geographic location (city/state)
4. At least 2 unique identifiers (LinkedIn URL, company bio, etc.)
5. Age range or birth year (if publicly available)

## Search Strategy
1. Start with: "${TARGET_NAME}" + "LinkedIn"
2. Cross-reference with company websites
3. Verify with news articles mentioning the person
4. Check for consistent biographical details

## Quality Gate Criteria
- Minimum 80% confidence in identity match
- At least 3 corroborating sources
- No conflicting information about different people
EOF
    
    echo "Starting identity verification process..."
    echo -e "${YELLOW}Would you like to proceed with automated identity verification? (y/n/skip)${NC}"
    read -r PROCEED
    
    if [ "$PROCEED" = "skip" ]; then
        echo -e "${YELLOW}⚠ Skipping identity verification - proceeding at risk${NC}"
    fi
else
    echo -e "${YELLOW}⚠ Identity gate disabled - proceeding without verification${NC}"
fi

# Phase 2: Multi-Vector Investigation
echo ""
echo -e "${BLUE}Phase 2: Multi-Vector Investigation${NC}"

# Create investigation plan
cat > "${PROJECT_DIR}/01_planning/investigation_plan.md" << EOF
# Investigation Plan for ${TARGET_NAME}

## Vector 1: Professional History & Business Conduct
- Corporate records and affiliations
- Board memberships
- Business failures or successes
- SEC filings (if applicable)
- Professional timeline

## Vector 2: Public Statements & Media Presence
- News articles and interviews
- Published op-eds or articles
- Conference speaking engagements
- Podcast appearances
- Social media presence (LinkedIn, Twitter/X)

## Vector 3: Online Discourse & Public Sentiment
- Reddit discussions
- Twitter/X mentions and replies
- Industry forum discussions
- Blog comments
- Review sites (if applicable)

## Vector 4: Legal & Financial Records
- Civil litigation records
- Bankruptcy filings
- Tax liens
- Public donation records
- Regulatory actions

## Vector 5: Network Analysis (Multi-Level)
### Level 1: Direct Associates
- Business partners
- Co-founders
- Board colleagues
- Major investors/investees

### Level 2: Associate Scanning
- Top 3-5 most significant associates
- Condensed reputational scan of each

### Level 3: Relationship Analysis
- Timeline of relationships
- Nature of connections
- Potential liability exposure
EOF

echo -e "${GREEN}✓ Investigation plan created${NC}"

# Phase 3: Source Collection with Quality Gates
echo ""
echo -e "${BLUE}Phase 3: Source Collection & Verification${NC}"

if [ "$SOURCE_GATE" = "on" ]; then
    echo -e "${YELLOW}⚡ Source Credibility Gate Active${NC}"
    
    # Create source evaluation criteria
    cat > "${PROJECT_DIR}/03_verified_sources/source_criteria.json" << EOF
{
  "credibility_tiers": {
    "tier_1": {
      "description": "Highly credible, primary sources",
      "examples": ["SEC filings", "Court records", "Official company statements"],
      "weight": 1.0
    },
    "tier_2": {
      "description": "Reputable media and verified platforms",
      "examples": ["Major news outlets", "LinkedIn profiles", "Company websites"],
      "weight": 0.8
    },
    "tier_3": {
      "description": "Community and social sources",
      "examples": ["Reddit posts", "Twitter threads", "Blog posts"],
      "weight": 0.5
    },
    "tier_4": {
      "description": "Unverified or anonymous sources",
      "examples": ["Anonymous forums", "Unverified claims", "Rumors"],
      "weight": 0.2
    }
  },
  "minimum_credibility_score": 0.6,
  "require_corroboration_below": 0.8
}
EOF
fi

# Phase 4: Network Analysis with Gates
echo ""
echo -e "${BLUE}Phase 4: Network Analysis${NC}"

if [ "$NETWORK_GATE" = "on" ]; then
    echo -e "${YELLOW}⚡ Network Analysis Gate Active${NC}"
    
    # Create network analysis framework
    cat > "${PROJECT_DIR}/04_network_analysis/network_framework.md" << EOF
# Network Analysis Framework

## Level 1: Primary Associate Identification
- Threshold for inclusion: Direct business relationship within last 5 years
- Minimum evidence: 2 independent sources confirming relationship

## Level 2: Associate Prioritization
- Ranking criteria:
  1. Financial involvement (investor/investee)
  2. Current active partnership
  3. Board/executive relationship
  4. Historical partnership with ongoing implications

## Level 3: Liability Assessment
- Red flags to investigate:
  - Legal issues (criminal or civil)
  - Regulatory sanctions
  - Bankruptcy or financial distress
  - Reputational scandals
  - Conflicts of interest

## Quality Gate Checkpoints
1. Associate verification (minimum 60% confidence)
2. Relationship significance (minimum relevance score 0.5)
3. Liability substantiation (requires primary source)
EOF
fi

# Phase 5: Synthesis and Report Generation
echo ""
echo -e "${BLUE}Phase 5: Synthesis & Report Generation${NC}"

# Create synthesis template
cat > "${PROJECT_DIR}/05_synthesis/report_template.md" << EOF
# Reputational Intelligence Dossier: ${TARGET_NAME}

## Executive Summary
[Generated after research completion]

## Identity Confirmation
- Full Name: ${TARGET_NAME}
- Verification Confidence: [X%]
- Primary Sources: [List]

## Professional History & Business Conduct
[Research findings with citations]

## Public Statements & Media Presence
[Research findings with citations]

## Online Discourse & Public Sentiment
[Research findings with citations]

## Legal & Financial Records
[Research findings with citations]

## Network Analysis

### Primary Associates (Level 1)
[List with relationship descriptions]

### Deep Dive: Top Associates (Level 2)
[Detailed findings on top 3-5 associates]

### Relationship Risk Assessment (Level 3)
[Analysis of potential liability exposure]

## Risk Assessment Matrix
[Comprehensive risk evaluation]

## Appendices
- A: Source List with Credibility Ratings
- B: Knowledge Graph Visualization
- C: Raw Data Archive

---
*Report generated: $(date -u +"%Y-%m-%dT%H:%M:%SZ")*
*Quality Gates: ${QUALITY_GATES}*
EOF

echo -e "${GREEN}✓ Report template created${NC}"

# Create research execution script
cat > "${PROJECT_DIR}/execute_research.sh" << EOF
#!/bin/bash
# Auto-generated research execution script

PROJECT_DIR="${PROJECT_DIR}"
TARGET="${TARGET_NAME}"

echo "Starting automated research execution..."

# This script will be called by Sequential Thinking to execute research phases
# It provides the actual MCP tool calls based on the investigation plan

# Phase 1: Identity Verification
echo "Executing identity verification..."
# MCP calls will be inserted here by Sequential Thinking

# Phase 2: Multi-vector investigation
echo "Executing multi-vector investigation..."
# MCP calls for each vector

# Phase 3: Network analysis
echo "Executing network analysis..."
# Multi-level associate scanning

# Phase 4: Synthesis
echo "Generating final report..."
# Report compilation and citation insertion

echo "Research execution complete"
EOF

chmod +x "${PROJECT_DIR}/execute_research.sh"

# Final output
echo ""
echo -e "${GREEN}================================================${NC}"
echo -e "${GREEN}  SETUP COMPLETE${NC}"
echo -e "${GREEN}================================================${NC}"
echo ""
echo -e "Project created at: ${BLUE}${PROJECT_DIR}${NC}"
echo ""
echo -e "${YELLOW}Next Steps:${NC}"
echo "1. Review PROJECT_CONFIG.json for accuracy"
echo "2. Run Sequential Thinking orchestration"
echo "3. Execute research phases with quality gates"
echo "4. Generate final report"
echo ""
echo -e "${BLUE}To start research, run:${NC}"
echo "cd ${PROJECT_DIR} && ./execute_research.sh"