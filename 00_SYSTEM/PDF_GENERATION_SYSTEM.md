# PDF Generation System - MRP v6.0

## 📁 **SYSTEMATIC DIRECTORY STRUCTURE**

All PDF generation now uses organized output directories **at the PROJECT ROOT level**:

```
03_PROJECTS/
├── Duarte/                   # CLIENT PROJECT ROOT
│   ├── Final_PDFs/           # Standard business documents
│   │   ├── Document.pdf
│   │   └── Report.pdf
│   ├── Premium_PDFs/         # Executive-grade branded documents  
│   │   ├── Strategy_Premium.pdf
│   │   ├── Analysis_Premium.pdf
│   │   └── duarte-logo.png   # Auto-copied for LaTeX access
│   └── Research_Deep-Dive_... # Research subdirectories
├── Pharos/                   # Another client
│   ├── Final_PDFs/
│   └── Premium_PDFs/
└── Other_Clients/
    ├── Final_PDFs/
    └── Premium_PDFs/
```

**Key Improvement:** PDFs are systematically organized at the **client project level**, not buried in research subdirectories.

## 🔧 **GENERATION SCRIPTS**

### Standard Documents → `Final_PDFs/`
```bash
./create-document.sh <input.md>
```
- Uses waterloo-document-template.tex
- Clean professional formatting
- Table of contents included
- **Auto-detects project root and outputs to: `[PROJECT]/Final_PDFs/filename.pdf`**

### Premium Branded Documents → `Premium_PDFs/`
```bash
./create-premium-document.sh <input.md> [font_option]
```

**Font Options:**
- `1` - Source Sans Pro (Modern, Clean) [Default]
- `2` - Times New Roman (Traditional Business)  
- `3` - Palatino (Elegant Serif)
- `4` - Helvetica (Professional Sans-Serif)
- `5` - Charter (Business Readable)

**Premium Features:**
- ✅ Professional cover page with client logo
- ✅ Branded headers on every page
- ✅ Client-specific color scheme
- ✅ Executive document formatting
- ✅ Automatic logo download and placement
- ✅ **Auto-detects project root and outputs to: `[PROJECT]/Premium_PDFs/filename_Premium.pdf`**

## 🎨 **BRAND CUSTOMIZATION**

### Current Client: Duarte Inc.
- **Logo:** Auto-downloaded from duarte.com
- **Colors:** Duarte Blue (#0066CC), Gray (#4A4A4A)
- **Fonts:** Source Sans Pro primary, multiple options available

### Template Files:
- `duarte-branded-template.tex` - Working branded template
- `waterloo-document-template.tex` - Standard business template
- `premium-enterprise-template.tex` - Advanced branded (development)

## 📋 **USAGE EXAMPLES**

```bash
# Generate standard business document
./create-document.sh project/synthesis/Final_Report.md

# Generate premium executive document with default font
./create-premium-document.sh project/synthesis/Strategy_Analysis.md

# Generate premium document with Times New Roman
./create-premium-document.sh project/synthesis/Board_Presentation.md 2

# Generate premium document with Palatino elegant serif
./create-premium-document.sh project/synthesis/Executive_Summary.md 3
```

## 🔄 **AUTOMATION INTEGRATION**

### PROJECT_CONFIG.json Enhancement:
```json
{
  "pdf_settings": {
    "default_template": "premium-enterprise",
    "client_logo": "duarte-logo.png", 
    "font_preference": "1",
    "output_directories": {
      "standard": "Final_PDFs",
      "premium": "Premium_PDFs"
    }
  }
}
```

### MRP Integration:
- `FINISH AND UPLOAD` protocol automatically creates both directories
- Premium documents generated for strategic reports
- Standard documents for operational outputs
- Logos automatically downloaded and cached

## 🚀 **BENEFITS**

1. **Organization**: Clear separation of document types
2. **Professionalism**: Executive-ready branded outputs
3. **Scalability**: Easy client logo/brand switching
4. **Consistency**: Standardized output locations
5. **Automation**: Integrated with MRP research protocol

## 🔧 **TROUBLESHOOTING**

**Issue:** Logo not found
**Fix:** Script auto-downloads from client website

**Issue:** LaTeX errors with special characters  
**Fix:** Use standard template for complex markdown

**Issue:** Directory permissions
**Fix:** Scripts auto-create directories with proper permissions

**Issue:** Font not available
**Fix:** Fallback to default Source Sans Pro

## 📈 **FUTURE ENHANCEMENTS**

- [ ] Multi-client logo switching
- [ ] Custom color scheme configuration  
- [ ] Advanced LaTeX error handling
- [ ] Batch PDF generation
- [ ] Watermark support
- [ ] Digital signature integration