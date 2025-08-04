#!/bin/bash
if [ -z "$1" ]; then
  echo "Usage: ./create-document.sh <input_file.md>"
  exit 1
fi
INPUT_FILE="$1"
BASE_NAME=$(basename "${INPUT_FILE}" .md)
OUTPUT_PDF="${BASE_NAME}.pdf"
TEMPLATE="waterloo-document-template.tex"
if [ ! -f "$TEMPLATE" ]; then
  echo "Error: Template file '$TEMPLATE' not found."
  exit 1
fi
echo "⏳ Generating document..."
pandoc "${INPUT_FILE}" \
  --from markdown \
  --template="${TEMPLATE}" \
  --table-of-contents \
  --pdf-engine=tectonic \
  -o "${OUTPUT_PDF}"
echo "✅ Document successfully created at: ${OUTPUT_PDF}"