# SYSTEMATIC PDF GENERATION PROMPT

## CRITICAL INSTRUCTIONS FOR CLAUDE

When research is complete and it's time to create a premium PDF, follow this systematic process:

### PRE-PDF GENERATION CHECKLIST

1. **LOGO VERIFICATION**: Before PDF creation, ALWAYS verify client logo exists and displays correctly
   - Check logo file exists in Premium_PDFs directory
   - Verify logo file is accessible with correct permissions
   - Test logo display in CSS/LaTeX templates
   - If logo missing, run `./acquire-client-logo.sh [PROJECT_DIR]`

2. **CITATION ENHANCEMENT**: Transform source document with comprehensive citations
   - **MANDATORY**: Every data point must reference source URL
   - **FORMAT**: Use footnote-style citations [^1], [^2], etc.
   - **MINIMUM**: 25-50 source citations for enterprise credibility
   - **STRUCTURE**: Complete bibliography with access dates and summaries

3. **DOCUMENT LENGTH VERIFICATION**: 
   - **MINIMUM**: 15-20 pages for comprehensive analysis
   - **EXECUTIVE SUMMARY**: 2-3 pages with key citations
   - **DETAILED ANALYSIS**: 10-15 pages with comprehensive sourcing
   - **APPENDIX**: Supporting evidence and complete source index

### SYSTEMATIC PDF GENERATION PROCESS

#### STEP 1: Document Enhancement with Citations
```bash
# Run citation enhancement system
./create-research-pdf-with-citations.sh [PROJECT_DIR] comprehensive

# This creates an enhanced template requiring:
# - Comprehensive source mapping
# - Footnote citations for every claim
# - Bibliography with all URLs
# - 15-20 page minimum content
```

#### STEP 2: Logo Acquisition and Verification  
```bash
# Acquire and verify client logo
./acquire-client-logo.sh [PROJECT_DIR]

# Verify logo placement in templates:
# - CSS: url('./client-logo.png') paths
# - LaTeX: \includegraphics{client-logo.png} 
# - File permissions: readable by PDF generation process
```

#### STEP 3: Premium PDF Generation
```bash
# Generate premium branded PDF
./create-premium-document.sh [ENHANCED_DOCUMENT.md] [FONT_OPTION]

# Font options:
# 1 = Source Sans Pro (Modern, Clean) [Default]
# 2 = Times New Roman (Traditional Business) 
# 3 = Palatino (Elegant Serif)
# 4 = Helvetica (Professional Sans-Serif)
# 5 = Charter (Business Readable)
```

### QUALITY ASSURANCE REQUIREMENTS

#### Logo Display Verification:
- [ ] Logo appears on cover page (centered, 2.5-3 inches wide)
- [ ] Logo appears in page headers (top-left, 1.5 inches wide)
- [ ] Logo file copied to PDF output directory
- [ ] CSS/LaTeX paths use correct relative references

#### Citation Quality Standards:
- [ ] Minimum 25 footnote citations throughout document
- [ ] Every factual claim references source URL
- [ ] Complete bibliography with access dates
- [ ] No unsourced analysis or data points

#### Document Structure Requirements:
- [ ] Professional cover page with client logo
- [ ] Executive summary (2-3 pages)
- [ ] Detailed analysis (10-15 pages)  
- [ ] Supporting evidence appendix
- [ ] Complete source index
- [ ] Total length: 15-20 pages minimum

### TROUBLESHOOTING GUIDE

#### Logo Not Displaying:
1. **Verify file exists**: `ls -la Premium_PDFs/*logo*`
2. **Check permissions**: `chmod 644 Premium_PDFs/*logo*`
3. **Fix CSS paths**: Ensure `./client-logo.png` relative references
4. **Reacquire logo**: `./acquire-client-logo.sh [PROJECT_DIR]`

#### Document Too Short:
1. **Add more analysis**: Expand each section with supporting evidence
2. **Include appendices**: Add relevant excerpts from research sources
3. **Enhance bibliography**: Detailed source summaries and context
4. **Cross-reference data**: Link claims across multiple sources

#### Missing Citations:
1. **Map data points**: Identify every fact, number, date, name
2. **Add footnotes**: [^1], [^2] format throughout text
3. **Create bibliography**: Full URL list with access information
4. **Verify completeness**: No unsourced claims allowed

### CLIENT-SPECIFIC TEMPLATES

#### Pharos Capital Group:
- **Colors**: Navy blue (#1B365D), professional healthcare
- **Logo**: https://pharosfunds.com/assets/images/Pharos-Capital-Group-logo.png
- **Style**: Conservative, data-driven, executive presentation

#### Duarte Inc:
- **Colors**: Blue (#0066CC), corporate presentation
- **Logo**: Multiple options from duarte.com/assets/
- **Style**: Creative, visual, storytelling approach

### SUCCESS METRICS

A successfully generated PDF must have:
- ✅ Client logo prominently displayed on cover and headers
- ✅ 15-20 pages of comprehensive analysis
- ✅ 25-50 source citations with proper formatting
- ✅ Professional brand-consistent styling
- ✅ Complete bibliography with all research sources
- ✅ Executive summary suitable for C-level review

### FINAL VERIFICATION COMMAND

Before delivering PDF to user:
```bash
# Verify PDF quality
echo "PDF Quality Check:"
echo "- Page count: $(pdfinfo Premium_PDFs/*.pdf | grep Pages)"  
echo "- File size: $(ls -lh Premium_PDFs/*.pdf | awk '{print $5}')"
echo "- Logo files: $(ls Premium_PDFs/*logo* 2>/dev/null || echo 'MISSING')"

# Open PDF for visual verification
open Premium_PDFs/*.pdf
```

---

**CRITICAL REMINDER**: Never generate a PDF without first ensuring comprehensive citations and proper logo display. These are non-negotiable enterprise standards.