#!/bin/bash

# MRP Unified Launcher v1.0
# Single entry point for all research operations
# Three recipes: Reputational, Organizational, GTM Marketing

set -e

# Colors for better UX
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# System paths
SYSTEM_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SYSTEM_DIR")"
PROJECTS_DIR="${PROJECT_ROOT}/03_PROJECTS"

# Display banner
display_banner() {
    clear
    echo -e "${CYAN}${BOLD}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                                                              ║"
    echo "║     🚀 MRP RESEARCH LAUNCHER v6.1.2                        ║"
    echo "║     Master Research Protocol - Unified Entry Point          ║"
    echo "║                                                              ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# Recipe selection menu
select_recipe() {
    echo -e "${BOLD}${BLUE}SELECT YOUR RESEARCH RECIPE:${NC}\n"
    
    echo -e "${GREEN}[1]${NC} ${BOLD}🔍 REPUTATIONAL INTELLIGENCE${NC}"
    echo "    → Individual due diligence & personal brand analysis"
    echo "    → Executive vetting, background checks, risk assessment"
    echo "    → 6-Phase Strategic Intelligence Framework"
    echo ""
    
    echo -e "${GREEN}[2]${NC} ${BOLD}🏢 ORGANIZATIONAL INTELLIGENCE${NC}"
    echo "    → Company analysis & competitive intelligence"
    echo "    → M&A due diligence, partnership evaluation"
    echo "    → Business Intelligence Model with financial focus"
    echo ""
    
    echo -e "${GREEN}[3]${NC} ${BOLD}🚀 GTM MARKETING RESEARCH${NC}"
    echo "    → Go-to-market strategy & audience intelligence"
    echo "    → Campaign development, market entry analysis"
    echo "    → DataForSEO + Perplexity powered insights"
    echo ""
    
    echo -e "${GREEN}[4]${NC} ${BOLD}📊 PROJECT STATUS${NC}"
    echo "    → View all existing projects and their status"
    echo ""
    
    echo -e "${GREEN}[5]${NC} ${BOLD}🧹 SYSTEM MAINTENANCE${NC}"
    echo "    → Clean up, organize, archive old projects"
    echo ""
    
    echo -e "${RED}[0]${NC} Exit"
    echo ""
    
    read -p "Enter your choice [0-5]: " RECIPE_CHOICE
}

# Get target information
get_target_info() {
    local recipe_type=$1
    
    case $recipe_type in
        1)
            echo -e "\n${CYAN}${BOLD}REPUTATIONAL INTELLIGENCE SETUP${NC}"
            read -p "Enter target individual's name: " TARGET_NAME
            read -p "Enter primary objective (or press Enter for default): " PRIMARY_OBJECTIVE
            if [ -z "$PRIMARY_OBJECTIVE" ]; then
                PRIMARY_OBJECTIVE="Comprehensive reputational assessment and risk analysis"
            fi
            PROJECT_TYPE="INDIVIDUAL"
            RECIPE_NAME="Reputational"
            ;;
        2)
            echo -e "\n${CYAN}${BOLD}ORGANIZATIONAL INTELLIGENCE SETUP${NC}"
            read -p "Enter target organization name: " TARGET_NAME
            read -p "Enter primary objective (or press Enter for default): " PRIMARY_OBJECTIVE
            if [ -z "$PRIMARY_OBJECTIVE" ]; then
                PRIMARY_OBJECTIVE="Comprehensive business intelligence and competitive analysis"
            fi
            PROJECT_TYPE="ORGANIZATION"
            RECIPE_NAME="Organizational"
            ;;
        3)
            echo -e "\n${CYAN}${BOLD}GTM MARKETING RESEARCH SETUP${NC}"
            read -p "Enter client/product name: " TARGET_NAME
            read -p "Enter target market or audience: " TARGET_MARKET
            read -p "Enter primary objective (or press Enter for default): " PRIMARY_OBJECTIVE
            if [ -z "$PRIMARY_OBJECTIVE" ]; then
                PRIMARY_OBJECTIVE="Go-to-market strategy development with audience intelligence"
            fi
            PROJECT_TYPE="GTM"
            RECIPE_NAME="GTM"
            ;;
    esac
}

# Select output options
select_output_options() {
    echo -e "\n${BOLD}OUTPUT OPTIONS:${NC}"
    echo "[1] PDF Document only"
    echo "[2] WordPress post only"
    echo "[3] Both PDF and WordPress"
    echo "[4] Full suite (PDF + WordPress + Knowledge Graph)"
    
    read -p "Select output option [1-4]: " OUTPUT_CHOICE
    
    echo -e "\n${BOLD}TEMPLATE SELECTION:${NC}"
    echo "[1] Corporate (Professional business style)"
    echo "[2] Tufte (Academic elegance)"
    echo "[3] Sakura (Minimal Japanese-inspired)"
    echo "[4] Classic (Traditional academic)"
    
    read -p "Select template [1-4]: " TEMPLATE_CHOICE
    
    case $TEMPLATE_CHOICE in
        1) TEMPLATE="corporate" ;;
        2) TEMPLATE="tufte" ;;
        3) TEMPLATE="sakura" ;;
        4) TEMPLATE="classic" ;;
        *) TEMPLATE="corporate" ;;
    esac
}

# Configure recipe-specific settings
configure_recipe() {
    local recipe_type=$1
    
    # Create PROJECT_CONFIG.json based on recipe
    TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    PROJECT_NAME="Research_${RECIPE_NAME}_${TARGET_NAME// /_}_${TIMESTAMP}"
    PROJECT_PATH="${PROJECTS_DIR}/${PROJECT_NAME}"
    
    # Create project directory
    mkdir -p "$PROJECT_PATH"
    
    # Generate configuration
    cat > "${PROJECT_PATH}/PROJECT_CONFIG.json" << EOF
{
  "project_type": "${PROJECT_TYPE}",
  "recipe": "${RECIPE_NAME}",
  "target_name": "${TARGET_NAME}",
  "primary_objective": "${PRIMARY_OBJECTIVE}",
  "timestamp": "${TIMESTAMP}",
  "approval_mode": "interactive",
  "require_source_approval": true,
  "require_outline_approval": true,
  "verification_level": "high",
  "template": "${TEMPLATE}",
  "output_options": {
EOF
    
    case $OUTPUT_CHOICE in
        1) echo '    "pdf": true,' >> "${PROJECT_PATH}/PROJECT_CONFIG.json"
           echo '    "wordpress": false,' >> "${PROJECT_PATH}/PROJECT_CONFIG.json" ;;
        2) echo '    "pdf": false,' >> "${PROJECT_PATH}/PROJECT_CONFIG.json"
           echo '    "wordpress": true,' >> "${PROJECT_PATH}/PROJECT_CONFIG.json" ;;
        3) echo '    "pdf": true,' >> "${PROJECT_PATH}/PROJECT_CONFIG.json"
           echo '    "wordpress": true,' >> "${PROJECT_PATH}/PROJECT_CONFIG.json" ;;
        4) echo '    "pdf": true,' >> "${PROJECT_PATH}/PROJECT_CONFIG.json"
           echo '    "wordpress": true,' >> "${PROJECT_PATH}/PROJECT_CONFIG.json"
           echo '    "knowledge_graph": true,' >> "${PROJECT_PATH}/PROJECT_CONFIG.json" ;;
    esac
    
    # Add recipe-specific configurations
    case $recipe_type in
        1)  # Reputational - Enhanced for v4.0 Mission Briefing
            cat >> "${PROJECT_PATH}/PROJECT_CONFIG.json" << EOF
    "notebooklm": true
  },
  "research_framework": "6-phase-strategic-intelligence",
  "mission_briefing_version": "4.0",
  "investigation_areas": {
    "professional_history": true,
    "public_statements": true,
    "online_discourse": true,
    "legal_financial": true,
    "network_analysis": true,
    "second_level_scan": true
  },
  "emphasis": [
    "professional_history",
    "network_mapping",
    "digital_footprint",
    "reputational_risks",
    "behavioral_patterns",
    "second_level_liabilities"
  ],
  "deliverable_requirements": {
    "master_dossier": {
      "min_pages": 20,
      "max_pages": 50,
      "format": "pandoc_tectonic",
      "sections": [
        "executive_summary",
        "risk_matrix",
        "biographical_overview",
        "investigation_findings",
        "network_analysis",
        "recommendations"
      ]
    },
    "citation_requirements": {
      "minimum": 50,
      "format": "markdown_footnotes",
      "source_quality_minimum": 3,
      "triangulation_required": true,
      "include_access_dates": true
    },
    "knowledge_graph": {
      "levels": 2,
      "include_risk_coding": true,
      "export_neo4j": true
    }
  },
  "operational_parameters": {
    "approval_mode": "interactive",
    "require_source_approval": true,
    "require_outline_approval": true,
    "verification_level": "high",
    "fact_checking_depth": "maximum",
    "source_quality_minimum": 3,
    "contradiction_analysis": true,
    "second_level_scan": true,
    "perform_mega_analysis": true
  },
  "mcp_tool_priority": {
    "primary": ["firecrawl", "perplexity", "tavily"],
    "secondary": ["reddit", "playwright", "sequential_thinking"],
    "optional": ["dataforseo"]
  },
  "quality_standards": {
    "enforce_minimum_pages": true,
    "enforce_citation_minimum": true,
    "require_triangulation": true,
    "require_risk_matrix": true,
    "require_methodology_appendix": true
  },
  "prompt_template": "recipe-prompts/reputational-intelligence-prompt.md"
}
EOF
            ;;
        2)  # Organizational - Enhanced for v1.0 Mission Briefing
            cat >> "${PROJECT_PATH}/PROJECT_CONFIG.json" << EOF
    "notebooklm": true
  },
  "research_framework": "business-intelligence-model",
  "mission_briefing_version": "1.0",
  "investigation_vectors": {
    "corporate_financial": true,
    "market_perception": true,
    "operational_cultural": true,
    "leadership_vetting": true
  },
  "emphasis": [
    "corporate_structure",
    "financial_performance",
    "market_position",
    "regulatory_compliance",
    "strategic_capabilities",
    "leadership_liabilities",
    "operational_risks"
  ],
  "deliverable_requirements": {
    "master_dossier": {
      "min_pages": 20,
      "max_pages": 50,
      "format": "pandoc_tectonic",
      "sections": [
        "executive_summary",
        "risk_matrix",
        "company_overview",
        "financial_assessment",
        "market_analysis",
        "operational_evaluation",
        "leadership_assessment",
        "competitive_intelligence",
        "recommendations"
      ]
    },
    "citation_requirements": {
      "minimum": 50,
      "format": "markdown_footnotes",
      "source_quality_minimum": 3,
      "financial_verification": true,
      "include_access_dates": true
    },
    "knowledge_graph": {
      "include_subsidiaries": true,
      "include_competitors": true,
      "include_leadership": true,
      "risk_heat_mapping": true,
      "export_neo4j": true
    }
  },
  "operational_parameters": {
    "approval_mode": "interactive",
    "require_source_approval": true,
    "require_outline_approval": true,
    "verification_level": "high",
    "fact_checking_depth": "maximum",
    "source_quality_minimum": 3,
    "financial_verification": true,
    "leadership_scan_depth": 2,
    "competitor_analysis": true,
    "perform_mega_analysis": true
  },
  "leadership_vetting": {
    "level_1_scan": ["c_suite", "board_directors", "key_svps"],
    "level_2_scan": ["professional_history", "business_failures", "legal_issues", "controversies"],
    "recent_departures_window": "2_years"
  },
  "mcp_tool_priority": {
    "primary": ["firecrawl", "dataforseo", "perplexity"],
    "secondary": ["tavily", "reddit", "playwright"],
    "financial_specific": ["sec_edgar", "financial_aggregators"]
  },
  "quality_standards": {
    "enforce_minimum_pages": true,
    "enforce_citation_minimum": true,
    "require_financial_analysis": true,
    "require_leadership_vetting": true,
    "require_competitor_analysis": true,
    "require_risk_matrix": true,
    "require_company_logo": true
  },
  "prompt_template": "recipe-prompts/organizational-intelligence-prompt.md"
}
EOF
            ;;
        3)  # GTM Marketing - Enhanced for v1.0 Mission Briefing
            cat >> "${PROJECT_PATH}/PROJECT_CONFIG.json" << EOF
    "notebooklm": true
  },
  "research_framework": "gtm-intelligence",
  "mission_briefing_version": "1.0",
  "target_market": "${TARGET_MARKET}",
  "methodology_steps": 12,
  "emphasis": [
    "audience_segmentation",
    "market_sizing",
    "competitive_intelligence",
    "channel_strategy",
    "message_development",
    "experiment_design",
    "measurement_framework"
  ],
  "deliverable_requirements": {
    "master_audit": {
      "min_pages": 20,
      "max_pages": 40,
      "format": "actionable_playbooks",
      "sections": [
        "executive_summary",
        "segmentation_matrix",
        "icp_tiering",
        "channel_playbooks",
        "keyword_clusters",
        "message_matrix",
        "experiment_backlog",
        "measurement_plan",
        "risk_assessment"
      ]
    },
    "citation_requirements": {
      "minimum": 50,
      "format": "markdown_footnotes",
      "source_quality_minimum": 3,
      "market_data_verification": true,
      "include_calculations": true
    },
    "csv_exports": {
      "segmentation_matrix": true,
      "keyword_clusters": true,
      "experiment_backlog": true,
      "channel_metrics": true
    }
  },
  "operational_parameters": {
    "approval_mode": "interactive",
    "require_source_approval": true,
    "require_outline_approval": true,
    "verification_level": "high",
    "fact_checking_depth": "maximum",
    "source_quality_minimum": 3,
    "use_dataforseo": true,
    "use_perplexity_heavy": true,
    "competitor_analysis_depth": "comprehensive",
    "segmentation_rigor": "maximum",
    "deliverable_format": "actionable_playbooks"
  },
  "segmentation_requirements": {
    "minimum_segments": 5,
    "dimensions": [
      "firmographic",
      "technographic",
      "demographic",
      "psychographic",
      "behavioral",
      "intent",
      "lifecycle"
    ],
    "economics_per_segment": true,
    "reachability_assessment": true
  },
  "channel_analysis": {
    "minimum_channels": 5,
    "required_channels": [
      "search",
      "social_linkedin",
      "social_meta",
      "display_programmatic",
      "email"
    ],
    "metrics_per_channel": [
      "audience_size",
      "cpm_cpc_estimates",
      "expected_performance",
      "creative_guidelines"
    ]
  },
  "experiment_design": {
    "minimum_tests": 10,
    "maximum_tests": 20,
    "ice_scoring": true,
    "sample_size_calculations": true,
    "test_categories": [
      "audience_discovery",
      "message_offer",
      "landing_flow",
      "pricing_packaging",
      "lifecycle_retention"
    ]
  },
  "mcp_tool_priority": {
    "primary": ["dataforseo", "perplexity", "firecrawl"],
    "secondary": ["tavily", "reddit", "sequential_thinking"],
    "analytics": ["search_volume", "competitor_analysis", "social_listening"]
  },
  "quality_standards": {
    "enforce_minimum_pages": true,
    "enforce_citation_minimum": true,
    "require_tam_sam_som": true,
    "require_segmentation_matrix": true,
    "require_channel_playbooks": true,
    "require_experiment_roadmap": true,
    "require_measurement_framework": true,
    "require_csv_exports": true
  },
  "prompt_template": "recipe-prompts/gtm-marketing-intelligence-prompt.md"
}
EOF
            ;;
    esac
}

# Execute the research
execute_research() {
    echo -e "\n${GREEN}${BOLD}LAUNCHING RESEARCH...${NC}"
    echo -e "${YELLOW}Project: ${PROJECT_NAME}${NC}"
    echo -e "${YELLOW}Path: ${PROJECT_PATH}${NC}"
    
    # Display configuration
    echo -e "\n${CYAN}Configuration saved to PROJECT_CONFIG.json${NC}"
    
    # Recipe-specific execution
    case $RECIPE_CHOICE in
        1)  # Reputational Intelligence
            echo -e "\n${BOLD}Executing Reputational Intelligence Recipe v4.0...${NC}"
            
            # Use enhanced reputational scan dispatcher
            if [ -f "${SYSTEM_DIR}/recipes/reputational/dispatcher.sh" ]; then
                "${SYSTEM_DIR}/recipes/reputational/dispatcher.sh" "$PROJECT_PATH" "$TARGET_NAME"
            elif [ -f "${SYSTEM_DIR}/individual-reputational-scan.sh" ]; then
                "${SYSTEM_DIR}/individual-reputational-scan.sh" "$PROJECT_PATH" "$TARGET_NAME"
            else
                echo -e "${YELLOW}Using generic research dispatcher...${NC}"
                "${SYSTEM_DIR}/research-dispatcher.sh" "$PROJECT_PATH"
            fi
            ;;
            
        2)  # Organizational Intelligence
            echo -e "\n${BOLD}Executing Organizational Intelligence Recipe v1.0...${NC}"
            
            # Use enhanced organizational scan dispatcher
            if [ -f "${SYSTEM_DIR}/recipes/organizational/dispatcher.sh" ]; then
                "${SYSTEM_DIR}/recipes/organizational/dispatcher.sh" "$PROJECT_PATH" "$TARGET_NAME"
            elif [ -f "${SYSTEM_DIR}/organizational-intelligence-scan.sh" ]; then
                "${SYSTEM_DIR}/organizational-intelligence-scan.sh" "$PROJECT_PATH" "$TARGET_NAME"
            else
                echo -e "${YELLOW}Using generic research dispatcher...${NC}"
                "${SYSTEM_DIR}/research-dispatcher.sh" "$PROJECT_PATH"
            fi
            ;;
            
        3)  # GTM Marketing Research
            echo -e "\n${BOLD}Executing GTM Marketing Intelligence Recipe v1.0...${NC}"
            
            # Use enhanced GTM dispatcher
            if [ -f "${SYSTEM_DIR}/recipes/gtm/dispatcher.sh" ]; then
                "${SYSTEM_DIR}/recipes/gtm/dispatcher.sh" "$PROJECT_PATH" "$TARGET_NAME" "$TARGET_MARKET"
            elif [ -f "${SYSTEM_DIR}/gtm-marketing-research.sh" ]; then
                "${SYSTEM_DIR}/gtm-marketing-research.sh" "$PROJECT_PATH" "$TARGET_NAME" "$TARGET_MARKET"
            else
                echo -e "${YELLOW}Using generic research dispatcher...${NC}"
                "${SYSTEM_DIR}/research-dispatcher.sh" "$PROJECT_PATH"
            fi
            ;;
    esac
    
    echo -e "\n${GREEN}${BOLD}✓ Research initiated successfully!${NC}"
    echo -e "Monitor progress in: ${PROJECT_PATH}/RESEARCH_LOG.md"
}

# Show project status
show_project_status() {
    echo -e "\n${CYAN}${BOLD}EXISTING RESEARCH PROJECTS:${NC}\n"
    
    # Find all PROJECT_CONFIG.json files
    find "$PROJECTS_DIR" -name "PROJECT_CONFIG.json" -type f 2>/dev/null | while read -r config; do
        project_dir=$(dirname "$config")
        project_name=$(basename "$project_dir")
        
        # Extract key info from config
        if [ -f "$config" ]; then
            recipe=$(grep -o '"recipe"[[:space:]]*:[[:space:]]*"[^"]*"' "$config" | cut -d'"' -f4)
            target=$(grep -o '"target_name"[[:space:]]*:[[:space:]]*"[^"]*"' "$config" | cut -d'"' -f4)
            timestamp=$(grep -o '"timestamp"[[:space:]]*:[[:space:]]*"[^"]*"' "$config" | cut -d'"' -f4)
            
            # Check for output files
            pdf_exists=""
            if ls "$project_dir"/*.pdf 2>/dev/null | grep -q .; then
                pdf_exists="✓ PDF"
            fi
            
            echo -e "${GREEN}►${NC} ${BOLD}${project_name}${NC}"
            echo "   Recipe: ${recipe} | Target: ${target}"
            echo "   Created: ${timestamp} | Status: ${pdf_exists}"
            echo ""
        fi
    done
}

# System maintenance
system_maintenance() {
    echo -e "\n${CYAN}${BOLD}SYSTEM MAINTENANCE${NC}\n"
    
    echo "[1] Archive completed projects (30+ days old)"
    echo "[2] Clean up temporary files"
    echo "[3] Consolidate PDF directories"
    echo "[4] Update all recipe configurations"
    echo "[5] Verify MCP tool connections"
    echo "[0] Back to main menu"
    
    read -p "Select maintenance task: " MAINT_CHOICE
    
    case $MAINT_CHOICE in
        1)
            echo "Archiving old projects..."
            # Archive logic here
            ;;
        2)
            echo "Cleaning temporary files..."
            find "$PROJECT_ROOT" -name "*.tmp" -o -name "*.log" -o -name ".DS_Store" -delete
            ;;
        3)
            echo "Consolidating PDF directories..."
            # Consolidation logic here
            ;;
        4)
            echo "Updating recipe configurations..."
            # Update logic here
            ;;
        5)
            echo "Verifying MCP tools..."
            claude mcp list
            ;;
    esac
}

# Main execution flow
main() {
    display_banner
    
    while true; do
        select_recipe
        
        case $RECIPE_CHOICE in
            0)
                echo -e "\n${GREEN}Exiting MRP Launcher. Goodbye!${NC}"
                exit 0
                ;;
            1|2|3)
                get_target_info $RECIPE_CHOICE
                select_output_options
                configure_recipe $RECIPE_CHOICE
                execute_research
                
                echo -e "\n${BOLD}Would you like to start another research? (y/n)${NC}"
                read -p "> " CONTINUE
                if [ "$CONTINUE" != "y" ]; then
                    break
                fi
                ;;
            4)
                show_project_status
                echo -e "\nPress Enter to continue..."
                read
                ;;
            5)
                system_maintenance
                ;;
            *)
                echo -e "${RED}Invalid choice. Please try again.${NC}"
                ;;
        esac
    done
}

# Run the launcher
main "$@"