#!/bin/bash

# create-enterprise-document.sh - Generate enterprise-quality documents using structured templates
# This script creates professional documents following McKinsey/BCG standards

set -e

if [ $# -ne 3 ]; then
    echo "Usage: ./create-enterprise-document.sh <project_folder> <document_type> <output_name>"
    echo ""
    echo "Document Types:"
    echo "  strategic_analysis   - Comprehensive strategic analysis report"
    echo "  executive_briefing   - Executive summary for C-level consumption"
    echo "  market_intelligence  - Market and competitive intelligence report"
    echo "  implementation_guide - Tactical implementation roadmap"
    echo ""
    echo "Example:"
    echo "  ./create-enterprise-document.sh 'Research_Project_123' 'strategic_analysis' 'Enterprise_Marketing_Strategy'"
    exit 1
fi

PROJECT_FOLDER="$1"
DOCUMENT_TYPE="$2"
OUTPUT_NAME="$3"

# Verify project folder exists
if [ ! -d "$PROJECT_FOLDER" ]; then
    echo "❌ Error: Project folder '$PROJECT_FOLDER' not found."
    exit 1
fi

echo "🚀 Creating Enterprise Document: $OUTPUT_NAME"
echo "📁 Project: $PROJECT_FOLDER"
echo "📋 Type: $DOCUMENT_TYPE"
echo "------------------------------------------------------------"

# Generate enterprise document prompt based on type
generate_enterprise_prompt() {
    local doc_type="$1"
    local project_data="$2"
    
    case "$doc_type" in
        "strategic_analysis")
            cat << 'EOF'
Create a comprehensive strategic analysis document following McKinsey/BCG standards. Use this EXACT structure:

# Strategic Analysis: [Extract topic from research]

## Executive Summary
[2-3 sentences capturing the most critical strategic findings with quantified impact]

## Context and Objectives
### Market Context
[Brief context about the market/industry and strategic importance]

### Analysis Objectives
- Primary objective: [Main strategic goal]
- Secondary objectives: [2-3 supporting goals]
- Success metrics: [How strategic success is measured]

## Key Strategic Findings

### Critical Market Intelligence
1. **[Finding Name]** - [Description with hard data/statistics]
2. **[Finding Name]** - [Description with hard data/statistics]  
3. **[Finding Name]** - [Description with hard data/statistics]

### Competitive Landscape Analysis
- Market positioning insights
- Competitive advantages/disadvantages
- Strategic threats and opportunities

### Stakeholder Impact Analysis
- Primary decision makers and influence mapping
- Organizational implications
- Change management considerations

## Strategic Recommendations

### Immediate Strategic Actions (0-90 days)
1. **[Action]** - [Business impact and resource requirements]
2. **[Action]** - [Business impact and resource requirements]

### Long-term Strategic Initiatives (3-12 months)
1. **[Initiative]** - [Expected strategic outcome and ROI]
2. **[Initiative]** - [Expected strategic outcome and ROI]

## Implementation Framework

### Phase 1: Foundation (Months 1-3)
[Timeline, key activities, success metrics, resource requirements]

### Phase 2: Execution (Months 4-9)
[Timeline, key activities, success metrics, resource requirements]

### Phase 3: Optimization (Months 10-12)
[Timeline, key activities, success metrics, resource requirements]

## Risk Assessment and Mitigation
### High-Impact Risks
- [Risk 1]: [Mitigation strategy]
- [Risk 2]: [Mitigation strategy]

### Success Dependencies
- [Dependency 1]: [Management approach]
- [Dependency 2]: [Management approach]

## Financial Impact Analysis
### Investment Requirements
- [Category]: [Amount and timeline]
- Total investment: [Amount]

### Expected Returns
- [Metric]: [Projected improvement]
- ROI timeline: [Expected payback period]

## Supporting Evidence

### Key Performance Indicators
- [KPI 1]: [Current state → Target state]
- [KPI 2]: [Current state → Target state]

### Validated Market Data
- [Statistic]: [Source and context]
- [Statistic]: [Source and context]

### Case Study References
[Brief references to supporting examples and benchmarks]

## Appendices
### A. Detailed Methodology
[Research approach and validation methods]

### B. Complete Data References
[All sources and statistical validation]

### C. Implementation Tools
[Templates, frameworks, and supporting materials]

---
*Strategic Analysis prepared by: Research Intelligence Team*  
*Document Date: [Current Date]*  
*Next Review: [Quarterly]*  
*Classification: Strategic Planning*

CRITICAL INSTRUCTIONS:
1. Use ONLY data from the provided research - no external assumptions
2. Include specific statistics with sources wherever possible
3. Write in authoritative, strategic consulting tone
4. Ensure executive-level accessibility while maintaining analytical depth
5. Focus on actionable insights with clear business impact
6. Use professional formatting with clear hierarchy
7. Quantify everything possible (percentages, dollar amounts, timelines)
EOF
            ;;
        "executive_briefing")
            cat << 'EOF'
Create an executive briefing document optimized for C-level consumption. Use this EXACT structure:

# Executive Briefing: [Extract topic from research]

## Executive Summary
**Strategic Opportunity:** [One sentence describing the core opportunity]
**Market Size:** [Quantified market opportunity if available]
**Investment Required:** [Resource requirements]
**Expected ROI:** [Projected returns and timeline]

### Key Findings (Top 3)
1. **[Finding]** - [Impact on business performance]
2. **[Finding]** - [Impact on business performance]  
3. **[Finding]** - [Impact on business performance]

## Strategic Context
### Market Dynamics
[2-3 bullet points on market forces affecting the opportunity]

### Competitive Position
[Current standing vs. competitors with quantified gaps/advantages]

### Organizational Readiness
[Assessment of internal capabilities and requirements]

## Immediate Actions Required

### Next 30 Days
- **[Action 1]:** [Owner and business impact]
- **[Action 2]:** [Owner and business impact]

### Next 90 Days  
- **[Initiative 1]:** [Resource needs and expected outcome]
- **[Initiative 2]:** [Resource needs and expected outcome]

## Investment and Returns

### Resource Requirements
| Category | Investment | Timeline | Owner |
|----------|------------|----------|-------|
| [Category] | [Amount] | [Period] | [Role] |
| **Total** | **[Amount]** | **[Period]** | **Leadership** |

### Success Metrics
- **[Metric 1]:** [Current] → [Target] ([Timeframe])
- **[Metric 2]:** [Current] → [Target] ([Timeframe])

## Risk Management
### High-Impact Risks
1. **[Risk]:** [Probability/Impact] - [Mitigation owner]
2. **[Risk]:** [Probability/Impact] - [Mitigation owner]

### Success Dependencies
- [Critical dependency with owner assignment]
- [Critical dependency with owner assignment]

## Decision Points
### Approve/Disapprove
- **Recommended Decision:** [Clear recommendation]
- **Rationale:** [Strategic justification]
- **Alternatives Considered:** [Brief mention]

### Board/Stakeholder Communication
- **Key Messages:** [Main points for external communication]
- **Timeline:** [When decisions/communications needed]

## Supporting Data Summary
[3-5 most compelling statistics that support the strategic recommendation]

---
*Executive Briefing prepared for: C-Level Leadership*  
*Prepared by: Strategic Analysis Team*  
*Date: [Current Date]*  
*Next Review: [Monthly]*  
*Action Required: [Decision needed by date]*

CRITICAL INSTRUCTIONS:
1. Keep total length under 2 pages when printed
2. Lead with business impact, not process details
3. Use executive language - strategic, decisive, quantified
4. Include clear decision points and required actions
5. Focus on ROI and competitive advantage
6. Use tables and bullet points for easy scanning
7. Every recommendation must have an owner and deadline
EOF
            ;;
        "market_intelligence")
            cat << 'EOF'
Create a market intelligence report for strategic planning. Use this EXACT structure:

# Market Intelligence Report: [Extract topic from research]

## Executive Summary
### Market Opportunity Assessment
**Total Addressable Market:** [Size and scope]
**Growth Rate:** [Projected growth with timeline]  
**Market Maturity:** [Stage and competitive dynamics]
**Strategic Fit:** [Alignment with organizational capabilities]

### Key Intelligence Findings
1. **[Market Finding]** - [Strategic implication]
2. **[Competitive Finding]** - [Strategic implication]
3. **[Customer Finding]** - [Strategic implication]

## Market Landscape Analysis

### Market Size and Segmentation
- **Total Market Size:** [Quantified with sources]
- **Addressable Segments:** [Relevant segments with sizing]
- **Growth Drivers:** [Factors driving market expansion]
- **Market Constraints:** [Limiting factors and barriers]

### Competitive Intelligence
#### Market Leaders
- **[Company 1]:** [Market share, strategy, strengths/weaknesses]
- **[Company 2]:** [Market share, strategy, strengths/weaknesses]

#### Competitive Gaps and Opportunities
- [Gap 1]: [Market need and opportunity size]
- [Gap 2]: [Market need and opportunity size]

#### Threat Assessment
- **Emerging Competitors:** [New entrants and disruption risk]
- **Substitute Solutions:** [Alternative approaches gaining traction]

## Customer Intelligence

### Target Customer Analysis
#### Primary Buyer Personas
**[Persona 1 Title]**
- Demographics: [Company size, industry, role level]
- Pain Points: [Top 3 challenges with quantified impact]
- Decision Process: [Timeline, stakeholders, criteria]
- Budget Authority: [Spending power and approval process]

**[Persona 2 Title]**
- Demographics: [Company size, industry, role level]
- Pain Points: [Top 3 challenges with quantified impact]
- Decision Process: [Timeline, stakeholders, criteria]
- Budget Authority: [Spending power and approval process]

#### Buying Behavior Intelligence
- **Purchase Drivers:** [Primary motivations for buying]
- **Decision Timeline:** [Typical sales cycle length]
- **Evaluation Criteria:** [How solutions are assessed]
- **Budget Allocation:** [Spending patterns and constraints]

## Technology and Innovation Trends

### Market Technology Evolution
- **Current State:** [Dominant technologies and approaches]
- **Emerging Technologies:** [New capabilities and adoption rates]
- **Innovation Barriers:** [Technical or market constraints]

### Disruption Analysis
- **Disruptive Forces:** [Technologies/models threatening status quo]
- **Adoption Timeline:** [Expected market transition periods]
- **Strategic Implications:** [Impact on market participants]

## Market Entry Strategy Intelligence

### Go-to-Market Insights
- **Successful Entry Models:** [How others have entered successfully]
- **Common Failure Patterns:** [Why market entry attempts fail]
- **Resource Requirements:** [Investment levels for market success]

### Channel Intelligence
- **Dominant Channels:** [How customers typically buy]
- **Channel Evolution:** [Changing distribution patterns]
- **Partnership Opportunities:** [Strategic alliance possibilities]

## Financial Market Intelligence

### Pricing Analysis
- **Market Pricing Models:** [How solutions are typically priced]
- **Price Sensitivity:** [Customer response to pricing changes]
- **Value Perception:** [What customers consider valuable]

### Investment and Funding Trends
- **Market Investment:** [VC/PE activity in the space]
- **Acquisition Activity:** [Recent M&A and valuations]
- **Public Market Performance:** [Stock performance of market leaders]

## Strategic Recommendations

### Market Entry Recommendations
1. **[Strategy]** - [Rationale and expected outcome]
2. **[Strategy]** - [Rationale and expected outcome]

### Investment Priorities
- **High Priority:** [Areas requiring immediate investment]
- **Medium Priority:** [Secondary investment areas]
- **Watch List:** [Areas to monitor for future investment]

### Risk Mitigation
- **Market Risks:** [External threats with mitigation strategies]
- **Execution Risks:** [Internal challenges with management approaches]

## Intelligence Sources and Validation

### Primary Research
- [Source type]: [Sample size, methodology, confidence level]
- [Source type]: [Sample size, methodology, confidence level]

### Secondary Research
- Industry reports: [Key sources and publication dates]
- Competitive analysis: [Information sources and update frequency]
- Market data: [Data providers and validation methods]

### Intelligence Confidence Levels
- **High Confidence:** [Findings validated by multiple sources]
- **Medium Confidence:** [Findings supported by available data]
- **Low Confidence:** [Findings requiring additional validation]

---
*Market Intelligence Report prepared by: Research Intelligence Team*  
*Report Date: [Current Date]*  
*Next Update: [Quarterly]*  
*Classification: Strategic Planning*  
*Distribution: Senior Leadership Team*

CRITICAL INSTRUCTIONS:
1. Focus on actionable intelligence, not just data
2. Quantify everything possible with confidence levels
3. Include competitive intelligence with strategic implications
4. Provide clear go-to-market insights
5. Use professional consulting tone throughout
6. Include data sources and validation methods
7. Balance comprehensiveness with executive accessibility
EOF
            ;;
        "implementation_guide")
            cat << 'EOF'
Create an implementation guide for tactical execution. Use this EXACT structure:

# Implementation Guide: [Extract topic from research]

## Implementation Overview
### Strategic Context
[Brief recap of strategic objective and business rationale]

### Implementation Scope
- **Primary Deliverables:** [What will be accomplished]
- **Success Criteria:** [How success will be measured]
- **Timeline:** [Overall implementation period]
- **Resource Requirements:** [Team, budget, technology needs]

### Implementation Principles
1. [Principle 1]: [Why this approach is important]
2. [Principle 2]: [Why this approach is important]
3. [Principle 3]: [Why this approach is important]

## Implementation Roadmap

### Phase 1: Foundation (Months 1-3)
#### Objectives
[What needs to be accomplished in this phase]

#### Key Activities
| Activity | Owner | Duration | Dependencies | Success Metric |
|----------|--------|----------|--------------|----------------|
| [Activity 1] | [Role] | [Time] | [Prerequisites] | [Measure] |
| [Activity 2] | [Role] | [Time] | [Prerequisites] | [Measure] |

#### Deliverables
- **[Deliverable 1]:** [Completion criteria and quality standards]
- **[Deliverable 2]:** [Completion criteria and quality standards]

#### Phase 1 Budget
- Personnel: [Amount and allocation]
- Technology: [Amount and allocation]
- External services: [Amount and allocation]
- **Total Phase 1:** [Amount]

### Phase 2: Implementation (Months 4-9)
#### Objectives
[What needs to be accomplished in this phase]

#### Key Activities
| Activity | Owner | Duration | Dependencies | Success Metric |
|----------|--------|----------|--------------|----------------|
| [Activity 1] | [Role] | [Time] | [Prerequisites] | [Measure] |
| [Activity 2] | [Role] | [Time] | [Prerequisites] | [Measure] |

#### Deliverables
- **[Deliverable 1]:** [Completion criteria and quality standards]
- **[Deliverable 2]:** [Completion criteria and quality standards]

#### Phase 2 Budget
- Personnel: [Amount and allocation]
- Technology: [Amount and allocation]
- External services: [Amount and allocation]
- **Total Phase 2:** [Amount]

### Phase 3: Optimization (Months 10-12)
#### Objectives
[What needs to be accomplished in this phase]

#### Key Activities
| Activity | Owner | Duration | Dependencies | Success Metric |
|----------|--------|----------|--------------|----------------|
| [Activity 1] | [Role] | [Time] | [Prerequisites] | [Measure] |
| [Activity 2] | [Role] | [Time] | [Prerequisites] | [Measure] |

#### Deliverables
- **[Deliverable 1]:** [Completion criteria and quality standards]
- **[Deliverable 2]:** [Completion criteria and quality standards]

#### Phase 3 Budget
- Personnel: [Amount and allocation]
- Technology: [Amount and allocation]
- External services: [Amount and allocation]
- **Total Phase 3:** [Amount]

## Organizational Requirements

### Team Structure
#### Core Implementation Team
- **Project Lead:** [Role requirements and responsibilities]
- **Technical Lead:** [Role requirements and responsibilities]
- **Business Analyst:** [Role requirements and responsibilities]
- **Subject Matter Experts:** [Role requirements and responsibilities]

#### Stakeholder Groups
- **Executive Sponsors:** [Involvement level and responsibilities]
- **Department Heads:** [Involvement level and responsibilities]
- **End Users:** [Involvement level and responsibilities]

### Skills and Training Requirements
- **New Skills Needed:** [Skills and training approach]
- **Training Timeline:** [When training must be completed]
- **Training Budget:** [Estimated costs and providers]

## Technology and Infrastructure

### Technology Requirements
- **New Systems:** [Systems needed and selection criteria]
- **System Integrations:** [Integration requirements and complexity]
- **Data Migration:** [Data requirements and migration approach]

### Infrastructure Requirements
- **Hardware:** [Server, network, and equipment needs]
- **Software:** [Licenses, subscriptions, and maintenance]
- **Security:** [Security requirements and compliance needs]

## Risk Management and Mitigation

### High-Impact Risks
| Risk | Probability | Impact | Mitigation Strategy | Owner |
|------|-------------|---------|-------------------|-------|
| [Risk 1] | [H/M/L] | [H/M/L] | [Prevention/Response] | [Role] |
| [Risk 2] | [H/M/L] | [H/M/L] | [Prevention/Response] | [Role] |

### Contingency Planning
- **Schedule Delays:** [Response strategies for timeline issues]
- **Resource Constraints:** [Alternative approaches if resources unavailable]
- **Technical Challenges:** [Backup plans for technical issues]

## Success Measurement and Monitoring

### Key Performance Indicators
| KPI | Baseline | Target | Measurement Method | Frequency |
|-----|----------|--------|-------------------|-----------|
| [KPI 1] | [Current] | [Goal] | [How measured] | [When] |
| [KPI 2] | [Current] | [Goal] | [How measured] | [When] |

### Milestone Reviews
- **30-Day Review:** [What will be assessed]
- **90-Day Review:** [What will be assessed]  
- **6-Month Review:** [What will be assessed]
- **Annual Review:** [What will be assessed]

### Course Correction Process
1. **Issue Identification:** [How problems are identified]
2. **Impact Assessment:** [How severity is determined]
3. **Solution Development:** [Who develops solutions]
4. **Approval Process:** [Who approves changes]
5. **Communication:** [How stakeholders are informed]

## Budget and Resource Planning

### Total Implementation Budget
| Category | Phase 1 | Phase 2 | Phase 3 | Total |
|----------|---------|---------|---------|-------|
| Personnel | [Amount] | [Amount] | [Amount] | [Amount] |
| Technology | [Amount] | [Amount] | [Amount] | [Amount] |
| External Services | [Amount] | [Amount] | [Amount] | [Amount] |
| Training | [Amount] | [Amount] | [Amount] | [Amount] |
| **Total** | **[Amount]** | **[Amount]** | **[Amount]** | **[Amount]** |

### ROI Projection
- **Total Investment:** [Amount over implementation period]
- **Expected Benefits:** [Quantified annual benefits]
- **Payback Period:** [Time to recover investment]
- **3-Year ROI:** [Projected return percentage]

## Communication and Change Management

### Communication Plan
- **Executive Updates:** [Frequency and format]
- **Team Communications:** [Regular meeting cadence]
- **Stakeholder Briefings:** [Schedule and content approach]

### Change Management Strategy
- **Change Readiness:** [Assessment of organizational readiness]
- **Resistance Management:** [Strategies for overcoming resistance]
- **Adoption Support:** [Training and support approaches]

---
*Implementation Guide prepared by: Project Management Office*  
*Guide Date: [Current Date]*  
*Next Update: [Monthly during implementation]*  
*Classification: Implementation Planning*  
*Distribution: Implementation Team and Stakeholders*

CRITICAL INSTRUCTIONS:
1. Make every activity actionable with clear owners and deadlines
2. Include detailed budget breakdowns and ROI projections
3. Focus on practical execution challenges and solutions
4. Provide specific measurement criteria and success metrics
5. Use project management best practices throughout
6. Include realistic timelines with buffer for complexity
7. Address change management and organizational readiness
EOF
            ;;
        *)
            echo "❌ Error: Unknown document type '$doc_type'"
            echo "Available types: strategic_analysis, executive_briefing, market_intelligence, implementation_guide"
            exit 1
            ;;
    esac
}

# Collect all project data for analysis
echo "📚 Collecting project data..."
PROJECT_DATA_FILE=$(mktemp)

# Combine all research data (similar to what run-mega-analysis.sh does)
{
    echo "=== PROJECT RESEARCH DATA ==="
    echo "Project: $PROJECT_FOLDER"
    echo "Generated: $(date)"
    echo ""
    
    # Include searches
    if [ -d "$PROJECT_FOLDER/01_searches" ]; then
        echo "=== SEARCH RESULTS ==="
        find "$PROJECT_FOLDER/01_searches" -type f \( -name "*.md" -o -name "*.json" \) -print0 | while IFS= read -r -d '' file; do
            echo "--- FILE: $file ---"
            cat "$file"
            echo ""
        done
    fi
    
    # Include content
    if [ -d "$PROJECT_FOLDER/02_fetched_content" ]; then
        echo "=== FETCHED CONTENT ==="
        find "$PROJECT_FOLDER/02_fetched_content" -type f -name "*.md" -print0 | while IFS= read -r -d '' file; do
            echo "--- FILE: $file ---"
            cat "$file"
            echo ""
        done
    fi
    
    # Include analysis
    if [ -d "$PROJECT_FOLDER/04_analysis" ]; then
        echo "=== ANALYSIS ==="
        find "$PROJECT_FOLDER/04_analysis" -type f -name "*.md" -print0 | while IFS= read -r -d '' file; do
            echo "--- FILE: $file ---"
            cat "$file"
            echo ""
        done
    fi
    
    # Include synthesis
    if [ -d "$PROJECT_FOLDER/05_synthesis" ]; then
        echo "=== SYNTHESIS ==="
        find "$PROJECT_FOLDER/05_synthesis" -type f -name "*.md" -print0 | while IFS= read -r -d '' file; do
            echo "--- FILE: $file ---"
            cat "$file"
            echo ""
        done
    fi
    
    # Include final reports
    if [ -d "$PROJECT_FOLDER/FINAL_REPORTS" ]; then
        echo "=== FINAL REPORTS ==="
        find "$PROJECT_FOLDER/FINAL_REPORTS" -type f -name "*.md" -print0 | while IFS= read -r -d '' file; do
            echo "--- FILE: $file ---"
            cat "$file"
            echo ""
        done
    fi
    
} > "$PROJECT_DATA_FILE"

PROJECT_DATA=$(cat "$PROJECT_DATA_FILE")
rm "$PROJECT_DATA_FILE"

echo "📝 Generating enterprise document prompt..."

# Generate the full prompt combining template and data
ENTERPRISE_PROMPT="$(generate_enterprise_prompt "$DOCUMENT_TYPE" "$PROJECT_DATA")

RESEARCH DATA TO ANALYZE:
$PROJECT_DATA

IMPORTANT: Create a professional, enterprise-ready document using ONLY the data provided above. Follow the template structure exactly. Use specific statistics and quotes from the research data. Write in an authoritative consulting tone suitable for C-level executives."

# Create output file path
OUTPUT_FILE="$PROJECT_FOLDER/05_synthesis/${OUTPUT_NAME}.md"

echo "🔄 Generating enterprise document with Claude..."

# Generate the document using Claude
echo "$ENTERPRISE_PROMPT" | claude > "$OUTPUT_FILE"

echo "✅ Enterprise document created: $OUTPUT_FILE"

# Generate PDF version
echo "📄 Creating PDF version..."
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -f "$SCRIPT_DIR/create-document.sh" ] && [ -x "$SCRIPT_DIR/create-document.sh" ]; then
    "$SCRIPT_DIR/create-document.sh" "$OUTPUT_FILE"
    echo "✅ PDF version created: ${OUTPUT_FILE%.md}.pdf"
else
    echo "⚠️  PDF generation skipped (create-document.sh not available)"
fi

echo ""
echo "🎉 Enterprise Document Generation Complete!"
echo "📁 Document: $OUTPUT_FILE"
echo "📋 Type: $DOCUMENT_TYPE"
echo "✨ Quality: Enterprise-ready for C-level consumption"