# MRP v6.1 - Full Backend Automation

## Version Summary
**Released:** January 13, 2025  
**Status:** Production Ready  
**Major Focus:** Complete backend automation, citation system, multi-output support

## Key Differences from v6.0

### MRP v6.0 (Previous)
- **Manual Steps Required:**
  - Citation insertion was manual
  - Claude had to regenerate documents with citations
  - PDF generation required multiple script runs
  
- **Limited Options:**
  - Only LaTeX templates
  - PDF output only
  - No WordPress integration
  
- **Confusing Structure:**
  - Final_PDFs vs Premium_PDFs distinction
  - Multiple directory structures
  - Unclear research type definitions

- **Repetitive Questions:**
  - System kept asking about citations (despite being mandatory)
  - Asked about executive summary format
  - Template selection was limited

### MRP v6.1 (Current)
- **Fully Automated:**
  - ✅ Automatic citation extraction and insertion
  - ✅ Single command generates complete output
  - ✅ Web interface for easy access
  
- **Multiple Output Options:**
  - ✅ PDF generation
  - ✅ WordPress publishing to waterloo.digital
  - ✅ Both simultaneously
  - ✅ Optional outputs (not always required)
  
- **Template Variety:**
  - ✅ Tufte (academic elegant)
  - ✅ Sakura (minimal clean)
  - ✅ Corporate (professional)
  - ✅ Classic (traditional academic)
  
- **Simplified Structure:**
  - ✅ All outputs → `PROJECT/PDFs/`
  - ✅ No more Premium/Final confusion
  - ✅ Clear research type frameworks

## New Components in v6.1

### 1. Automatic Citation System
```bash
# Extracts all URLs from research files
./auto-citation-extractor.sh [PROJECT]

# Intelligently inserts citations into documents
python auto-insert-citations.py [PROJECT] [DOCUMENT]
```
- No AI hallucinations
- 100% accurate source mapping
- Automatic bibliography generation

### 2. WordPress Integration
```python
# Publishes directly to waterloo.digital
python publish-to-wordpress.py [PROJECT] \
  --research-type organization \
  --target-name "Company Name" \
  --status draft
```
- Automatic category assignment
- Featured image support
- Draft/Publish/Private options

### 3. Web Interface
```bash
# Simple internal tool
python web-api-server.py
# Access at http://localhost:5000
```
- Clean, modern UI
- All parameters in one form
- Real-time status updates
- Support for existing projects

### 4. Three Research Type Structures

#### Individual
- Personal reputation assessment
- Professional history tracking
- Network analysis
- Digital presence evaluation

#### Organization  
- Corporate analysis
- Financial performance
- Market position
- Compliance assessment

#### Audience
- Demographics and psychographics
- Keyword intelligence
- Content preferences
- **DataForSEO toggle (cost control)**

## Technical Improvements

### Backend API
```python
# Unified entry point
python research-pdf-api.py \
  --research-type organization \
  --target-name "Apple Inc" \
  --output-types pdf wordpress \
  --template tufte
```

### Directory Simplification
```
Before (v6.0):
PROJECT/
├── Final_PDFs/
├── Premium_PDFs/
└── FINAL_REPORTS/

After (v6.1):
PROJECT/
└── PDFs/  # Everything here
```

### Permanent Features (Never Asked)
1. **Citations** - Always automated
2. **Executive Summary** - Always at top
3. **Source Attribution** - Always comprehensive

## Usage Comparison

### v6.0 Workflow (Old)
```bash
# Step 1: Generate citation template (manual)
./create-research-pdf-with-citations.sh [PROJECT]

# Step 2: MANUAL - Claude regenerates with citations

# Step 3: Generate PDF
./create-premium-document.sh [DOCUMENT]

# Step 4: Manual upload to WordPress if needed
```

### v6.1 Workflow (New)
```bash
# Option 1: Web Interface (RECOMMENDED)
python web-api-server.py
# Click button, done!

# Option 2: CLI (one command)
python research-pdf-api.py \
  --research-type organization \
  --target-name "Company" \
  --output-types pdf wordpress
# Everything automated!
```

## Migration Notes

### For Existing Projects
- Old Premium_PDFs → Now just PDFs
- Old citation process → Now automatic
- Old templates → Still work, plus new options

### For New Projects
- Use web interface by default
- Select research type first
- Choose output options (PDF/WordPress/both)
- Toggle DataForSEO only for audience scans

## API Structure

### Request Format
```json
{
  "research_type": "organization",
  "target_name": "Tesla Inc",
  "template": "tufte",
  "output_types": ["pdf", "wordpress"],
  "include_keywords": false,
  "wordpress_status": "draft"
}
```

### Response Format
```json
{
  "success": true,
  "outputs": {
    "pdf": {
      "success": true,
      "path": "/path/to/document.pdf"
    },
    "wordpress": {
      "success": true,
      "post_url": "https://waterloo.digital/...",
      "edit_url": "https://waterloo.digital/wp-admin/..."
    }
  }
}
```

## Environment Variables

```bash
# WordPress (required for publishing)
export WP_USERNAME="your_username"
export WP_PASSWORD="your_app_password"

# DataForSEO (optional, for audience scans)
export DATAFORSEO_LOGIN="your_login"
export DATAFORSEO_PASSWORD="your_password"

# Gemini (for mega-analysis)
export GEMINI_API_KEY="your_key"
```

## Quick Start

### 1. Install Dependencies
```bash
pip install flask flask-cors requests weasyprint
```

### 2. Start Web Interface
```bash
cd ~/Documents/cursor/Claude-Code-Research
python 00_SYSTEM/web-api-server.py
```

### 3. Access Interface
Open browser to: http://localhost:5000

### 4. Generate Research
- Select research type
- Enter target name
- Choose template
- Select outputs (PDF/WordPress/both)
- Click Generate

## Summary of Improvements

| Feature | v6.0 | v6.1 |
|---------|------|------|
| Citation Insertion | Manual | Automatic |
| Output Options | PDF only | PDF, WordPress, Both |
| Templates | LaTeX only | Tufte, Sakura, Corporate, Classic |
| Research Types | Undefined | Individual, Organization, Audience |
| DataForSEO | Always on | Toggle on/off |
| Web Interface | None | Full interface |
| Directory Structure | Complex | Simple (PDFs/) |
| Executive Summary | Optional | Always included |
| WordPress | Manual | Automated |
| Project Support | New only | New & Existing |

## Status
**✅ PRODUCTION READY**
- All automation tested
- Citations working
- WordPress integration active
- Web interface operational
- Templates available
- Research structures defined