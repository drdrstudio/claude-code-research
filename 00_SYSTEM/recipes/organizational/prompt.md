# Mission Briefing: Deep Organizational Scan (v1.0)
## Compatible with MRP v6.1.2

### 1. Primary Objective
To conduct an exhaustive, "opposition research" level scan of all publicly available online information regarding **[ORGANIZATION_NAME]** and its key leadership. The goal is to identify any and all potential reputational, financial, operational, and legal liabilities. The final output must be a comprehensive, meticulously cited, and defensible intelligence dossier.

### 2. Key Areas of Investigation (content.streams)
The research must be structured around the following four vectors:

#### A. Corporate & Financial Health
- **SEC Filings & Financial Statements**
  - 10-K, 10-Q, 8-K filings (if public)
  - Annual reports and investor presentations
  - Auditor reports and material disclosures
  - Financial ratios and trend analysis
  
- **M&A History & Investment Activity**
  - Complete acquisition history with valuations
  - Divestitures and spin-offs
  - Funding rounds and major investors
  - Failed acquisitions or investments
  
- **Market Performance Analysis**
  - Stock price history and volatility
  - Analyst ratings and price targets
  - Earnings call transcripts
  - Comparative performance vs. competitors

#### B. Market Position & Public Perception
- **Media Coverage Analysis**
  - Comprehensive media timeline (positive/negative/neutral)
  - Crisis events and company response
  - Executive interviews and public statements
  - Press release analysis
  
- **Customer & Product Intelligence**
  - Product/service reviews across platforms
  - BBB complaints and resolutions
  - Consumer forum discussions
  - Regulatory complaints (FTC, CFPB, etc.)
  
- **Social Media Sentiment**
  - Reddit community discussions (r/company, r/investing, etc.)
  - X/Twitter sentiment analysis
  - LinkedIn company page engagement
  - Glassdoor and Indeed reviews

#### C. Operational & Cultural Health
- **Employee Intelligence**
  - Glassdoor detailed analysis (themes, trends, red flags)
  - Indeed and Comparably reviews
  - LinkedIn employee movement patterns
  - Anonymous employee forums (Blind, etc.)
  
- **Operational Risk Assessment**
  - Layoff history and patterns
  - Litigation involving employees
  - EEOC complaints and settlements
  - Union activity or labor disputes
  
- **Supply Chain & Dependencies**
  - Key supplier relationships
  - Customer concentration risk
  - Geographic/political exposure
  - Technology dependencies

#### D. Leadership Vetting (CRITICAL - Two-Level Scan)
- **Level 1 Scan: Leadership Identification**
  - All C-suite executives (CEO, CFO, CTO, COO, etc.)
  - Board of Directors members
  - Key SVPs and divisional heads
  - Recent departures (last 2 years)
  
- **Level 2 Scan: Individual Deep Dives**
  For each key individual identified, conduct condensed reputational scan:
  - Professional history and past roles
  - Previous business failures or bankruptcies
  - Legal issues (lawsuits, regulatory actions)
  - Controversial statements or actions
  - Network connections that pose risks
  - Personal scandals affecting business reputation

### 3. Critical Deliverable Requirements

#### The Master Dossier
- **Length**: 20-50+ pages (minimum 20 pages enforced)
- **Format**: Professional intelligence report via Pandoc/Tectonic pipeline
- **Structure**:
  - Executive Summary with Risk Matrix
  - Company Overview & History
  - Financial Health Assessment
  - Market Position Analysis
  - Operational Risk Evaluation
  - Leadership Liability Assessment
  - Competitive Intelligence
  - Strategic Recommendations

#### Meticulous Source Citation
- **Every fact** MUST be followed by a Markdown footnote with verifiable URL
- **Minimum citations**: 50+ sources required
- **Source diversity**: Financial, media, social, employee, regulatory
- **Financial data**: Must cite SEC EDGAR or equivalent
- **Citation format**: `[^1]` with full URL and access date in bibliography

#### The Knowledge Graph
- **Core visualization elements**:
  - Organization structure and subsidiaries
  - Leadership network with risk indicators
  - Competitor ecosystem mapping
  - Key stakeholder relationships
  - Timeline of critical events
- **Liability mapping**: Clear visual connection between risks and sources
- **Export format**: Neo4j compatible with risk heat mapping

### 4. Operational Parameters
```json
{
  "approval_mode": "interactive",
  "require_source_approval": true,
  "require_outline_approval": true,
  "verification_level": "high",
  "fact_checking_depth": "maximum",
  "source_quality_minimum": 3,
  "financial_verification": true,
  "leadership_scan_depth": 2,
  "competitor_analysis": true
}
```

### 5. Research Phases (Simplified Quality-First Protocol)

#### Phase 1: Completeness Initialization
- Generate PROJECT_CONFIG.json with comprehensive settings
- Verify ALL tools accessible and prepare for deep extraction
- Set up patient execution environment
- **CRITICAL**: Enable thorough multi-pass extraction

#### Phase 2: Strategic Planning (Sequential Thinking)
- Engage Sequential-Thinking MCP for exhaustive strategy
- Map COMPLETE organization structure including all subsidiaries
- Identify ENTIRE competitor ecosystem (10+ competitors)
- Create comprehensive leadership scan matrix (all executives)

#### Phase 3: Exhaustive Intelligence Gathering
**EXECUTE IN PARALLEL BUT WAIT FOR COMPLETE RESULTS:**
- **Financial Layer**: Complete SEC history + all analyst reports + complete news archive
- **Employee Layer**: EVERY review on Glassdoor + all Reddit mentions + complete LinkedIn analysis
- **Customer Layer**: All platforms thoroughly mined - no sampling
- **Technical Layer**: Complete GitHub history + all Stack Overflow mentions
- **News Layer**: 10-year news archive minimum

#### Phase 4: Instant Extraction & Quality Assessment
- Parallel extraction of ALL sources (no waiting)
- Assign Source Quality Scores in bulk
- Generate Source_Manifest.md
- **NO APPROVAL GATES**: Continue processing while awaiting approval

#### Phase 5: Multi-Dimensional Synthesis
- Financial health assessment with trend analysis
- **NEW**: Employee sentiment index from Glassdoor/Reddit
- **NEW**: Customer satisfaction scoring from social sources
- **NEW**: Technical reputation assessment (if applicable)
- Create unified risk matrix combining all dimensions

#### Phase 5.5: Cross-Verification & Social Proof
- Triangulate financial claims with multiple sources
- **NEW**: Validate employee claims across platforms
- **NEW**: Cross-reference customer complaints
- Compare insider (employee) vs outsider (customer) perspectives
- Generate Verification_Report.md

#### Phase 6: Advanced Synthesis with Gemini
- Execute run-mega-analysis.sh
- Generate competitive intelligence with social sentiment
- Create predictive models using all data layers
- Build strategic recommendations with confidence scores

#### Phase 7: Finalization & Delivery
- Generate master dossier with company branding
- **NEW**: Include social sentiment dashboard
- Build enhanced knowledge graph with sentiment layers
- Create methodology appendix
- Upload to NotebookLM
- Update GLOBAL_RESEARCH_INDEX.csv

### 6. Quality Standards

#### Minimum Requirements
- 20+ pages of substantive content
- 50+ authoritative source citations
- Complete financial analysis (if public)
- All C-suite and board members vetted
- Competitor analysis included
- Risk matrix completed

#### Excellence Indicators
- 30-50 pages comprehensive analysis
- 75+ diverse sources
- 5-year financial trend analysis
- Leadership network fully mapped
- Predictive risk modeling
- Actionable M&A or investment recommendations

### 7. Quality Stack Intelligence Architecture (Comprehensive)

#### CORE PRINCIPLE: COMPLETENESS > SPEED > COST - Exhaustive coverage for premium intelligence

#### Financial & Market Intelligence Layer
- **DataForSEO**: Enterprise SERP data and competitive analysis (INSTANT USE)
- **SEC EDGAR**: Real financial filings and disclosures (PRIMARY SOURCE)
- **Firecrawl MCP**: Deep extraction of financial documents (NO DELAYS)
- **Perplexity MCP**: Business intelligence synthesis (AGGRESSIVE USE)

#### Employee & Culture Intelligence Layer (CRITICAL)
- **Glassdoor API**: Employee sentiment and cultural health (PRIORITY)
- **Reddit MCP**: Authentic employee discussions (r/company subreddits)
- **LinkedIn Data**: Employee movement patterns and talent drain
- **Blind App Data**: Anonymous employee truth (if available)

#### Public Sentiment & Brand Health Layer
- **Reddit MCP**: Customer complaints and community perception
- **X/Twitter (Apify)**: Real-time brand sentiment and crisis detection
- **YouTube Comments**: Product reviews and customer feedback
- **Trustpilot/BBB**: Business ratings and complaint patterns

#### Technical Footprint Layer (for Tech Companies)
- **GitHub API**: Open source activity and developer relations
- **Stack Overflow**: Developer sentiment and support quality
- **Product Hunt**: Launch reception and innovation perception

#### Execution Philosophy
- **COMPREHENSIVE COVERAGE**: Every data source must be exhaustively mined
- **PATIENT EXTRACTION**: Wait for complete results from all sources
- **MULTI-PASS ANALYSIS**: Return to sources for deeper extraction
- **HISTORICAL DEPTH**: 5+ years minimum, 10+ years ideal
- **NO GAPS ALLOWED**: Retry failed sources, find alternative paths

### 8. Special Considerations for Organizations

#### Public vs. Private Companies
- **Public**: Focus on SEC filings, analyst reports, earnings calls
- **Private**: Emphasize news coverage, funding rounds, leadership
- **Non-profit**: 990 forms, charity ratings, donor analysis

#### Industry-Specific Requirements
- **Tech**: Patent portfolios, GitHub activity, developer sentiment
- **Healthcare**: FDA issues, clinical trials, patient safety
- **Financial**: Regulatory actions, AML issues, customer complaints
- **Retail**: Store closures, inventory issues, customer sentiment

### 9. Final Output Checklist

Before marking complete, verify:
- [ ] Minimum 20 pages achieved
- [ ] 50+ sources cited with URLs
- [ ] All financial data verified
- [ ] Leadership vetting completed (Level 1 & 2)
- [ ] Competitor analysis included
- [ ] Knowledge graph generated
- [ ] Risk matrix completed
- [ ] Company logo acquired and included
- [ ] Executive summary finalized
- [ ] PDF generated with corporate template

### 10. Template and Formatting
- **Primary template**: Corporate (with company branding)
- **Alternative**: Tufte (for financial focus)
- **Logo**: Required - acquire from company website
- **Charts**: Financial trends, org chart, risk matrix
- **Color scheme**: Professional with company colors if available

### 11. Critical Intelligence Gaps for Organizations
**ALWAYS CHECK FOR:**
- **ESG Controversies**: Environmental violations, social issues, governance failures
- **Cybersecurity Incidents**: Data breaches, ransomware attacks, security posture
- **Patent Litigation**: IP disputes and innovation challenges
- **Regulatory Pipeline**: Upcoming regulations affecting the business
- **Supply Chain Vulnerabilities**: Single points of failure, geopolitical risks
- **Key Person Risk**: Over-dependence on specific executives
- **Cultural Red Flags**: Patterns in Glassdoor/Reddit indicating systemic issues
- **Customer Concentration**: Revenue dependency on few clients

### 12. Final Instruction
**Your first task**: Take this mission briefing and generate the PROJECT_CONFIG.json for approval, ensuring all parameters align with the comprehensive completeness-first protocol. The configuration must:
1. Enable patient, exhaustive extraction (completeness > speed)
2. Configure parallel execution BUT require waiting for all results
3. Mandate COMPLETE employee sentiment analysis (every review, every platform)
4. Set retry mechanisms for any failed sources
5. Require 10-year financial history analysis (where available)
6. Include multi-dimensional risk assessment with full evidence trails
7. Map ALL leadership relationships to third degree
8. Extract EVERY customer review across all platforms