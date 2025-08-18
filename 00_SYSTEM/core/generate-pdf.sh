#!/bin/bash

# Premium Enterprise Document Generator with Branded Template
# Creates professional documents with client logos and cover pages

if [ -z "$1" ]; then
  echo "Usage: ./create-premium-document.sh <input_file.md> [font_option]"
  echo ""
  echo "Font Options:"  
  echo "  1 - Source Sans Pro (Modern, Clean) [Default]"
  echo "  2 - Times New Roman (Traditional Business)"
  echo "  3 - Palatino (Elegant Serif)"
  echo "  4 - Helvetica (Professional Sans-Serif)" 
  echo "  5 - Charter (Business Readable)"
  echo ""
  exit 1
fi

INPUT_FILE="$1"
FONT_OPTION="${2:-1}"
BASE_NAME=$(basename "${INPUT_FILE}" .md)
INPUT_DIR=$(dirname "${INPUT_FILE}")

# Find project root (look for 03_PROJECTS in path)
PROJECT_ROOT=""
TEMP_DIR="${INPUT_DIR}"
while [[ "$TEMP_DIR" != "/" ]]; do
  if [[ "$TEMP_DIR" == *"03_PROJECTS"* ]]; then
    # Find the client/project folder (e.g., Duarte, Pharos, etc.)
    PROJECT_NAME=$(echo "$TEMP_DIR" | grep -o '03_PROJECTS/[^/]*' | cut -d'/' -f2)
    if [[ -n "$PROJECT_NAME" ]]; then
      PROJECT_ROOT=$(echo "$TEMP_DIR" | grep -o '.*03_PROJECTS/[^/]*')
      break
    fi
  fi
  TEMP_DIR=$(dirname "$TEMP_DIR")
done

# Fallback to input directory if project root not found
if [[ -z "$PROJECT_ROOT" ]]; then
  PROJECT_ROOT="${INPUT_DIR}"
fi

# Create Premium_PDFs directory at project root
PREMIUM_DIR="${PROJECT_ROOT}/Premium_PDFs"
mkdir -p "${PREMIUM_DIR}"
OUTPUT_PDF="${PREMIUM_DIR}/${BASE_NAME}_Premium.pdf"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Select template based on client
case "$PROJECT_NAME" in
  "Pharos"|"pharos")
    TEMPLATE="$SCRIPT_DIR/themes/pharos-branded-template.tex"
    ;;
  "Duarte"|"duarte") 
    TEMPLATE="$SCRIPT_DIR/themes/duarte-branded-template.tex"
    ;;
  *)
    TEMPLATE="$SCRIPT_DIR/themes/duarte-branded-template.tex"  # Default fallback
    ;;
esac

# Verify template exists
if [ ! -f "$TEMPLATE" ]; then
  echo "❌ Error: Premium template file '$TEMPLATE' not found."
  exit 1
fi

# Automatic client logo acquisition
PROJECT_NAME_LOWER=$(echo "$PROJECT_NAME" | tr '[:upper:]' '[:lower:]')
CLIENT_LOGO_PATH="$SCRIPT_DIR/themes/${PROJECT_NAME_LOWER}-logo.png"
PREMIUM_LOGO="${PREMIUM_DIR}/${PROJECT_NAME_LOWER}-logo.png"

# Check if client-specific logo exists, if not, acquire it
if [ ! -f "$CLIENT_LOGO_PATH" ]; then
  echo "🔍 Client logo not found, acquiring automatically..."
  "$SCRIPT_DIR/acquire-client-logo.sh" "$INPUT_DIR"
fi

# Fallback to generic client logo if acquisition failed
if [ ! -f "$CLIENT_LOGO_PATH" ]; then
  CLIENT_LOGO_PATH="$SCRIPT_DIR/themes/client-logo.png"
fi

# Final fallback to duarte logo for compatibility
if [ ! -f "$CLIENT_LOGO_PATH" ]; then
  echo "⚠️ Using Duarte logo as fallback..."
  CLIENT_LOGO_PATH="$SCRIPT_DIR/themes/duarte-logo.png"
  if [ ! -f "$CLIENT_LOGO_PATH" ]; then
    echo "📥 Downloading Duarte logo..."
    cd "$SCRIPT_DIR/themes" && curl -s "https://www.duarte.com/wp-content/uploads/2024/03/logoHeader-DuarteFull-Black-2x.png" -o duarte-logo.png
    CLIENT_LOGO_PATH="$SCRIPT_DIR/themes/duarte-logo.png"
  fi
fi

# Copy logo to Premium_PDFs directory for LaTeX access
cp "$CLIENT_LOGO_PATH" "$PREMIUM_LOGO"
echo "🎨 Using logo: $(basename "$CLIENT_LOGO_PATH")"

# Create font-specific template
TEMP_TEMPLATE="${SCRIPT_DIR}/themes/temp_premium_template.tex"
cp "$TEMPLATE" "$TEMP_TEMPLATE"

# Apply font selection
case $FONT_OPTION in
  2)
    echo "🎨 Using Times New Roman (Traditional Business)"
    sed -i.bak 's/% \(\\usepackage{times}\)/\1/' "$TEMP_TEMPLATE"
    sed -i.bak 's/\\usepackage{sourcesanspro}/% \\usepackage{sourcesanspro}/' "$TEMP_TEMPLATE"
    sed -i.bak 's/\\renewcommand{\\familydefault}{\\sfdefault}/% \\renewcommand{\\familydefault}{\\sfdefault}/' "$TEMP_TEMPLATE"
    ;;
  3)
    echo "🎨 Using Palatino (Elegant Serif)"
    sed -i.bak 's/% \(\\usepackage{palatino}\)/\1/' "$TEMP_TEMPLATE"
    sed -i.bak 's/\\usepackage{sourcesanspro}/% \\usepackage{sourcesanspro}/' "$TEMP_TEMPLATE"
    sed -i.bak 's/\\renewcommand{\\familydefault}{\\sfdefault}/% \\renewcommand{\\familydefault}{\\sfdefault}/' "$TEMP_TEMPLATE"
    ;;
  4)
    echo "🎨 Using Helvetica (Professional Sans-Serif)"
    sed -i.bak 's/% \(\\usepackage{helvet}\)/\1/' "$TEMP_TEMPLATE" 
    sed -i.bak 's/\\usepackage{sourcesanspro}/% \\usepackage{sourcesanspro}/' "$TEMP_TEMPLATE"
    ;;
  5)
    echo "🎨 Using Charter (Business Readable)"
    sed -i.bak 's/% \(\\usepackage{charter}\)/\1/' "$TEMP_TEMPLATE"
    sed -i.bak 's/\\usepackage{sourcesanspro}/% \\usepackage{sourcesanspro}/' "$TEMP_TEMPLATE"
    sed -i.bak 's/\\renewcommand{\\familydefault}{\\sfdefault}/% \\renewcommand{\\familydefault}{\\sfdefault}/' "$TEMP_TEMPLATE"
    ;;
  *)
    echo "🎨 Using Source Sans Pro (Modern, Clean) [Default]"
    ;;
esac

echo "⏳ Generating premium enterprise document..."
echo "📄 Input: $INPUT_FILE"
echo "🎯 Output: $OUTPUT_PDF"
echo "📁 Project Root: $PROJECT_ROOT"
echo "📂 Directory: Premium_PDFs/ (at project level)"
echo "🏢 Template: Premium Enterprise with Cover Page"

# Convert to absolute path for pandoc
INPUT_FILE_ABS=$(realpath "${INPUT_FILE}")

# Generate PDF from Premium_PDFs directory (for logo access)
cd "${PREMIUM_DIR}"
LOGO_FILENAME=$(basename "$CLIENT_LOGO_PATH")
pandoc "${INPUT_FILE_ABS}" \
  --from markdown \
  --template="${TEMP_TEMPLATE}" \
  --table-of-contents \
  --pdf-engine=tectonic \
  --variable=toc:true \
  --variable=logo_file:"$LOGO_FILENAME" \
  --variable=client_name:"$PROJECT_NAME" \
  -o "${OUTPUT_PDF}"

# Check if generation was successful
if [ $? -eq 0 ]; then
  echo "✅ Premium document successfully created!"
  echo "📍 Location: ${OUTPUT_PDF}"
  echo ""
  echo "📋 Document Features:"
  echo "   • Professional cover page with client logo"
  echo "   • Branded headers on every page" 
  echo "   • Table of contents"
  echo "   • Enterprise-grade formatting"
  echo "   • Client-specific styling"
else
  echo "❌ Error generating document. Check the input file and try again."
  exit 1
fi

# Cleanup
rm -f "$TEMP_TEMPLATE" "${TEMP_TEMPLATE}.bak"

echo ""
echo "💡 Pro Tip: To systematize this process, add PROJECT_CONFIG.json with:"
echo '   "default_template": "premium-enterprise",'
echo '   "client_logo": "duarte-logo.png",'
echo '   "font_preference": "1"'