#!/bin/bash

# Smart Client Logo Acquisition System
# Automatically detects and downloads client logos from research projects

if [ -z "$1" ]; then
  echo "Usage: ./acquire-client-logo.sh <project_directory>"
  echo ""
  echo "Examples:"
  echo "  ./acquire-client-logo.sh ../03_PROJECTS/Duarte/Research_Deep-Dive_*"  
  echo "  ./acquire-client-logo.sh ../03_PROJECTS/Pharos/Research_DeepDive_PharosCapitalGroup_*"
  echo ""
  exit 1
fi

PROJECT_DIR="$1"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEMES_DIR="$SCRIPT_DIR/themes"

# Extract project/client name from path
if [[ "$PROJECT_DIR" == *"03_PROJECTS"* ]]; then
  CLIENT_NAME=$(echo "$PROJECT_DIR" | grep -o '03_PROJECTS/[^/]*' | cut -d'/' -f2)
else
  CLIENT_NAME=$(basename "$PROJECT_DIR" | cut -d'_' -f1)
fi

CLIENT_NAME_LOWER=$(echo "$CLIENT_NAME" | tr '[:upper:]' '[:lower:]')

echo "🔍 Analyzing project for client logo: $CLIENT_NAME"
echo "📁 Project Directory: $PROJECT_DIR"

# Function to extract logo URLs from research content
extract_logo_urls() {
  local project_dir="$1"
  local urls=""
  
  # Search in fetched content for logo references
  if [ -d "$project_dir/02_fetched_content" ]; then
    echo "🔎 Scanning fetched content for logo URLs..."
    
    # Look for common logo patterns in markdown files
    urls=$(find "$project_dir/02_fetched_content" -name "*.md" -exec grep -ho 'https://[^)]*[Ll]ogo[^)]*\.png\|https://[^)]*[Ll]ogo[^)]*\.jpg\|https://[^)]*[Ll]ogo[^)]*\.svg' {} \; 2>/dev/null | head -5)
    
    if [ -n "$urls" ]; then
      echo "✅ Found logo URLs in research content:"
      echo "$urls" | sed 's/^/   • /'
      echo "$urls"
      return 0
    fi
  fi
  
  return 1
}

# Function to try common logo locations for known domains
try_common_logo_locations() {
  local client="$1"
  local domain=""
  local logo_urls=""
  
  case "$client" in
    "duarte"|"Duarte")
      domain="duarte.com"
      logo_urls="https://www.duarte.com/wp-content/uploads/2024/03/logoHeader-DuarteFull-Black-2x.png"
      ;;
    "pharos"|"Pharos"|"PharosCapitalGroup")
      domain="pharosfunds.com" 
      logo_urls="https://www.pharosfunds.com/assets/images/Pharos-Capital-Group-logo.png"
      ;;
    *)
      # Try generic patterns
      for tld in com net org; do
        logo_urls="$logo_urls https://www.${CLIENT_NAME_LOWER}.${tld}/logo.png https://www.${CLIENT_NAME_LOWER}.${tld}/assets/logo.png https://www.${CLIENT_NAME_LOWER}.${tld}/images/logo.png"
      done
      ;;
  esac
  
  if [ -n "$logo_urls" ]; then
    echo "🎯 Trying known logo locations for $client ($domain):"
    echo "$logo_urls" | tr ' ' '\n' | sed 's/^/   • /'
    echo "$logo_urls"
    return 0
  fi
  
  return 1
}

# Function to download and process logo
download_logo() {
  local logo_url="$1"
  local client_name="$2"
  local client_lower=$(echo "$client_name" | tr '[:upper:]' '[:lower:]')
  local output_file="$THEMES_DIR/${client_lower}-logo.png"
  
  echo "📥 Downloading logo from: $logo_url"
  echo "💾 Saving as: $output_file"
  
  # Download with proper headers
  if curl -L -s -f \
    -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36" \
    -H "Accept: image/*,*/*" \
    "$logo_url" -o "$output_file"; then
    
    # Verify it's actually an image file
    if file "$output_file" | grep -q "image\|PNG\|JPEG\|GIF\|SVG"; then
      echo "✅ Logo successfully downloaded and verified!"
      echo "📍 Location: $output_file"
      
      # Create symlink for generic access
      ln -sf "${client_lower}-logo.png" "$THEMES_DIR/client-logo.png"
      echo "🔗 Generic symlink created: client-logo.png"
      
      return 0
    else
      echo "❌ Downloaded file is not a valid image"
      rm -f "$output_file"
      return 1
    fi
  else
    echo "❌ Failed to download logo from: $logo_url"
    return 1
  fi
}

# Main logo acquisition logic
echo ""
echo "🚀 Starting systematic logo acquisition..."

# Step 1: Try to extract logo URLs from research content
LOGO_URLS=$(extract_logo_urls "$PROJECT_DIR")
EXTRACTION_SUCCESS=$?

# Step 2: If extraction failed, try common locations
if [ $EXTRACTION_SUCCESS -ne 0 ]; then
  echo "⚠️ No logos found in research content, trying common locations..."
  LOGO_URLS=$(try_common_logo_locations "$CLIENT_NAME")
  COMMON_LOCATION_SUCCESS=$?
else
  COMMON_LOCATION_SUCCESS=0
fi

# Step 3: Attempt downloads
if [ $EXTRACTION_SUCCESS -eq 0 ] || [ $COMMON_LOCATION_SUCCESS -eq 0 ]; then
  DOWNLOAD_SUCCESS=0
  
  # Try each URL until one succeeds
  for url in $LOGO_URLS; do
    if download_logo "$url" "$CLIENT_NAME"; then
      DOWNLOAD_SUCCESS=1
      break
    fi
  done
  
  if [ $DOWNLOAD_SUCCESS -eq 0 ]; then
    echo ""
    echo "❌ All logo download attempts failed"
    echo ""
    echo "🔧 Manual fallback options:"
    echo "   1. Visit the client website and save logo manually to:"
    echo "      $THEMES_DIR/${client_name_lower}-logo.png"
    echo ""
    echo "   2. Use a placeholder logo:"
    echo "      cp $THEMES_DIR/placeholder-logo.png $THEMES_DIR/${client_name_lower}-logo.png"
    echo ""
    exit 1
  fi
else
  echo "❌ No logo sources found for client: $CLIENT_NAME"
  echo ""
  echo "🔧 Manual setup required:"
  echo "   1. Research the client website"
  echo "   2. Download logo manually to: $THEMES_DIR/${client_name_lower}-logo.png"
  echo ""
  exit 1
fi

echo ""
echo "🎉 Logo acquisition complete!"
echo "📋 Summary:"
echo "   • Client: $CLIENT_NAME"
echo "   • Logo file: ${CLIENT_NAME_LOWER}-logo.png"
echo "   • Location: $THEMES_DIR/"
echo "   • Generic link: client-logo.png"
echo ""
echo "🔄 Ready for premium document generation!"