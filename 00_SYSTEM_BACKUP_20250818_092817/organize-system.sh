#!/bin/bash

# MRP System Organization Script
# Cleans up and organizes the research system

set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'
BOLD='\033[1m'

# Paths
SYSTEM_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SYSTEM_DIR")"

echo -e "${BOLD}MRP SYSTEM ORGANIZATION TOOL${NC}\n"

# 1. Archive old MRP versions
echo -e "${YELLOW}Step 1: Archiving old protocol versions...${NC}"
mkdir -p "${PROJECT_ROOT}/04_ARCHIVES/old_protocols"
[ -f "${SYSTEM_DIR}/MRP_v6.0.md" ] && mv "${SYSTEM_DIR}/MRP_v6.0.md" "${PROJECT_ROOT}/04_ARCHIVES/old_protocols/"
[ -f "${SYSTEM_DIR}/MRP_v6.1.md" ] && mv "${SYSTEM_DIR}/MRP_v6.1.md" "${PROJECT_ROOT}/04_ARCHIVES/old_protocols/"
echo -e "${GREEN}✓ Old protocols archived${NC}"

# 2. Organize scripts by function
echo -e "\n${YELLOW}Step 2: Organizing scripts by function...${NC}"

# Create organized subdirectories
mkdir -p "${SYSTEM_DIR}/scripts/pdf-generation"
mkdir -p "${SYSTEM_DIR}/scripts/research-pipeline"
mkdir -p "${SYSTEM_DIR}/scripts/citation-system"
mkdir -p "${SYSTEM_DIR}/scripts/utilities"
mkdir -p "${SYSTEM_DIR}/scripts/deprecated"

# Create symlinks for backward compatibility (don't move, just organize with links)
echo "Creating organized structure with symlinks..."

# PDF Generation scripts
for script in create-premium-document.sh create-document.sh create-enterprise-document.sh create-research-pdf-with-citations.sh; do
    if [ -f "${SYSTEM_DIR}/$script" ]; then
        ln -sf "../$script" "${SYSTEM_DIR}/scripts/pdf-generation/$script" 2>/dev/null || true
    fi
done

# Research Pipeline scripts
for script in individual-reputational-scan.sh run-mega-analysis.sh research-dispatcher.sh quick_research.sh; do
    if [ -f "${SYSTEM_DIR}/$script" ]; then
        ln -sf "../$script" "${SYSTEM_DIR}/scripts/research-pipeline/$script" 2>/dev/null || true
    fi
done

# Citation System
for script in auto-citation-extractor.sh; do
    if [ -f "${SYSTEM_DIR}/$script" ]; then
        ln -sf "../$script" "${SYSTEM_DIR}/scripts/citation-system/$script" 2>/dev/null || true
    fi
done

echo -e "${GREEN}✓ Scripts organized with symlinks${NC}"

# 3. Clean up project directories
echo -e "\n${YELLOW}Step 3: Standardizing project output directories...${NC}"

# Find and consolidate PDF directories
find "${PROJECT_ROOT}/03_PROJECTS" -type d -name "Premium_PDFs" -o -name "Final_PDFs" 2>/dev/null | while read -r pdf_dir; do
    project_dir=$(dirname "$pdf_dir")
    target_dir="${project_dir}/PDFs"
    
    if [ ! -d "$target_dir" ]; then
        mkdir -p "$target_dir"
    fi
    
    # Move PDFs to consolidated directory
    if [ -d "$pdf_dir" ]; then
        find "$pdf_dir" -name "*.pdf" -exec mv {} "$target_dir/" \; 2>/dev/null || true
    fi
done

echo -e "${GREEN}✓ PDF directories consolidated${NC}"

# 4. Create system status file
echo -e "\n${YELLOW}Step 4: Generating system status report...${NC}"

cat > "${SYSTEM_DIR}/SYSTEM_STATUS.md" << EOF
# MRP System Status Report
Generated: $(date)

## Current Version
- **Protocol**: MRP v6.1.2
- **Status**: Production Ready
- **Location**: 00_SYSTEM/MRP_v6.1.2.md

## System Components

### Core Entry Points
- \`mrp-launcher.sh\` - Unified launcher with recipe selection
- \`web-api-server.py\` - Web interface (http://localhost:5000)
- \`research-pdf-api.py\` - CLI API interface

### Available Recipes
1. **Reputational Intelligence** - Individual due diligence
2. **Organizational Intelligence** - Company analysis
3. **GTM Marketing Research** - Go-to-market strategy

### Key Scripts
- **Citation System**: auto-citation-extractor.sh, auto-insert-citations.py
- **PDF Generation**: generate-research-pdf-automated.sh
- **Research Pipeline**: run-mega-analysis.sh
- **Knowledge Graph**: build-knowledge-graph.sh

### Templates Available
- Corporate (default)
- Tufte (academic)
- Sakura (minimal)
- Classic (traditional)

### MCP Tools Configured
$(claude mcp list 2>/dev/null || echo "Run 'claude mcp list' to check")

## Quick Start
\`\`\`bash
# Launch unified interface
./00_SYSTEM/mrp-launcher.sh

# Start web interface
python 00_SYSTEM/web-api-server.py

# Direct CLI usage
python 00_SYSTEM/research-pdf-api.py --help
\`\`\`
EOF

echo -e "${GREEN}✓ System status report generated${NC}"

# 5. Remove temporary files
echo -e "\n${YELLOW}Step 5: Cleaning temporary files...${NC}"
find "$PROJECT_ROOT" -name "*.tmp" -o -name "*.log" -o -name ".DS_Store" -delete 2>/dev/null || true
echo -e "${GREEN}✓ Temporary files cleaned${NC}"

# 6. Create quick access symlinks in root
echo -e "\n${YELLOW}Step 6: Creating quick access links...${NC}"
ln -sf "00_SYSTEM/mrp-launcher.sh" "${PROJECT_ROOT}/launch-research" 2>/dev/null || true
ln -sf "00_SYSTEM/web-api-server.py" "${PROJECT_ROOT}/start-web-interface" 2>/dev/null || true
echo -e "${GREEN}✓ Quick access links created${NC}"

# Summary
echo -e "\n${BOLD}${GREEN}ORGANIZATION COMPLETE!${NC}"
echo -e "\nQuick Start Commands:"
echo -e "${CYAN}1. Launch Research:${NC} ./launch-research"
echo -e "${CYAN}2. Web Interface:${NC} python start-web-interface"
echo -e "${CYAN}3. View Status:${NC} cat 00_SYSTEM/SYSTEM_STATUS.md"

echo -e "\n${BOLD}Next Steps:${NC}"
echo "1. Test the unified launcher: ./00_SYSTEM/mrp-launcher.sh"
echo "2. Review recipe configurations: 00_SYSTEM/recipe-configurations.json"
echo "3. Archive old projects as needed"
echo ""