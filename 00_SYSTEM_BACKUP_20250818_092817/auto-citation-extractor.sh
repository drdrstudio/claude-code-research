#!/bin/bash

# Automatic Citation Extraction and Mapping System
# Extracts citations from research files and creates proper bibliography

set -e

if [ -z "$1" ]; then
  echo "Usage: ./auto-citation-extractor.sh <project_directory>"
  echo ""
  echo "This script automatically extracts citations from research files"
  echo "and creates a properly formatted bibliography with footnotes."
  exit 1
fi

PROJECT_DIR="$1"
OUTPUT_FILE="${2:-citations.json}"

echo "🔍 Automatic Citation Extraction System"
echo "======================================="
echo "📁 Project: $PROJECT_DIR"
echo ""

# Initialize citation counter and arrays
CITATION_COUNTER=1
declare -A URL_TO_CITATION
declare -A CITATION_TO_URL
declare -A FILE_TO_URL

# Function to extract URL from file header
extract_url_from_file() {
  local file="$1"
  local url=""
  
  # Try multiple patterns for URL extraction
  # Pattern 1: <!-- URL: xxx -->
  url=$(grep -m1 "<!-- URL:" "$file" 2>/dev/null | sed 's/.*<!-- URL: \(.*\) -->.*/\1/' || true)
  
  # Pattern 2: <!-- Source: xxx -->
  if [ -z "$url" ]; then
    url=$(grep -m1 "<!-- Source:" "$file" 2>/dev/null | sed 's/.*<!-- Source: \(.*\) -->.*/\1/' || true)
  fi
  
  # Pattern 3: [Source](url) in first 10 lines
  if [ -z "$url" ]; then
    url=$(head -10 "$file" | grep -o '\[Source\]([^)]*)' | sed 's/\[Source\](\(.*\))/\1/' | head -1 || true)
  fi
  
  # Pattern 4: Extract from filename if it contains a domain
  if [ -z "$url" ]; then
    filename=$(basename "$file")
    if [[ "$filename" =~ ([a-zA-Z0-9-]+\.(com|org|net|gov|edu)) ]]; then
      domain="${BASH_REMATCH[1]}"
      url="https://$domain"
    fi
  fi
  
  echo "$url"
}

# Function to extract key facts from content
extract_facts_from_file() {
  local file="$1"
  local url="$2"
  local facts=""
  
  # Extract significant content patterns
  # Numbers and statistics
  facts+=$(grep -o '[0-9][0-9,]*\(\.[0-9]*\)\?\s*\(million\|billion\|percent\|%\|dollars\|\$\)' "$file" 2>/dev/null | head -5 || true)
  facts+=$'\n'
  
  # Dates
  facts+=$(grep -o '\(January\|February\|March\|April\|May\|June\|July\|August\|September\|October\|November\|December\)\s\+[0-9]\{1,2\},\?\s\+[0-9]\{4\}' "$file" 2>/dev/null | head -5 || true)
  facts+=$'\n'
  
  # Quotes
  facts+=$(grep -o '"[^"]\{20,200\}"' "$file" 2>/dev/null | head -3 || true)
  facts+=$'\n'
  
  # Names and titles (capitalized phrases)
  facts+=$(grep -o '\b[A-Z][a-zA-Z]*\s\+[A-Z][a-zA-Z]*\b' "$file" 2>/dev/null | sort -u | head -10 || true)
  
  echo "$facts"
}

# Process fetched content files
echo "📂 Processing fetched content..."
if [ -d "$PROJECT_DIR/02_fetched_content" ]; then
  for file in "$PROJECT_DIR/02_fetched_content"/*.md; do
    if [ -f "$file" ]; then
      filename=$(basename "$file")
      echo "  📄 Processing: $filename"
      
      # Extract URL
      url=$(extract_url_from_file "$file")
      if [ -n "$url" ]; then
        # Store file to URL mapping
        FILE_TO_URL["$filename"]="$url"
        
        # Assign citation number if new URL
        if [ -z "${URL_TO_CITATION[$url]}" ]; then
          URL_TO_CITATION["$url"]=$CITATION_COUNTER
          CITATION_TO_URL[$CITATION_COUNTER]="$url"
          echo "    ✅ Citation [^$CITATION_COUNTER]: $url"
          ((CITATION_COUNTER++))
        fi
      else
        echo "    ⚠️  No URL found in file"
      fi
    fi
  done
fi

# Process analysis files
echo ""
echo "📂 Processing analysis files..."
if [ -d "$PROJECT_DIR/04_analysis" ]; then
  for file in "$PROJECT_DIR/04_analysis"/*.md; do
    if [ -f "$file" ]; then
      filename=$(basename "$file")
      echo "  📄 Processing: $filename"
      
      # Analysis files may reference multiple sources
      # Extract all referenced sources
      urls=$(grep -o 'https://[^[:space:]]*' "$file" 2>/dev/null | sort -u || true)
      
      for url in $urls; do
        if [ -n "$url" ]; then
          # Clean URL (remove trailing punctuation)
          url=$(echo "$url" | sed 's/[.,;:!?)]*$//')
          
          if [ -z "${URL_TO_CITATION[$url]}" ]; then
            URL_TO_CITATION["$url"]=$CITATION_COUNTER
            CITATION_TO_URL[$CITATION_COUNTER]="$url"
            echo "    ✅ Citation [^$CITATION_COUNTER]: $url"
            ((CITATION_COUNTER++))
          fi
        fi
      done
    fi
  done
fi

# Generate JSON output
echo ""
echo "📝 Generating citation index..."

cat > "$OUTPUT_FILE" << EOF
{
  "project": "$PROJECT_DIR",
  "generated": "$(date -u +"%Y-%m-%d %H:%M:%S UTC")",
  "total_citations": $((CITATION_COUNTER - 1)),
  "citations": [
EOF

# Add each citation
first=true
for i in $(seq 1 $((CITATION_COUNTER - 1))); do
  if [ "$first" = true ]; then
    first=false
  else
    echo "," >> "$OUTPUT_FILE"
  fi
  
  url="${CITATION_TO_URL[$i]}"
  # Escape quotes in URL for JSON
  url_escaped=$(echo "$url" | sed 's/"/\\"/g')
  
  cat >> "$OUTPUT_FILE" << EOF
    {
      "number": $i,
      "marker": "[^$i]",
      "url": "$url_escaped",
      "accessed": "$(date -u +"%Y-%m-%d")"
    }
EOF
done

cat >> "$OUTPUT_FILE" << EOF

  ],
  "file_mappings": {
EOF

# Add file to citation mappings
first=true
for filename in "${!FILE_TO_URL[@]}"; do
  if [ "$first" = true ]; then
    first=false
  else
    echo "," >> "$OUTPUT_FILE"
  fi
  
  url="${FILE_TO_URL[$filename]}"
  citation_num="${URL_TO_CITATION[$url]}"
  
  cat >> "$OUTPUT_FILE" << EOF
    "$filename": {
      "url": "$url",
      "citation": "[^$citation_num]"
    }
EOF
done

cat >> "$OUTPUT_FILE" << EOF

  }
}
EOF

# Generate markdown bibliography
BIBLIOGRAPHY_FILE="${OUTPUT_FILE%.json}_bibliography.md"
echo "" > "$BIBLIOGRAPHY_FILE"
echo "## Bibliography" >> "$BIBLIOGRAPHY_FILE"
echo "" >> "$BIBLIOGRAPHY_FILE"

for i in $(seq 1 $((CITATION_COUNTER - 1))); do
  url="${CITATION_TO_URL[$i]}"
  echo "[^$i]: $url (Accessed: $(date -u +"%Y-%m-%d"))" >> "$BIBLIOGRAPHY_FILE"
done

echo ""
echo "✅ Citation extraction complete!"
echo "📊 Total citations: $((CITATION_COUNTER - 1))"
echo "📄 Citation index: $OUTPUT_FILE"
echo "📚 Bibliography: $BIBLIOGRAPHY_FILE"
echo ""
echo "Next step: Use these citations when generating the final document"