#!/bin/bash

# Research Type Structure Definitions
# Defines the three distinct research types and their frameworks

set -e

RESEARCH_TYPE="${1:-organization}"
PROJECT_DIR="${2:-}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🏗️ Research Type Structure Generator"
echo "===================================="
echo "Type: $RESEARCH_TYPE"
echo ""

# Function to create individual research structure
create_individual_structure() {
  local project_dir="$1"
  
  echo "👤 Creating INDIVIDUAL Reputational Scan Structure..."
  
  # Create structure template
  cat > "$project_dir/RESEARCH_FRAMEWORK.md" << 'EOF'
# Individual Reputational Assessment Framework

## Research Type: INDIVIDUAL
**Focus:** Personal reputation, professional history, and public presence

## Phase 1: Identity & Background (Surface Intelligence)
- Full legal name and aliases
- Date and place of birth
- Educational background
- Professional certifications
- Current and past positions
- Board memberships
- Public speaking engagements

## Phase 2: Professional Network Analysis
- Direct professional connections
- Indirect influence networks
- Mentorship relationships
- Industry affiliations
- Conference participation
- Published works and thought leadership

## Phase 3: Financial Footprint
- Disclosed compensation (if public)
- Stock holdings and options
- Real estate records
- Business ownership stakes
- Charitable giving patterns
- Political contributions

## Phase 4: Digital Presence Analysis
- Social media profiles and activity
- Online publications and interviews
- Podcast appearances
- Video content and webinars
- Press mentions and media coverage
- Professional platform profiles (LinkedIn, etc.)

## Phase 5: Reputational Risk Assessment
- Past controversies or scandals
- Legal issues or litigation
- Regulatory actions
- Conflicts of interest
- Negative media coverage
- Online sentiment analysis

## Phase 6: Behavioral Pattern Analysis
- Communication style and tone
- Decision-making patterns
- Leadership approach
- Public statements and positions
- Response to criticism
- Crisis management history

## Executive Summary Components
- Professional trajectory summary
- Key achievements and recognition
- Network influence score
- Reputational risk rating
- Red flags and concerns
- Recommended monitoring areas

## Citation Requirements
- Every biographical fact must be sourced
- All financial data requires documentation
- Social media posts need timestamps
- Media mentions need publication details
- Legal records need case numbers
EOF

  # Create data collection templates
  mkdir -p "$project_dir/templates"
  
  cat > "$project_dir/templates/individual_data_points.json" << 'EOF'
{
  "personal_info": {
    "full_name": "",
    "aliases": [],
    "date_of_birth": "",
    "place_of_birth": "",
    "nationality": "",
    "languages": []
  },
  "education": [
    {
      "institution": "",
      "degree": "",
      "field": "",
      "year": "",
      "honors": ""
    }
  ],
  "professional": {
    "current_position": "",
    "company": "",
    "tenure": "",
    "previous_positions": [],
    "board_memberships": [],
    "advisory_roles": []
  },
  "digital_footprint": {
    "linkedin": "",
    "twitter": "",
    "personal_website": "",
    "publications": [],
    "speaking_engagements": []
  },
  "reputation_metrics": {
    "media_sentiment": "",
    "controversy_score": "",
    "influence_rating": "",
    "risk_level": ""
  }
}
EOF

  echo "✅ Individual structure created"
}

# Function to create organization research structure
create_organization_structure() {
  local project_dir="$1"
  
  echo "🏢 Creating ORGANIZATION Reputational Scan Structure..."
  
  cat > "$project_dir/RESEARCH_FRAMEWORK.md" << 'EOF'
# Organizational Reputational Assessment Framework

## Research Type: ORGANIZATION
**Focus:** Corporate reputation, market position, and stakeholder perception

## Phase 1: Corporate Overview (Surface Intelligence)
- Legal entity name and DBAs
- Incorporation details and jurisdiction
- Corporate structure and subsidiaries
- Ownership structure
- Revenue and employee count
- Industry classification
- Headquarters and office locations

## Phase 2: Leadership & Governance
- Executive team profiles
- Board of directors composition
- Key personnel changes
- Management stability metrics
- Compensation structures
- Succession planning
- Corporate governance scores

## Phase 3: Financial Performance Analysis
- Revenue trends (3-5 years)
- Profitability metrics
- Market capitalization/valuation
- Debt and liquidity position
- Credit ratings
- Investor relations
- Analyst coverage and ratings

## Phase 4: Market Position & Competition
- Market share analysis
- Competitive landscape mapping
- Product/service portfolio
- Customer base composition
- Strategic partnerships
- M&A activity
- Innovation pipeline

## Phase 5: Stakeholder Perception
- Customer satisfaction scores
- Employee reviews (Glassdoor, etc.)
- Vendor/partner feedback
- Media sentiment analysis
- Social media monitoring
- Industry awards and recognition
- ESG ratings and sustainability

## Phase 6: Risk & Compliance Assessment
- Regulatory compliance status
- Legal proceedings and litigation
- Data breaches or security incidents
- Product recalls or safety issues
- Environmental violations
- Labor disputes
- Sanctions or penalties

## Executive Summary Components
- Business model and strategy overview
- Financial health score
- Market position assessment
- Leadership effectiveness rating
- Stakeholder sentiment summary
- Risk exposure analysis
- Investment/partnership recommendation

## Citation Requirements
- Financial data from official filings
- Leadership info from company sources
- Market data from industry reports
- Legal issues from court records
- Media coverage with dates/sources
EOF

  # Create organization data templates
  mkdir -p "$project_dir/templates"
  
  cat > "$project_dir/templates/organization_data_points.json" << 'EOF'
{
  "corporate_info": {
    "legal_name": "",
    "trade_names": [],
    "founded": "",
    "incorporated": "",
    "jurisdiction": "",
    "tax_id": "",
    "industry_codes": []
  },
  "financials": {
    "revenue": "",
    "revenue_growth": "",
    "ebitda": "",
    "net_income": "",
    "total_assets": "",
    "total_debt": "",
    "credit_rating": ""
  },
  "operations": {
    "employees": "",
    "locations": [],
    "subsidiaries": [],
    "key_products": [],
    "key_customers": [],
    "market_share": ""
  },
  "leadership": {
    "ceo": "",
    "cfo": "",
    "key_executives": [],
    "board_members": [],
    "major_shareholders": []
  },
  "reputation_metrics": {
    "customer_satisfaction": "",
    "employee_rating": "",
    "esg_score": "",
    "media_sentiment": "",
    "risk_rating": ""
  }
}
EOF

  echo "✅ Organization structure created"
}

# Function to create audience research structure
create_audience_structure() {
  local project_dir="$1"
  
  echo "🎯 Creating AUDIENCE Scan Structure..."
  
  cat > "$project_dir/RESEARCH_FRAMEWORK.md" << 'EOF'
# Audience Intelligence Framework

## Research Type: AUDIENCE
**Focus:** Target audience analysis, keyword insights, and market segmentation

## Phase 1: Audience Demographics
- Age distribution
- Gender breakdown
- Geographic distribution
- Income levels
- Education levels
- Occupation categories
- Lifestyle segments

## Phase 2: Psychographic Analysis
- Values and beliefs
- Interests and hobbies
- Media consumption habits
- Brand preferences
- Purchase motivations
- Decision-making factors
- Pain points and challenges

## Phase 3: Digital Behavior Patterns
- Platform preferences (social, search, etc.)
- Content consumption patterns
- Device usage (mobile, desktop, tablet)
- Peak activity times
- Engagement metrics
- Sharing behavior
- Community participation

## Phase 4: Keyword Intelligence (DataForSEO Integration)
- High-volume search terms
- Long-tail keyword opportunities
- Competitor keyword gaps
- Seasonal search trends
- Question-based queries
- Commercial intent keywords
- Local search patterns

## Phase 5: Content Preferences
- Content format preferences (video, text, audio)
- Topic interests and themes
- Content length preferences
- Visual style preferences
- Tone and voice preferences
- Educational vs entertainment balance
- User-generated content engagement

## Phase 6: Competitive Audience Analysis
- Competitor audience overlap
- Unique audience segments
- Competitor content performance
- Gap analysis opportunities
- Audience migration patterns
- Brand switching triggers
- Loyalty factors

## Executive Summary Components
- Core audience profile summary
- Primary segments identification
- Keyword opportunity matrix
- Content strategy recommendations
- Channel optimization priorities
- Engagement tactics roadmap
- Testing and measurement plan

## DataForSEO Integration Points
- Keyword search volume data
- Competition analysis metrics
- Related keyword suggestions
- SERP feature opportunities
- Local search insights
- Trend analysis data

## Citation Requirements
- Demographic data sources
- Survey methodologies
- Analytics platforms used
- Keyword data timestamps
- Competitive intelligence sources
EOF

  # Create audience data templates
  mkdir -p "$project_dir/templates"
  
  cat > "$project_dir/templates/audience_data_points.json" << 'EOF'
{
  "demographics": {
    "age_ranges": {},
    "gender_split": {},
    "locations": [],
    "income_brackets": {},
    "education_levels": {},
    "occupations": []
  },
  "psychographics": {
    "interests": [],
    "values": [],
    "lifestyle_segments": [],
    "brand_affinities": [],
    "media_preferences": [],
    "purchase_drivers": []
  },
  "digital_behavior": {
    "platforms": {
      "facebook": "",
      "instagram": "",
      "twitter": "",
      "linkedin": "",
      "tiktok": "",
      "youtube": ""
    },
    "content_preferences": [],
    "engagement_times": [],
    "device_usage": {}
  },
  "keyword_intelligence": {
    "primary_keywords": [],
    "long_tail_keywords": [],
    "search_volumes": {},
    "competition_scores": {},
    "trend_data": {},
    "seasonal_patterns": {}
  },
  "content_strategy": {
    "recommended_topics": [],
    "content_formats": [],
    "posting_schedule": {},
    "engagement_tactics": [],
    "measurement_kpis": []
  }
}
EOF

  # Create DataForSEO toggle configuration
  cat > "$project_dir/templates/dataforseo_config.json" << 'EOF'
{
  "enabled": false,
  "api_key": "",
  "endpoints": {
    "keyword_volume": true,
    "keyword_difficulty": true,
    "related_keywords": true,
    "serp_analysis": false,
    "competitor_keywords": false
  },
  "limits": {
    "max_keywords": 100,
    "max_api_calls": 10
  },
  "settings": {
    "location": "United States",
    "language": "en",
    "device": "desktop"
  }
}
EOF

  echo "✅ Audience structure created with DataForSEO configuration"
}

# Main execution
if [ -n "$PROJECT_DIR" ]; then
  case "$RESEARCH_TYPE" in
    "individual")
      create_individual_structure "$PROJECT_DIR"
      ;;
    "organization")
      create_organization_structure "$PROJECT_DIR"
      ;;
    "audience")
      create_audience_structure "$PROJECT_DIR"
      ;;
    *)
      echo "❌ Invalid research type: $RESEARCH_TYPE"
      echo "Valid types: individual, organization, audience"
      exit 1
      ;;
  esac
else
  echo "📋 Available Research Type Structures:"
  echo ""
  echo "1. INDIVIDUAL - Personal reputational assessment"
  echo "   Focus: Professional history, network analysis, digital presence"
  echo "   Use: Executive due diligence, spokesperson vetting, partnership evaluation"
  echo ""
  echo "2. ORGANIZATION - Corporate reputational analysis"
  echo "   Focus: Business performance, leadership, market position, compliance"
  echo "   Use: Investment due diligence, M&A research, competitive intelligence"
  echo ""
  echo "3. AUDIENCE - Target audience intelligence"
  echo "   Focus: Demographics, psychographics, keywords, content preferences"
  echo "   Use: Marketing strategy, content planning, campaign development"
  echo "   Note: Includes DataForSEO integration (toggle on/off)"
  echo ""
  echo "Usage: $0 <research_type> <project_directory>"
fi