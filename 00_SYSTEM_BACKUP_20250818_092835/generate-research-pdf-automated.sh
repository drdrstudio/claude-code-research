#!/bin/bash

# Fully Automated Research PDF Generation System
# No manual intervention required - citations are automatically inserted

set -e

if [ -z "$1" ]; then
  echo "Usage: ./generate-research-pdf-automated.sh <project_directory> [template] [research_type]"
  echo ""
  echo "Templates:"
  echo "  tufte     - Edward Tufte's elegant academic style"
  echo "  sakura    - Minimal, clean Japanese-inspired design"
  echo "  corporate - Professional business template [Default]"
  echo "  classic   - Traditional academic paper style"
  echo ""
  echo "Research Types:"
  echo "  individual   - Individual reputational scan"
  echo "  organization - Organization-wide reputational scan"
  echo "  audience     - Potential audience scan (with keywords)"
  echo ""
  echo "Example:"
  echo "  ./generate-research-pdf-automated.sh ../03_PROJECTS/Pharos/Research_* tufte individual"
  exit 1
fi

PROJECT_DIR="$1"
TEMPLATE="${2:-corporate}"
RESEARCH_TYPE="${3:-organization}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🚀 FULLY AUTOMATED PDF GENERATION SYSTEM"
echo "========================================"
echo "📁 Project: $(basename "$PROJECT_DIR")"
echo "🎨 Template: $TEMPLATE"
echo "🔍 Research Type: $RESEARCH_TYPE"
echo ""

# Step 1: Extract citations from research files
echo "📊 Step 1: Extracting citations from research files..."
"$SCRIPT_DIR/auto-citation-extractor.sh" "$PROJECT_DIR"

# Step 2: Find the main document to enhance
echo ""
echo "📄 Step 2: Locating main document..."

MAIN_DOC=""
# Priority order for finding main document
SEARCH_PATHS=(
  "$PROJECT_DIR/FINAL_REPORTS/Comprehensive_Dossier.md"
  "$PROJECT_DIR/05_synthesis/FINAL_COMPREHENSIVE_ANALYSIS.md"
  "$PROJECT_DIR/05_synthesis/comprehensive_analysis.md"
  "$PROJECT_DIR/04_analysis/integrated_analysis.md"
)

for path in "${SEARCH_PATHS[@]}"; do
  if [ -f "$path" ]; then
    MAIN_DOC="$path"
    echo "✅ Found main document: $(basename "$MAIN_DOC")"
    break
  fi
done

if [ -z "$MAIN_DOC" ]; then
  # Find any comprehensive document
  MAIN_DOC=$(find "$PROJECT_DIR" -name "*omprehensive*.md" -o -name "*FINAL*.md" | head -1)
  if [ -z "$MAIN_DOC" ]; then
    echo "❌ No main document found. Please specify a document."
    exit 1
  fi
fi

# Step 3: Insert citations automatically
echo ""
echo "✍️ Step 3: Automatically inserting citations..."
python3 "$SCRIPT_DIR/auto-insert-citations.py" "$PROJECT_DIR" "$MAIN_DOC"

CITED_DOC="${MAIN_DOC%.md}_cited.md"
if [ ! -f "$CITED_DOC" ]; then
  echo "❌ Citation insertion failed"
  exit 1
fi

# Step 4: Acquire client logo
echo ""
echo "🎨 Step 4: Acquiring client logo..."
"$SCRIPT_DIR/acquire-client-logo.sh" "$PROJECT_DIR" || echo "⚠️ Using default logo"

# Step 5: Prepare output directory (renamed from Premium_PDFs)
PROJECT_ROOT=""
if [[ "$PROJECT_DIR" == *"03_PROJECTS"* ]]; then
  CLIENT_NAME=$(echo "$PROJECT_DIR" | grep -o '03_PROJECTS/[^/]*' | cut -d'/' -f2)
  PROJECT_ROOT=$(echo "$PROJECT_DIR" | grep -o '.*03_PROJECTS/[^/]*')
else
  PROJECT_ROOT="$PROJECT_DIR"
fi

OUTPUT_DIR="${PROJECT_ROOT}/PDFs"
mkdir -p "$OUTPUT_DIR"

# Step 6: Download template if needed
echo ""
echo "📥 Step 5: Preparing template: $TEMPLATE..."

case "$TEMPLATE" in
  "tufte")
    if [ ! -f "$SCRIPT_DIR/themes/tufte.css" ]; then
      echo "  Downloading Tufte CSS..."
      curl -s "https://raw.githubusercontent.com/edwardtufte/tufte-css/gh-pages/tufte.css" \
        -o "$SCRIPT_DIR/themes/tufte.css"
      # Download fonts
      curl -s "https://raw.githubusercontent.com/edwardtufte/tufte-css/gh-pages/et-book/et-book-roman-line-figures/et-book-roman-line-figures.woff" \
        -o "$SCRIPT_DIR/themes/et-book-roman.woff"
    fi
    CSS_FILE="$SCRIPT_DIR/themes/tufte.css"
    ;;
    
  "sakura")
    if [ ! -f "$SCRIPT_DIR/themes/sakura.css" ]; then
      echo "  Downloading Sakura CSS..."
      curl -s "https://raw.githubusercontent.com/oxalorg/sakura/master/css/sakura.css" \
        -o "$SCRIPT_DIR/themes/sakura.css"
    fi
    CSS_FILE="$SCRIPT_DIR/themes/sakura.css"
    ;;
    
  "corporate")
    CSS_FILE="$SCRIPT_DIR/themes/corporate-style.css"
    # Create if doesn't exist
    if [ ! -f "$CSS_FILE" ]; then
      "$SCRIPT_DIR/create-corporate-template.sh"
    fi
    ;;
    
  "classic")
    CSS_FILE="$SCRIPT_DIR/themes/classic-style.css"
    # Create if doesn't exist
    if [ ! -f "$CSS_FILE" ]; then
      "$SCRIPT_DIR/create-classic-template.sh"
    fi
    ;;
    
  *)
    echo "❌ Unknown template: $TEMPLATE"
    exit 1
    ;;
esac

# Step 7: Add research type specific content
echo ""
echo "📋 Step 6: Customizing for research type: $RESEARCH_TYPE..."

ENHANCED_DOC="${CITED_DOC%.md}_enhanced.md"
cp "$CITED_DOC" "$ENHANCED_DOC"

case "$RESEARCH_TYPE" in
  "individual")
    # Add individual-specific sections
    cat >> "$ENHANCED_DOC" << 'EOF'

---

## Research Classification
**Type:** Individual Reputational Assessment
**Focus:** Personal reputation, professional history, and public presence analysis
EOF
    ;;
    
  "organization")
    # Add organization-specific sections
    cat >> "$ENHANCED_DOC" << 'EOF'

---

## Research Classification
**Type:** Organizational Reputational Analysis
**Focus:** Corporate reputation, market position, and stakeholder perception
EOF
    ;;
    
  "audience")
    # Add audience-specific sections with keyword data
    cat >> "$ENHANCED_DOC" << 'EOF'

---

## Research Classification
**Type:** Audience Intelligence Report
**Focus:** Target audience analysis, keyword insights, and market segmentation

### Keyword Analysis
[Keyword data will be inserted here when DataForSEO integration is enabled]
EOF
    ;;
esac

# Step 8: Generate HTML with template
echo ""
echo "🎨 Step 7: Generating HTML with $TEMPLATE template..."

HTML_FILE="${OUTPUT_DIR}/$(basename "${MAIN_DOC%.md}").html"

# Convert markdown to HTML with proper styling
pandoc "$ENHANCED_DOC" \
  --from markdown \
  --to html5 \
  --standalone \
  --toc \
  --toc-depth=3 \
  --css="$CSS_FILE" \
  --metadata title="$(head -1 "$ENHANCED_DOC" | sed 's/^# //')" \
  -o "$HTML_FILE"

# Step 9: Generate PDF from HTML
echo ""
echo "📄 Step 8: Converting to PDF..."

OUTPUT_PDF="${OUTPUT_DIR}/$(basename "${MAIN_DOC%.md}").pdf"

# Use WeasyPrint for CSS-based PDF generation
if command -v weasyprint &> /dev/null; then
  weasyprint "$HTML_FILE" "$OUTPUT_PDF"
elif command -v wkhtmltopdf &> /dev/null; then
  wkhtmltopdf --enable-local-file-access "$HTML_FILE" "$OUTPUT_PDF"
else
  echo "⚠️ No PDF converter found. Installing WeasyPrint..."
  pip3 install weasyprint
  weasyprint "$HTML_FILE" "$OUTPUT_PDF"
fi

# Step 10: Cleanup temporary files
echo ""
echo "🧹 Step 9: Cleaning up..."
rm -f citations.json citations_bibliography.md
rm -f "$CITED_DOC" "$ENHANCED_DOC"

# Step 11: Final report
echo ""
echo "✅ PDF GENERATION COMPLETE!"
echo "=" * 50
echo "📊 Summary:"
echo "  📁 Project: $(basename "$PROJECT_DIR")"
echo "  🎨 Template: $TEMPLATE"
echo "  🔍 Type: $RESEARCH_TYPE"
echo "  📄 Output PDF: $OUTPUT_PDF"
echo "  🌐 HTML Version: $HTML_FILE"
echo ""

# Count citations in final document
if [ -f "$OUTPUT_PDF" ]; then
  echo "📈 Document Statistics:"
  echo "  Pages: $(pdfinfo "$OUTPUT_PDF" 2>/dev/null | grep Pages | awk '{print $2}' || echo 'N/A')"
  echo "  Size: $(ls -lh "$OUTPUT_PDF" | awk '{print $5}')"
fi

echo ""
echo "🎯 Ready for delivery!"