#!/bin/bash

# Enterprise Research PDF Generator with Citations
# Automatically creates professional PDFs with proper source citations

if [ -z "$1" ]; then
  echo "Usage: ./create-research-pdf-with-citations.sh <research_project_directory> [document_type]"
  echo ""
  echo "Document Types:"
  echo "  comprehensive - Full comprehensive analysis document"
  echo "  executive     - Executive summary only"  
  echo "  both         - Generate both types [Default]"
  echo ""
  echo "Examples:"
  echo "  ./create-research-pdf-with-citations.sh ../03_PROJECTS/Pharos/Research_DeepDive_PharosCapitalGroup_*"
  echo "  ./create-research-pdf-with-citations.sh ../03_PROJECTS/Duarte/Research_Deep-Dive_* executive"
  echo ""
  exit 1
fi

PROJECT_DIR="$1"
DOC_TYPE="${2:-both}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Extract project/client information
if [[ "$PROJECT_DIR" == *"03_PROJECTS"* ]]; then
  CLIENT_NAME=$(echo "$PROJECT_DIR" | grep -o '03_PROJECTS/[^/]*' | cut -d'/' -f2)
  PROJECT_ROOT=$(echo "$PROJECT_DIR" | grep -o '.*03_PROJECTS/[^/]*')
else
  CLIENT_NAME=$(basename "$PROJECT_DIR" | cut -d'_' -f1)
  PROJECT_ROOT="$PROJECT_DIR"
fi

echo "🎯 ENTERPRISE PDF GENERATION WITH CITATIONS"
echo "════════════════════════════════════════════"
echo "📁 Client: $CLIENT_NAME"
echo "📂 Project: $(basename "$PROJECT_DIR")"
echo "📄 Document Type: $DOC_TYPE"
echo ""

# Step 1: Acquire client logo
echo "📥 Step 1: Acquiring client logo..."
if ! "$SCRIPT_DIR/acquire-client-logo.sh" "$PROJECT_DIR"; then
  echo "⚠️ Logo acquisition failed - proceeding with default branding"
fi

# Step 2: Generate comprehensive document with citations
create_comprehensive_document() {
  local output_dir="$PROJECT_ROOT/Premium_PDFs"
  mkdir -p "$output_dir"
  
  echo ""
  echo "📊 Step 2: Creating comprehensive document with citations..."
  
  # Find all research content
  RESEARCH_FILES=""
  if [ -d "$PROJECT_DIR/FINAL_REPORTS" ]; then
    RESEARCH_FILES="$PROJECT_DIR/FINAL_REPORTS/*.md"
  elif [ -d "$PROJECT_DIR/05_synthesis" ]; then
    RESEARCH_FILES="$PROJECT_DIR/05_synthesis/*.md"
  elif [ -d "$PROJECT_DIR/04_analysis" ]; then
    RESEARCH_FILES="$PROJECT_DIR/04_analysis/*.md"
  fi
  
  # Find the most comprehensive document
  MAIN_DOC=""
  for file in $RESEARCH_FILES; do
    if [[ -f "$file" ]]; then
      if [[ $(basename "$file") =~ (COMPREHENSIVE|comprehensive|FINAL|final|DOSSIER|dossier) ]]; then
        MAIN_DOC="$file"
        break
      fi
    fi
  done
  
  if [ -z "$MAIN_DOC" ]; then
    echo "❌ No comprehensive document found in $PROJECT_DIR"
    return 1
  fi
  
  echo "📋 Using source document: $(basename "$MAIN_DOC")"
  
  # Generate citation-enhanced version
  echo "🔗 Enhancing document with source citations..."
  
  # Create enhanced version with source mapping
  ENHANCED_DOC="${output_dir}/$(basename "$MAIN_DOC" .md)_ENHANCED.md"
  
  cat > "$ENHANCED_DOC" << 'EOF'
# ENHANCED DOCUMENT GENERATION PROMPT

**CRITICAL**: This document MUST include comprehensive source citations for every data point, claim, and analysis.

## CITATION REQUIREMENTS:
1. **Every factual claim** must reference the source URL
2. **Every data point** (numbers, dates, names) must show originating source  
3. **Every analysis conclusion** must link back to supporting evidence
4. **Format**: Use footnote-style citations [^1] with full URL list at document end

## DOCUMENT STRUCTURE REQUIRED:
1. **Executive Summary** (2-3 pages with key citations)
2. **Detailed Analysis** (10-15 pages with comprehensive sourcing)
3. **Supporting Evidence** (appendix with source material excerpts)
4. **Complete Source Index** (all URLs with access dates and content summaries)

## QUALITY STANDARDS:
- Minimum 15-20 pages for comprehensive analysis
- Minimum 25-50 source citations for credibility
- Each major section must have 5-10 supporting references
- No unsourced claims or data points allowed

---

EOF

  # Append original content
  cat "$MAIN_DOC" >> "$ENHANCED_DOC"
  
  # Add source mapping section
  cat >> "$ENHANCED_DOC" << 'EOF'

---

# SOURCE MAPPING REQUIREMENTS

**INSTRUCTIONS FOR DOCUMENT ENHANCEMENT:**

This document requires immediate enhancement with comprehensive source citations. Please:

1. **Map every data point** to its originating research file
2. **Add footnote citations** [^1], [^2], etc. throughout the text  
3. **Create comprehensive bibliography** with all source URLs
4. **Expand thin sections** with additional research from the project files
5. **Ensure 15-20 page minimum** for enterprise credibility

## Available Research Sources:
EOF

  # List all available research files
  echo "### Fetched Content Sources:" >> "$ENHANCED_DOC"
  if [ -d "$PROJECT_DIR/02_fetched_content" ]; then
    find "$PROJECT_DIR/02_fetched_content" -name "*.md" -exec basename {} \; | sort | sed 's/^/- /' >> "$ENHANCED_DOC"
  fi
  
  echo "### Analysis Sources:" >> "$ENHANCED_DOC"
  if [ -d "$PROJECT_DIR/04_analysis" ]; then
    find "$PROJECT_DIR/04_analysis" -name "*.md" -exec basename {} \; | sort | sed 's/^/- /' >> "$ENHANCED_DOC"
  fi
  
  echo "### Search Results Sources:" >> "$ENHANCED_DOC"
  if [ -d "$PROJECT_DIR/01_searches" ]; then
    find "$PROJECT_DIR/01_searches" -name "*.json" -exec basename {} \; | sort | sed 's/^/- /' >> "$ENHANCED_DOC"
  fi
  
  echo "" >> "$ENHANCED_DOC"
  echo "**ACTION REQUIRED**: Please regenerate this document with comprehensive citations and expanded analysis before PDF creation." >> "$ENHANCED_DOC"
  
  echo "✅ Enhanced document template created: $ENHANCED_DOC"
  echo ""
  echo "🚨 NEXT STEP REQUIRED: Please use Claude to regenerate the enhanced document with proper citations before proceeding to PDF generation."
  echo ""
  
  return 0
}

# Step 3: Generate executive summary
create_executive_summary() {
  echo "📋 Step 3: Creating executive summary..."
  # Executive summary logic here
  echo "✅ Executive summary generation placeholder"
}

# Step 4: Generate PDFs
generate_pdfs() {
  echo "🎨 Step 4: Generating branded PDFs..."
  # PDF generation logic here  
  echo "✅ PDF generation placeholder"
}

# Execute based on document type
case "$DOC_TYPE" in
  "comprehensive")
    create_comprehensive_document
    ;;
  "executive") 
    create_executive_summary
    ;;
  "both")
    create_comprehensive_document
    create_executive_summary
    ;;
  *)
    echo "❌ Invalid document type: $DOC_TYPE"
    exit 1
    ;;
esac

echo ""
echo "🎉 Enterprise PDF generation process initiated!"
echo ""
echo "📋 NEXT STEPS:"
echo "   1. Review enhanced document template created"
echo "   2. Use Claude to regenerate with comprehensive citations"  
echo "   3. Run PDF generation on citation-enhanced version"
echo "   4. Verify document meets 15-20 page minimum requirement"
echo ""