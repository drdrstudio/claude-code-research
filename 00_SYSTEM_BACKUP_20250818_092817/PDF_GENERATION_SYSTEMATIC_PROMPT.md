# SYSTEMATIC PDF GENERATION PROMPT

## CRITICAL INSTRUCTIONS FOR CLAUDE

When research is complete and it's time to create a premium PDF, follow this systematic process:

### MANDATORY PRE-PDF GENERATION QUESTIONS

**CRITICAL**: Before any PDF generation, Claude MUST ask these systematic questions:

#### CRITICAL PROJECT TYPE CLASSIFICATION (FIRST QUESTION):

**"Is this research focused on:**
1. **INDIVIDUAL** - A specific person (executive, founder, public figure, etc.)
2. **BUSINESS/COMPANY** - An organization, corporation, startup, or business entity

**This classification determines the entire framework, terminology, and analytical approach."**

**FRAMEWORK SELECTION:**
- **Individual:** Use `individual-assessment-template.html` - NO logo, personal terminology
- **Business:** Use `business-analysis-template.html` - WITH client logo, business terminology

#### SYSTEM STANDARD QUESTIONS (MANDATORY):

**CRITICAL: Questions 1 and 2 are ALWAYS YES - NEVER ASK THESE QUESTIONS:**

**⚠️ SYSTEM FAILURE WARNING: Previous Claudes wasted significant time asking these questions repeatedly despite them being permanent system requirements. DO NOT REPEAT THIS MISTAKE.**

1. **Citations mapping every data point to source URLs: ALWAYS YES**
   - This is PERMANENT system requirement - never optional, never ask
   - **CRITICAL**: This is the foundation of enterprise credibility and legal defensibility

2. **All factual claims with proper footnote citations and bibliography: ALWAYS YES** 
   - This is PERMANENT system requirement - never optional, never ask  
   - **CRITICAL**: Every statement must be traceable to source - ZERO EXCEPTIONS
   - **ENTERPRISE STANDARD**: Without comprehensive citations, documents are unusable for business decisions

3. **Font Selection:** 
   - 1 = Source Sans Pro (Modern, Clean) [Default]
   - 2 = Times New Roman (Traditional Business)
   - 3 = Palatino (Elegant Serif)
   - 4 = Helvetica (Professional Sans-Serif)
   - 5 = Charter (Business Readable)

4. **Executive vs Standard Format:**
   - Executive: C-level summary focus
   - Standard: Comprehensive analysis format [Default]

#### SYSTEM EXECUTION REQUIREMENTS (NON-NEGOTIABLE):

1. **LOGO VERIFICATION**: Before PDF creation, ALWAYS verify client logo exists and displays correctly
   - Check logo file exists in Premium_PDFs directory
   - Verify logo file is accessible with correct permissions
   - Test logo display in CSS/LaTeX templates
   - If logo missing, run `./acquire-client-logo.sh [PROJECT_DIR]`

2. **CITATION ENHANCEMENT**: Transform source document with comprehensive citations
   - **MANDATORY**: Every data point must reference source URL
   - **FORMAT**: Use footnote-style citations [^1], [^2], etc.
   - **MINIMUM**: 25-50 source citations for enterprise credibility
   - **MAXIMUM INCLUSION**: ALL relevant research data must be included - OMIT NOTHING
   - **COMPREHENSIVE SOURCING**: CITE EVERYTHING with full source URLs and access dates
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
1. **Map data points**: Identify every fact, number, date, name, quote, analysis
2. **Add footnotes**: [^1], [^2] format throughout text for EVERYTHING
3. **Create bibliography**: Full URL list with access information
4. **Verify completeness**: No unsourced claims allowed - ZERO EXCEPTIONS
5. **Include ALL research**: Every relevant piece of data from research files must be included
6. **Omit nothing**: If research data exists, it must be in the document with citations

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
- ✅ ALL RELEVANT RESEARCH DATA INCLUDED - ZERO OMISSIONS
- ✅ EVERY FACT, DATE, NAME, QUOTE, ANALYSIS CITED WITH SOURCE URL
- ✅ COMPREHENSIVE DATA ACCOUNTABILITY - NO EXCEPTIONS

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

## CRITICAL SYSTEM REQUIREMENTS - NO EXCEPTIONS

**MANDATORY STANDARDS FOR ALL PDF GENERATION:**

1. **INCLUDE ALL RELEVANT RESEARCH DATA** - If research data exists in project files, it MUST be included in the document
2. **CITE EVERYTHING** - Every fact, date, name, quote, analysis, and data point must have source URL citation
3. **OMIT NOTHING RELEVANT** - No research data can be excluded from comprehensive documents
4. **COMPREHENSIVE SOURCE ACCOUNTABILITY** - Every piece of information must be traceable to source
5. **ZERO UNSOURCED CLAIMS** - No statements allowed without proper footnote citations

**NEVER generate a PDF without ensuring:**
- ✅ All research files have been reviewed for relevant data
- ✅ All relevant data has been included in the document
- ✅ Every data point has been cited with source URL
- ✅ Complete bibliography with all sources listed
- ✅ Document meets 15-20 page comprehensive standard