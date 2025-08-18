#!/bin/bash

# MRP v7.0 System Health Check
# Comprehensive verification of enterprise system components

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'
BOLD='\033[1m'

SYSTEM_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ERRORS=0
WARNINGS=0

echo -e "${CYAN}${BOLD}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}${BOLD}║           MRP v7.0 SYSTEM HEALTH CHECK                      ║${NC}"
echo -e "${CYAN}${BOLD}║           Enterprise Intelligence System                     ║${NC}"
echo -e "${CYAN}${BOLD}╚══════════════════════════════════════════════════════════════╝${NC}"

# Function to check file/directory existence
check_exists() {
    local path="$1"
    local type="$2"
    local name="$3"
    
    if [ "$type" = "file" ] && [ -f "$path" ]; then
        echo -e "  ${GREEN}✓${NC} $name"
        return 0
    elif [ "$type" = "dir" ] && [ -d "$path" ]; then
        echo -e "  ${GREEN}✓${NC} $name"
        return 0
    else
        echo -e "  ${RED}✗${NC} $name - Missing!"
        ((ERRORS++))
        return 1
    fi
}

# Function to check executable
check_executable() {
    local path="$1"
    local name="$2"
    
    if [ -x "$path" ]; then
        echo -e "  ${GREEN}✓${NC} $name (executable)"
        return 0
    elif [ -f "$path" ]; then
        echo -e "  ${YELLOW}⚠${NC} $name (not executable)"
        ((WARNINGS++))
        return 1
    else
        echo -e "  ${RED}✗${NC} $name - Missing!"
        ((ERRORS++))
        return 1
    fi
}

# 1. Check Directory Structure
echo -e "\n${YELLOW}1. Directory Structure:${NC}"
check_exists "$SYSTEM_DIR/config" "dir" "config/"
check_exists "$SYSTEM_DIR/core" "dir" "core/"
check_exists "$SYSTEM_DIR/recipes" "dir" "recipes/"
check_exists "$SYSTEM_DIR/api" "dir" "api/"
check_exists "$SYSTEM_DIR/templates" "dir" "templates/"
check_exists "$SYSTEM_DIR/utils" "dir" "utils/"
check_exists "$SYSTEM_DIR/logs" "dir" "logs/"
check_exists "$SYSTEM_DIR/deprecated" "dir" "deprecated/"

# 2. Check Core Components
echo -e "\n${YELLOW}2. Core Components:${NC}"
check_executable "$SYSTEM_DIR/core/mrp-launcher.sh" "mrp-launcher.sh"
check_executable "$SYSTEM_DIR/core/generate-pdf.sh" "generate-pdf.sh"
check_executable "$SYSTEM_DIR/core/run-mega-analysis.sh" "run-mega-analysis.sh"
check_executable "$SYSTEM_DIR/core/build-knowledge-graph.sh" "build-knowledge-graph.sh"

# 3. Check Recipe Dispatchers
echo -e "\n${YELLOW}3. Recipe Dispatchers:${NC}"
check_executable "$SYSTEM_DIR/recipes/reputational/dispatcher.sh" "Reputational dispatcher"
check_executable "$SYSTEM_DIR/recipes/organizational/dispatcher.sh" "Organizational dispatcher"
check_executable "$SYSTEM_DIR/recipes/gtm/dispatcher.sh" "GTM dispatcher"

# 4. Check Configuration
echo -e "\n${YELLOW}4. Configuration Files:${NC}"
check_exists "$SYSTEM_DIR/config/system.yaml" "file" "system.yaml"
check_exists "$SYSTEM_DIR/config/mcp-standards.json" "file" "mcp-standards.json"

# 5. Check API Components
echo -e "\n${YELLOW}5. API Components:${NC}"
check_exists "$SYSTEM_DIR/api/web-server.py" "file" "web-server.py"
check_exists "$SYSTEM_DIR/api/backend-api.py" "file" "backend-api.py"
check_exists "$SYSTEM_DIR/api/wordpress-publisher.py" "file" "wordpress-publisher.py"

# 6. Check Utility Scripts
echo -e "\n${YELLOW}6. Utility Scripts:${NC}"
check_executable "$SYSTEM_DIR/utils/citation-extractor.sh" "citation-extractor.sh"
check_exists "$SYSTEM_DIR/utils/citation-inserter.py" "file" "citation-inserter.py"
check_executable "$SYSTEM_DIR/utils/entity-extractor.sh" "entity-extractor.sh"

# 7. Check Environment Variables
echo -e "\n${YELLOW}7. Environment Variables:${NC}"
if [ -n "$GEMINI_API_KEY" ]; then
    echo -e "  ${GREEN}✓${NC} GEMINI_API_KEY set"
else
    echo -e "  ${YELLOW}⚠${NC} GEMINI_API_KEY not set (required for mega-analysis)"
    ((WARNINGS++))
fi

# 8. Check Python Dependencies
echo -e "\n${YELLOW}8. Python Dependencies:${NC}"
if command -v python3 &> /dev/null; then
    echo -e "  ${GREEN}✓${NC} Python3 installed"
    
    # Check for required packages
    python3 -c "import flask" 2>/dev/null && echo -e "  ${GREEN}✓${NC} Flask installed" || echo -e "  ${YELLOW}⚠${NC} Flask not installed"
    python3 -c "import requests" 2>/dev/null && echo -e "  ${GREEN}✓${NC} Requests installed" || echo -e "  ${YELLOW}⚠${NC} Requests not installed"
else
    echo -e "  ${RED}✗${NC} Python3 not found!"
    ((ERRORS++))
fi

# 9. Check System Tools
echo -e "\n${YELLOW}9. System Tools:${NC}"
command -v pandoc &> /dev/null && echo -e "  ${GREEN}✓${NC} Pandoc installed" || echo -e "  ${YELLOW}⚠${NC} Pandoc not installed"
command -v tectonic &> /dev/null && echo -e "  ${GREEN}✓${NC} Tectonic installed" || echo -e "  ${YELLOW}⚠${NC} Tectonic not installed"
command -v jq &> /dev/null && echo -e "  ${GREEN}✓${NC} jq installed" || echo -e "  ${YELLOW}⚠${NC} jq not installed"

# 10. Check Disk Space
echo -e "\n${YELLOW}10. Disk Space:${NC}"
DISK_USAGE=$(df -h "$SYSTEM_DIR" | awk 'NR==2 {print $5}' | sed 's/%//')
if [ "$DISK_USAGE" -lt 80 ]; then
    echo -e "  ${GREEN}✓${NC} Disk usage: ${DISK_USAGE}%"
elif [ "$DISK_USAGE" -lt 90 ]; then
    echo -e "  ${YELLOW}⚠${NC} Disk usage: ${DISK_USAGE}% (getting full)"
    ((WARNINGS++))
else
    echo -e "  ${RED}✗${NC} Disk usage: ${DISK_USAGE}% (critical!)"
    ((ERRORS++))
fi

# 11. Check Migration Artifacts
echo -e "\n${YELLOW}11. Migration Status:${NC}"
if [ -f "$SYSTEM_DIR/MIGRATION_REPORT_$(date +%Y%m%d).md" ]; then
    echo -e "  ${GREEN}✓${NC} Migration report exists"
else
    echo -e "  ${BLUE}ℹ${NC} No migration report for today"
fi

# Count deprecated files
DEPRECATED_COUNT=$(ls -1 "$SYSTEM_DIR/deprecated" 2>/dev/null | wc -l)
echo -e "  ${BLUE}ℹ${NC} Deprecated files: $DEPRECATED_COUNT"

# 12. Test Recipe Prompts
echo -e "\n${YELLOW}12. Recipe Prompts:${NC}"
check_exists "$SYSTEM_DIR/recipes/reputational/prompt.md" "file" "Reputational prompt"
check_exists "$SYSTEM_DIR/recipes/organizational/prompt.md" "file" "Organizational prompt"
check_exists "$SYSTEM_DIR/recipes/gtm/prompt.md" "file" "GTM prompt"

# Final Summary
echo -e "\n${CYAN}${BOLD}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}${BOLD}║                    HEALTH CHECK SUMMARY                     ║${NC}"
echo -e "${CYAN}${BOLD}╚══════════════════════════════════════════════════════════════╝${NC}"

if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    echo -e "\n${GREEN}${BOLD}✅ SYSTEM STATUS: EXCELLENT${NC}"
    echo -e "All components are functioning correctly."
elif [ $ERRORS -eq 0 ]; then
    echo -e "\n${YELLOW}${BOLD}⚠️  SYSTEM STATUS: GOOD (with $WARNINGS warnings)${NC}"
    echo -e "System is operational but some optimizations recommended."
else
    echo -e "\n${RED}${BOLD}❌ SYSTEM STATUS: CRITICAL ($ERRORS errors, $WARNINGS warnings)${NC}"
    echo -e "System has critical issues that need immediate attention."
fi

echo -e "\n${BLUE}Summary:${NC}"
echo -e "  • Errors: $ERRORS"
echo -e "  • Warnings: $WARNINGS"
echo -e "  • System Version: MRP v7.0"
echo -e "  • Architecture: Enterprise Consolidated"

# Recommendations
if [ $WARNINGS -gt 0 ] || [ $ERRORS -gt 0 ]; then
    echo -e "\n${YELLOW}Recommendations:${NC}"
    
    if [ -z "$GEMINI_API_KEY" ]; then
        echo -e "  • Set GEMINI_API_KEY for mega-analysis functionality"
    fi
    
    if ! command -v tectonic &> /dev/null; then
        echo -e "  • Install Tectonic for PDF generation: cargo install tectonic"
    fi
    
    if [ $ERRORS -gt 0 ]; then
        echo -e "  • Review migration report for missing components"
        echo -e "  • Consider restoring from backup if critical files are missing"
    fi
fi

echo -e "\n${BLUE}Run '${CYAN}./core/mrp-launcher.sh${BLUE}' to start research operations.${NC}"
echo ""

exit $ERRORS