#!/bin/bash
if [ -z "$1" ]; then
  echo "Usage: ./create-document.sh <input_file.md>"
  exit 1
fi
INPUT_FILE="$1"
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

# Create Final_PDFs directory at project root
FINAL_DIR="${PROJECT_ROOT}/Final_PDFs"
mkdir -p "${FINAL_DIR}"
OUTPUT_PDF="${FINAL_DIR}/${BASE_NAME}.pdf"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE="$SCRIPT_DIR/themes/waterloo-document-template.tex"
if [ ! -f "$TEMPLATE" ]; then
  echo "Error: Template file '$TEMPLATE' not found."
  exit 1
fi
echo "⏳ Generating document..."
echo "📄 Input: $INPUT_FILE"
echo "🎯 Output: $OUTPUT_PDF"
echo "📁 Project Root: $PROJECT_ROOT"
echo "📂 Directory: Final_PDFs/ (at project level)"

pandoc "${INPUT_FILE}" \
  --from markdown \
  --template="${TEMPLATE}" \
  --table-of-contents \
  --pdf-engine=tectonic \
  -o "${OUTPUT_PDF}"

if [ $? -eq 0 ]; then
  echo "✅ Document successfully created!"
  echo "📍 Location: ${OUTPUT_PDF}"
else
  echo "❌ Error generating document."
  exit 1
fi