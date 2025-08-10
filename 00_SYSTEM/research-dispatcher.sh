#!/bin/bash
#
# research-dispatcher.sh
# Universal research dispatcher that routes to appropriate scripts based on research type
# Integrates with the web frontend and existing MRP system
#

set -e

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
PROJECTS_DIR="$PROJECT_ROOT/03_PROJECTS"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[$(date +'%Y-%m-%d %H:%M:%S')]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

# Function to display usage
show_usage() {
    cat << EOF
Usage: $0 [OPTIONS] TARGET_NAME "RESEARCH_PROMPT"

Research Types:
  --individual     Individual/Person research (opposition research, executive profiling)
  --company        Company/Business analysis (competitive intelligence, market position)
  --seo           SEO and content analysis
  --market        Market research and ICP analysis
  --technical     Technical infrastructure audit
  --custom        Custom research with flexible parameters

Options:
  --config FILE   Use custom PROJECT_CONFIG.json file
  --depth LEVEL   Research depth: executive|standard|comprehensive|deep-dive
  --output TYPE   Output format: document|presentation|both|raw
  --client NAME   Client branding: pharos|duarte|none
  --mega          Enable Gemini mega-analysis (default: true)
  --help          Show this help message

Examples:
  $0 --individual "John Doe" "Comprehensive background check and reputation assessment"
  $0 --company "Acme Corp" "Competitive analysis and market position"
  $0 --seo "example.com" "Full SEO audit and content opportunity analysis"

EOF
    exit 0
}

# Parse command line arguments
RESEARCH_TYPE=""
TARGET_NAME=""
RESEARCH_PROMPT=""
CONFIG_FILE=""
RESEARCH_DEPTH="standard"
OUTPUT_TYPE="document"
CLIENT_BRANDING="none"
ENABLE_MEGA="true"

while [[ $# -gt 0 ]]; do
    case $1 in
        --individual)
            RESEARCH_TYPE="individual-oppo"
            shift
            ;;
        --company)
            RESEARCH_TYPE="company-deep"
            shift
            ;;
        --seo)
            RESEARCH_TYPE="seo-analysis"
            shift
            ;;
        --market)
            RESEARCH_TYPE="market-research"
            shift
            ;;
        --technical)
            RESEARCH_TYPE="technical-audit"
            shift
            ;;
        --custom)
            RESEARCH_TYPE="custom"
            shift
            ;;
        --config)
            CONFIG_FILE="$2"
            shift 2
            ;;
        --depth)
            RESEARCH_DEPTH="$2"
            shift 2
            ;;
        --output)
            OUTPUT_TYPE="$2"
            shift 2
            ;;
        --client)
            CLIENT_BRANDING="$2"
            shift 2
            ;;
        --mega)
            ENABLE_MEGA="$2"
            shift 2
            ;;
        --help)
            show_usage
            ;;
        *)
            if [ -z "$TARGET_NAME" ]; then
                TARGET_NAME="$1"
            elif [ -z "$RESEARCH_PROMPT" ]; then
                RESEARCH_PROMPT="$1"
            fi
            shift
            ;;
    esac
done

# Validate required parameters
if [ -z "$RESEARCH_TYPE" ] || [ -z "$TARGET_NAME" ] || [ -z "$RESEARCH_PROMPT" ]; then
    print_error "Missing required parameters"
    show_usage
fi

# Generate project folder name
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
SANITIZED_NAME=$(echo "$TARGET_NAME" | sed 's/[^a-zA-Z0-9]//g')
TYPE_PREFIX=$(echo "$RESEARCH_TYPE" | cut -d'-' -f1)
PROJECT_FOLDER="Research_${TYPE_PREFIX}_${SANITIZED_NAME}_${TIMESTAMP}"

# Determine client folder
case "$CLIENT_BRANDING" in
    pharos)
        CLIENT_FOLDER="Pharos"
        ;;
    duarte)
        CLIENT_FOLDER="Duarte"
        ;;
    *)
        CLIENT_FOLDER="General"
        ;;
esac

PROJECT_PATH="$PROJECTS_DIR/$CLIENT_FOLDER/$PROJECT_FOLDER"

print_status "Initializing research project: $PROJECT_FOLDER"
print_info "Research Type: $RESEARCH_TYPE"
print_info "Target: $TARGET_NAME"
print_info "Project Path: $PROJECT_PATH"

# Create project structure
mkdir -p "$PROJECT_PATH"/{01_searches,02_fetched_content,03_extracted_data,04_analysis,05_synthesis,06_metadata}

# Create PROJECT_CONFIG.json based on research type
create_project_config() {
    local config_file="$PROJECT_PATH/PROJECT_CONFIG.json"
    
    case "$RESEARCH_TYPE" in
        "individual-oppo")
            cat > "$config_file" << EOF
{
  "profile": "Deep-Dive",
  "topic": "$TARGET_NAME",
  "primary_objective": "$RESEARCH_PROMPT",
  "project_type": "INDIVIDUAL",
  "framework": "6-Phase Strategic Intelligence",
  "use_dataforseo_mcp": false,
  "perform_mega_analysis": $ENABLE_MEGA,
  "default_deliverable": "$OUTPUT_TYPE",
  "research_depth": "$RESEARCH_DEPTH",
  "phases": [
    "Surface Intelligence",
    "Financial Intelligence",
    "Legal Intelligence",
    "Network Intelligence",
    "Risk Assessment",
    "Competitive Intelligence"
  ],
  "custom_parameters": {
    "min_pages": 20,
    "min_citations": 50,
    "include_timeline": true,
    "include_network_map": true
  }
}
EOF
            ;;
        "company-deep")
            cat > "$config_file" << EOF
{
  "profile": "Company-Analysis",
  "topic": "$TARGET_NAME",
  "primary_objective": "$RESEARCH_PROMPT",
  "project_type": "BUSINESS",
  "framework": "Business Strategic Intelligence",
  "use_dataforseo_mcp": true,
  "perform_mega_analysis": $ENABLE_MEGA,
  "default_deliverable": "$OUTPUT_TYPE",
  "research_depth": "$RESEARCH_DEPTH",
  "phases": [
    "Market Position Analysis",
    "Financial Performance Review",
    "Competitive Landscape Assessment",
    "Technology Stack Analysis",
    "Leadership & Culture Evaluation",
    "Strategic Opportunities & Risks"
  ],
  "custom_parameters": {
    "include_logo": true,
    "include_swot": true,
    "include_market_share": true,
    "competitor_analysis_depth": "comprehensive"
  }
}
EOF
            ;;
        "seo-analysis")
            cat > "$config_file" << EOF
{
  "profile": "SEO-Analysis",
  "topic": "$TARGET_NAME",
  "primary_objective": "$RESEARCH_PROMPT",
  "project_type": "BUSINESS",
  "framework": "SEO Intelligence Framework",
  "use_dataforseo_mcp": true,
  "perform_mega_analysis": false,
  "default_deliverable": "$OUTPUT_TYPE",
  "research_depth": "$RESEARCH_DEPTH",
  "focus_areas": [
    "Keyword Research & Opportunities",
    "Competitor SEO Analysis",
    "Content Gap Analysis",
    "Technical SEO Audit",
    "Backlink Profile Assessment",
    "Local SEO Performance"
  ],
  "custom_parameters": {
    "include_keyword_rankings": true,
    "include_traffic_estimates": true,
    "include_technical_recommendations": true
  }
}
EOF
            ;;
        "market-research")
            cat > "$config_file" << EOF
{
  "profile": "Market-Research",
  "topic": "$TARGET_NAME",
  "primary_objective": "$RESEARCH_PROMPT",
  "project_type": "BUSINESS",
  "framework": "GTM Intelligence Framework",
  "use_dataforseo_mcp": true,
  "perform_mega_analysis": $ENABLE_MEGA,
  "default_deliverable": "$OUTPUT_TYPE",
  "research_depth": "$RESEARCH_DEPTH",
  "phases": [
    "ICP Definition & Segmentation",
    "Pain Points & Needs Analysis",
    "Buying Process Mapping",
    "Competitive Landscape",
    "Market Sizing & Opportunity",
    "Go-to-Market Strategy Recommendations"
  ],
  "custom_parameters": {
    "include_tam_sam_som": true,
    "include_buyer_personas": true,
    "include_messaging_framework": true
  }
}
EOF
            ;;
        *)
            cat > "$config_file" << EOF
{
  "profile": "Custom",
  "topic": "$TARGET_NAME",
  "primary_objective": "$RESEARCH_PROMPT",
  "project_type": "CUSTOM",
  "use_dataforseo_mcp": false,
  "perform_mega_analysis": $ENABLE_MEGA,
  "default_deliverable": "$OUTPUT_TYPE",
  "research_depth": "$RESEARCH_DEPTH",
  "custom_parameters": {}
}
EOF
            ;;
    esac
    
    print_status "Created PROJECT_CONFIG.json"
}

# Create RESEARCH_LOG.md
create_research_log() {
    cat > "$PROJECT_PATH/RESEARCH_LOG.md" << EOF
# Research Log

## Project Information
- **Project ID:** $PROJECT_FOLDER
- **Target:** $TARGET_NAME
- **Type:** $RESEARCH_TYPE
- **Started:** $(date -Iseconds)
- **Status:** Initialized

## Research Objective
$RESEARCH_PROMPT

## Configuration
- Research Depth: $RESEARCH_DEPTH
- Output Format: $OUTPUT_TYPE
- Mega Analysis: $ENABLE_MEGA
- Client Branding: $CLIENT_BRANDING

## Activity Log
- [$(date -Iseconds)] Project initialized by research-dispatcher.sh
- [$(date -Iseconds)] Created project structure and configuration files

## Phase Progress
- [ ] Phase 1: Information Gathering
- [ ] Phase 2: Content Extraction
- [ ] Phase 3: Data Analysis
- [ ] Phase 4: Synthesis
- [ ] Phase 5: Report Generation
- [ ] Phase 6: Quality Review

## Notes
Research in progress...
EOF
    
    print_status "Created RESEARCH_LOG.md"
}

# Main execution
main() {
    # Create configuration files
    if [ -n "$CONFIG_FILE" ] && [ -f "$CONFIG_FILE" ]; then
        cp "$CONFIG_FILE" "$PROJECT_PATH/PROJECT_CONFIG.json"
        print_status "Using custom configuration file"
    else
        create_project_config
    fi
    
    create_research_log
    
    print_status "Project initialization complete"
    print_info "="
    print_info "Next Steps:"
    print_info "1. Navigate to: cd \"$PROJECT_PATH\""
    print_info "2. Review configuration: cat PROJECT_CONFIG.json"
    print_info "3. Execute research: $SCRIPT_DIR/quick_research.sh \"$PROJECT_PATH\""
    
    # Optional: Auto-execute research
    read -p "Would you like to start the research now? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_status "Starting research execution..."
        cd "$SCRIPT_DIR"
        
        # Execute appropriate research based on type
        case "$RESEARCH_TYPE" in
            "individual-oppo")
                exec ./quick_research.sh --individual "$PROJECT_PATH"
                ;;
            "company-deep")
                exec ./quick_research.sh --company "$PROJECT_PATH"
                ;;
            "seo-analysis")
                exec ./quick_research.sh --seo "$PROJECT_PATH"
                ;;
            *)
                exec ./quick_research.sh "$PROJECT_PATH"
                ;;
        esac
    else
        print_info "Research project ready. Execute when ready using the commands above."
    fi
}

# Run main function
main