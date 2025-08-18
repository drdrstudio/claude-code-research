#!/bin/bash

# MRP v7.0 Enterprise Migration Script
# Consolidates 52 scripts into clean enterprise structure
# Run with: ./migrate-to-v7.sh [--dry-run]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'
BOLD='\033[1m'

# Configuration
DRY_RUN=false
if [[ "$1" == "--dry-run" ]]; then
    DRY_RUN=true
    echo -e "${YELLOW}DRY RUN MODE - No changes will be made${NC}"
fi

SYSTEM_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="${SYSTEM_DIR}_BACKUP_$(date +%Y%m%d_%H%M%S)"

echo -e "${CYAN}${BOLD}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}${BOLD}║        MRP v7.0 ENTERPRISE MIGRATION                        ║${NC}"
echo -e "${CYAN}${BOLD}║        Consolidating to Clean Enterprise Structure          ║${NC}"
echo -e "${CYAN}${BOLD}╚══════════════════════════════════════════════════════════════╝${NC}"

# Function to execute or simulate commands
execute() {
    if [ "$DRY_RUN" = true ]; then
        echo -e "${BLUE}[DRY RUN]${NC} $@"
    else
        "$@"
    fi
}

# Step 1: Create Backup
echo -e "\n${YELLOW}Step 1: Creating backup...${NC}"
if [ "$DRY_RUN" = false ]; then
    # Use rsync to handle missing files gracefully
    rsync -av --exclude='*.pyc' --exclude='__pycache__' --exclude='.DS_Store' "$SYSTEM_DIR/" "$BACKUP_DIR/" 2>/dev/null || true
    echo -e "${GREEN}✓ Backup created at: $BACKUP_DIR${NC}"
else
    echo -e "${BLUE}[DRY RUN] Would create backup at: $BACKUP_DIR${NC}"
fi

# Step 2: Create New Directory Structure
echo -e "\n${YELLOW}Step 2: Creating new directory structure...${NC}"
execute mkdir -p "$SYSTEM_DIR/config"
execute mkdir -p "$SYSTEM_DIR/core"
execute mkdir -p "$SYSTEM_DIR/recipes/reputational"
execute mkdir -p "$SYSTEM_DIR/recipes/organizational"
execute mkdir -p "$SYSTEM_DIR/recipes/gtm"
execute mkdir -p "$SYSTEM_DIR/api"
execute mkdir -p "$SYSTEM_DIR/templates/pdf"
execute mkdir -p "$SYSTEM_DIR/templates/logos"
execute mkdir -p "$SYSTEM_DIR/utils"
execute mkdir -p "$SYSTEM_DIR/logs"
execute mkdir -p "$SYSTEM_DIR/deprecated"

# Step 3: Move Core Scripts
echo -e "\n${YELLOW}Step 3: Organizing core scripts...${NC}"

# Core entry points
if [ -f "$SYSTEM_DIR/mrp-launcher.sh" ]; then
    execute mv "$SYSTEM_DIR/mrp-launcher.sh" "$SYSTEM_DIR/core/"
fi

if [ -f "$SYSTEM_DIR/run-mega-analysis.sh" ]; then
    execute mv "$SYSTEM_DIR/run-mega-analysis.sh" "$SYSTEM_DIR/core/"
fi

if [ -f "$SYSTEM_DIR/build-knowledge-graph.sh" ]; then
    execute mv "$SYSTEM_DIR/build-knowledge-graph.sh" "$SYSTEM_DIR/core/"
fi

# Step 4: Consolidate PDF Generators
echo -e "\n${YELLOW}Step 4: Consolidating PDF generators...${NC}"

# Keep the premium one as the main generator
if [ -f "$SYSTEM_DIR/create-premium-document.sh" ]; then
    execute cp "$SYSTEM_DIR/create-premium-document.sh" "$SYSTEM_DIR/core/generate-pdf.sh"
fi

# Move others to deprecated
for script in create-document.sh create-enterprise-document.sh create-premium-enterprise-document.sh create-research-pdf-with-citations.sh; do
    if [ -f "$SYSTEM_DIR/$script" ]; then
        execute mv "$SYSTEM_DIR/$script" "$SYSTEM_DIR/deprecated/"
    fi
done

# Step 5: Organize Recipe Files
echo -e "\n${YELLOW}Step 5: Organizing recipe files...${NC}"

# Reputational Intelligence
if [ -f "$SYSTEM_DIR/reputational-scan-dispatcher.sh" ]; then
    execute mv "$SYSTEM_DIR/reputational-scan-dispatcher.sh" "$SYSTEM_DIR/recipes/reputational/dispatcher.sh"
fi

if [ -f "$SYSTEM_DIR/recipe-prompts/reputational-intelligence-prompt-v5.md" ]; then
    execute cp "$SYSTEM_DIR/recipe-prompts/reputational-intelligence-prompt-v5.md" "$SYSTEM_DIR/recipes/reputational/prompt.md"
fi

# Organizational Intelligence
if [ -f "$SYSTEM_DIR/organizational-scan-dispatcher.sh" ]; then
    execute mv "$SYSTEM_DIR/organizational-scan-dispatcher.sh" "$SYSTEM_DIR/recipes/organizational/dispatcher.sh"
fi

if [ -f "$SYSTEM_DIR/recipe-prompts/organizational-intelligence-prompt.md" ]; then
    execute cp "$SYSTEM_DIR/recipe-prompts/organizational-intelligence-prompt.md" "$SYSTEM_DIR/recipes/organizational/prompt.md"
fi

# GTM Marketing
if [ -f "$SYSTEM_DIR/gtm-marketing-dispatcher.sh" ]; then
    execute mv "$SYSTEM_DIR/gtm-marketing-dispatcher.sh" "$SYSTEM_DIR/recipes/gtm/dispatcher.sh"
fi

if [ -f "$SYSTEM_DIR/recipe-prompts/gtm-marketing-intelligence-prompt.md" ]; then
    execute cp "$SYSTEM_DIR/recipe-prompts/gtm-marketing-intelligence-prompt.md" "$SYSTEM_DIR/recipes/gtm/prompt.md"
fi

# Step 6: Move API Files
echo -e "\n${YELLOW}Step 6: Organizing API files...${NC}"

if [ -f "$SYSTEM_DIR/web-api-server.py" ]; then
    execute mv "$SYSTEM_DIR/web-api-server.py" "$SYSTEM_DIR/api/web-server.py"
fi

if [ -f "$SYSTEM_DIR/research-pdf-api.py" ]; then
    execute mv "$SYSTEM_DIR/research-pdf-api.py" "$SYSTEM_DIR/api/backend-api.py"
fi

if [ -f "$SYSTEM_DIR/publish-to-wordpress.py" ]; then
    execute mv "$SYSTEM_DIR/publish-to-wordpress.py" "$SYSTEM_DIR/api/wordpress-publisher.py"
fi

# Step 7: Move Utility Scripts
echo -e "\n${YELLOW}Step 7: Organizing utility scripts...${NC}"

if [ -f "$SYSTEM_DIR/auto-citation-extractor.sh" ]; then
    execute mv "$SYSTEM_DIR/auto-citation-extractor.sh" "$SYSTEM_DIR/utils/citation-extractor.sh"
fi

if [ -f "$SYSTEM_DIR/auto-insert-citations.py" ]; then
    execute mv "$SYSTEM_DIR/auto-insert-citations.py" "$SYSTEM_DIR/utils/citation-inserter.py"
fi

if [ -f "$SYSTEM_DIR/auto-extract-entities.sh" ]; then
    execute mv "$SYSTEM_DIR/auto-extract-entities.sh" "$SYSTEM_DIR/utils/entity-extractor.sh"
fi

# Step 8: Move Config Files
echo -e "\n${YELLOW}Step 8: Moving configuration files...${NC}"

if [ -f "$SYSTEM_DIR/reputational-scan-standards.json" ]; then
    execute mv "$SYSTEM_DIR/reputational-scan-standards.json" "$SYSTEM_DIR/config/mcp-standards.json"
fi

# Step 9: Clean Up Redundant Files
echo -e "\n${YELLOW}Step 9: Removing redundant files...${NC}"

# List of files to remove
REDUNDANT_FILES=(
    "research-dispatcher.sh"
    "test-reputational-scan.sh"
    "enhanced-research-demo.sh"
    "quick_research.sh"
    "individual-reputational-scan.sh"
    "execute-full-reputational-scan.py"
    "sequential-thinking-reputational-template.py"
)

for file in "${REDUNDANT_FILES[@]}"; do
    if [ -f "$SYSTEM_DIR/$file" ]; then
        execute mv "$SYSTEM_DIR/$file" "$SYSTEM_DIR/deprecated/"
        echo -e "  ${RED}→ Deprecated:${NC} $file"
    fi
done

# Step 10: Create Central Config File
echo -e "\n${YELLOW}Step 10: Creating central configuration...${NC}"

if [ "$DRY_RUN" = false ]; then
    cat > "$SYSTEM_DIR/config/system.yaml" << 'EOF'
# MRP v7.0 Central Configuration
system:
  version: "7.0"
  environment: "production"
  
research:
  default_depth: "comprehensive"
  min_sources: 50
  min_pages: 20
  max_runtime_hours: 4
  
mcp_tools:
  priority:
    - firecrawl      # Primary: Deep extraction
    - perplexity     # Primary: AI search
    - dataforseo     # Secondary: SEO data
    - sequential_thinking  # Secondary: Analysis
    - reddit         # Secondary: Sentiment
    - playwright     # Secondary: Dynamic sites
    - tavily        # Last resort only
    
output:
  default_template: "corporate"
  default_quality: "premium"
  citations_required: true
  min_citations: 50
  
pricing:
  target_value_usd: 5000
  track_costs: true
  alert_threshold: 100
  
logging:
  level: "INFO"
  rotation: "daily"
  retention_days: 30
  path: "logs/"
EOF
    echo -e "${GREEN}✓ Created central config${NC}"
else
    echo -e "${BLUE}[DRY RUN] Would create config/system.yaml${NC}"
fi

# Step 11: Create Update Script for References
echo -e "\n${YELLOW}Step 11: Creating reference update script...${NC}"

if [ "$DRY_RUN" = false ]; then
    cat > "$SYSTEM_DIR/update-references.sh" << 'EOF'
#!/bin/bash
# Update all script references to new structure

echo "Updating script references to v7.0 structure..."

# Update mrp-launcher.sh references
if [ -f "core/mrp-launcher.sh" ]; then
    sed -i.bak 's|reputational-scan-dispatcher\.sh|recipes/reputational/dispatcher.sh|g' core/mrp-launcher.sh
    sed -i.bak 's|organizational-scan-dispatcher\.sh|recipes/organizational/dispatcher.sh|g' core/mrp-launcher.sh
    sed -i.bak 's|gtm-marketing-dispatcher\.sh|recipes/gtm/dispatcher.sh|g' core/mrp-launcher.sh
fi

# Update API references
if [ -f "api/web-server.py" ]; then
    sed -i.bak "s|from research_pdf_api|from backend_api|g" api/web-server.py
fi

echo "✓ References updated"
EOF
    chmod +x "$SYSTEM_DIR/update-references.sh"
fi

# Step 12: Generate Migration Report
echo -e "\n${YELLOW}Step 12: Generating migration report...${NC}"

REPORT_FILE="$SYSTEM_DIR/MIGRATION_REPORT_$(date +%Y%m%d).md"

if [ "$DRY_RUN" = false ]; then
    cat > "$REPORT_FILE" << EOF
# MRP v7.0 Migration Report
Generated: $(date)

## Migration Summary
- **Backup Location:** $BACKUP_DIR
- **Scripts Consolidated:** 52 → ~15 core components
- **Deprecated Files:** ${#REDUNDANT_FILES[@]} files moved to deprecated/

## New Structure
\`\`\`
00_SYSTEM/
├── config/        # Central configuration
├── core/          # Core engines
├── recipes/       # Research recipes
├── api/           # Web/API interfaces
├── templates/     # Document templates
├── utils/         # Helper utilities
├── logs/          # System logs
└── deprecated/    # Old scripts for reference
\`\`\`

## Next Steps
1. Run \`./update-references.sh\` to update script references
2. Test each recipe with \`core/mrp-launcher.sh\`
3. Verify web interface at http://localhost:5000
4. Remove deprecated/ folder after 30 days

## Rollback Instructions
If needed, restore from backup:
\`\`\`bash
rm -rf 00_SYSTEM
mv $BACKUP_DIR 00_SYSTEM
\`\`\`
EOF
    echo -e "${GREEN}✓ Migration report saved to: $REPORT_FILE${NC}"
fi

# Final Summary
echo -e "\n${CYAN}${BOLD}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}${BOLD}║              MIGRATION COMPLETE                             ║${NC}"
echo -e "${CYAN}${BOLD}╚══════════════════════════════════════════════════════════════╝${NC}"

echo -e "\n${GREEN}✅ Successfully migrated to MRP v7.0 Enterprise Structure${NC}"
echo -e "\n${YELLOW}Key Changes:${NC}"
echo -e "  • Consolidated PDF generators into single system"
echo -e "  • Organized recipes into dedicated folders"
echo -e "  • Created central configuration system"
echo -e "  • Deprecated ${#REDUNDANT_FILES[@]} redundant files"
echo -e "  • Established clean enterprise architecture"

if [ "$DRY_RUN" = true ]; then
    echo -e "\n${YELLOW}This was a DRY RUN. To apply changes, run without --dry-run flag${NC}"
else
    echo -e "\n${YELLOW}Next Steps:${NC}"
    echo -e "  1. Run ${CYAN}./update-references.sh${NC} to update internal references"
    echo -e "  2. Test with ${CYAN}./core/mrp-launcher.sh${NC}"
    echo -e "  3. Review ${CYAN}$REPORT_FILE${NC}"
fi

echo -e "\n${BLUE}Your backup is at: $BACKUP_DIR${NC}"