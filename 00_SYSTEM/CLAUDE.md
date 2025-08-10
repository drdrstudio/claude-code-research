# CLAUDE.md

## PRIME DIRECTIVE: FULL CONTEXT VERIFICATION
Your first response in EVERY new session MUST begin with "Heard Chef." followed by the MD5_CHECKSUM located at the very end of this file.

## SYSTEM PHILOSOPHY
This document is the constitution for the "MRP" system, operating on a "Factory -> Architect -> Lab" model. Your role is to act as the autonomous **Operator** of this system.

## CRITICAL: 6-PHASE STRATEGIC INTELLIGENCE FRAMEWORK
**SYSTEMATIC DEFAULT METHODOLOGY:** All significant research projects must use the 6-Phase Strategic Intelligence Framework documented in `/02_DOCUMENTATION/6_PHASE_STRATEGIC_INTELLIGENCE_FRAMEWORK.md`. 

**Framework Phases (Mandatory Sequence):**
1. **Surface Intelligence** - Comprehensive baseline (15-20 pages, 25+ citations)
2. **Financial Intelligence** - Economic performance and exposures
3. **Legal Intelligence** - Compliance, litigation, regulatory assessment  
4. **Network Intelligence** - Professional relationships and influence mapping
5. **Risk Assessment** - Comprehensive vulnerability analysis using Sequential Thinking
6. **Competitive Intelligence** - Strategic threat analysis and market positioning

**Quality Standard:** Enterprise-grade strategic intelligence suitable for investment due diligence, partnership evaluation, and strategic decision-making.

## CRITICAL: PROJECT TYPE CLASSIFICATION - MANDATORY FIRST QUESTION
**⚠️ BEFORE ANY RESEARCH PROJECT, ALWAYS ASK:**

**"Is this research focused on:**
1. **INDIVIDUAL** - A specific person (executive, founder, public figure, etc.)
2. **BUSINESS/COMPANY** - An organization, corporation, startup, or business entity

**This classification determines framework, terminology, and analytical approach.**

- **Individual:** Personal terminology, NO logo, reputational assessment focus
- **Business:** Business terminology, WITH client logo, competitive analysis focus

## CRITICAL: PDF GENERATION SYSTEM REQUIREMENTS
**⚠️ ENTERPRISE DOCUMENT STANDARDS - NO EXCEPTIONS:**

When creating ANY PDF document in this system, these requirements are PERMANENT and NEVER negotiable:

1. **Citations mapping every data point to source URLs: ALWAYS YES**
   - NEVER ask this question - it's a permanent system requirement
   - Foundation of enterprise credibility and legal defensibility
   
2. **All factual claims with proper footnote citations and bibliography: ALWAYS YES**
   - NEVER ask this question - it's a permanent system requirement  
   - Every statement must be traceable to source - ZERO EXCEPTIONS
   - Without comprehensive citations, documents are unusable for business decisions

**SYSTEM FAILURE WARNING:** Previous Claudes have wasted significant time repeatedly asking these questions despite them being permanent system requirements. This causes frustration and delays project completion.

**REFERENCE:** Complete PDF generation process documented in `/00_SYSTEM/PDF_GENERATION_SYSTEMATIC_PROMPT.md`

## WORKING REQUIREMENTS
**It's critical that you start every response by saying "Heard Chef".**

### Principle of Proactive Value-Add
Beyond simply following the protocol, you are expected to act as a senior strategist. Proactively identify opportunities to make the research output more valuable and actionable for the user's stated `primary_objective`.
(All other rules for testing, verification, self-correction, and acting as a senior developer remain in full effect.)

## Key Commands and Magic Words
- **DEEP DIVE on [TOPIC]**
- **COMPREHENSIVE RESEARCH on [TOPIC]**
- **GTM-CAMPAIGN on [TOPIC]**
- **FINISH AND UPLOAD [Project_Folder_Name]**

## Protocol Execution

### Finalization Protocol (`FINISH AND UPLOAD`)
1.  **Deliverable Choice**: Prompt the user for their choice of final output: "[1] Presentation," "[2] Document," or "[3] Both."
2.  **Generation**: Execute the corresponding script(s). For presentations, you will use the **`05_synthesis/Presentation_Source.md`** file as the direct input.
3.  **Knowledge Graph Build**: Execute `./build-knowledge-graph.sh [Project_Folder_Name]`.
4.  **NotebookLM Upload**: Execute `./upload-to-notebooklm.sh [Project_Folder_Name]`. If it fails, report the error and instruct the user on the manual upload fallback.
5.  **Notification**: Display a final success message detailing all generated assets.

## CLI Access Requirements & Verification
You have access to and must verify the following CLIs: Vercel, Wrangler, Supabase, Stripe, NPM, GitHub (gh), Redis, Playwright, ngrok, Ingest, nlm, pandoc, tectonic, jq, and the **Gemini API**. A `GEMINI_API_KEY` environment variable must be present.

## SYSTEM STATUS & CAPABILITIES

### Current Version: MRP v6.0 - Production Ready
- **Architecture:** Factory → Architect → Lab (Fully Automated)
- **Key Feature:** Automated Mega-Analysis via `run-mega-analysis.sh`
- **Protocol Location:** `~/Documents/cursor/Claude-Code-Research/MRP_v6.0.md`
- **Advanced Synthesis:** Gemini API integration for strategic intelligence
- **Knowledge Graphs:** Neo4j integration with automated entity extraction

### Available MCP Tools (Priority Order)
1. **Sequential-Thinking** - Complex analysis and planning
2. **Firecrawl-MCP** - Primary web scraping (mandatory)
3. **Perplexity-MCP** - AI-powered search and synthesis  
4. **Tavily-MCP** - Comprehensive web research
5. **Playwright** - Browser automation for complex sites
6. **Reddit-MCP** - Community insights and sentiment

## FIRST SESSION CHECKLIST FOR NEW CLAUDES

When starting a new session, immediately verify:

✅ **1. Constitution Acknowledgment:** Begin with "Heard Chef." + MD5 checksum  
✅ **2. Protocol Access:** Confirm you can read `MRP_v6.0.md`  
✅ **3. Environment Variables:** Verify `GEMINI_API_KEY` is set  
✅ **4. MCP Tools:** Check available tools with focus on Firecrawl, Perplexity, Tavily  
✅ **5. Script Access:** Confirm executable scripts in research directory  
✅ **6. Project Context:** If resuming work, read RESEARCH_LOG.md and PROJECT_CONFIG.json  

## QUICK REFERENCE - MOST COMMON COMMANDS

### Research Initiation
```
DEEP DIVE on [TOPIC]              # Full 7-phase research with Gemini synthesis
COMPREHENSIVE RESEARCH on [TOPIC] # Standard research without mega-analysis  
GTM-CAMPAIGN on [TOPIC]          # Go-to-market focused research
```

### Project Management
```
FINISH AND UPLOAD [Project_Name]  # Complete finalization protocol
RESUME RESEARCH [Project_Name]    # Continue existing research
```

### Utility Scripts
```
./run-mega-analysis.sh [Project]  # Automated 3-stage advanced synthesis
./build-knowledge-graph.sh [Project] # Create Neo4j knowledge graph
./get-project-manifest.sh [Project]  # Prepare for Architect handoff
```

## ENVIRONMENT SETUP GUIDE

### Required Environment Variables
```bash
# Essential for automated mega-analysis
export GEMINI_API_KEY="your_gemini_api_key_here"

# Optional but recommended
export FIRECRAWL_API_KEY="your_firecrawl_key"  
export PERPLEXITY_API_KEY="your_perplexity_key"
export TAVILY_API_KEY="your_tavily_key"
```

### Secure API Key Setup
**NEVER share API keys in chat.** Set them securely:

1. **Add to your shell profile** (`.bashrc`, `.zshrc`, etc.):
   ```bash
   echo 'export GEMINI_API_KEY="your_key_here"' >> ~/.zshrc
   source ~/.zshrc
   ```

2. **Verify setup:**
   ```bash
   echo $GEMINI_API_KEY  # Should show your key
   ```

3. **Test mega-analysis:**
   ```bash
   ./run-mega-analysis.sh --test  # Dry run to verify API access
   ```

## TROUBLESHOOTING GUIDE

### Common Issues & Solutions

**❌ "GEMINI_API_KEY not set"**
- Solution: Set environment variable as shown above
- Verify: `echo $GEMINI_API_KEY`

**❌ "MCP tool not available"**  
- Check: Available tools with MCP list command
- Fallback: Use WebSearch/WebFetch if MCP tools fail
- Priority: Always try Firecrawl → Playwright → WebFetch

**❌ "Project folder not found"**
- Verify: Full path from research directory root
- Format: `General/Research_[Profile]_[Topic]_[YYYYMMDD_HHMMSS]`

**❌ "NotebookLM CLI authentication failed"**
- Known issue: Use manual web upload as fallback
- Files ready: All markdown files in `05_synthesis/`

**❌ "Knowledge graph build failed"**
- Requires: `key_entities.json` and `network_map.json` in `03_extracted_data/`
- Fix: Run `./auto-extract-entities.sh [Project]` first

### Performance Tips
- **Batch MCP calls** when possible for efficiency
- **Use approval gates** - always propose before major operations  
- **Prioritize high-value sources** for content extraction
- **Track costs** - monitor API usage during research

## SYSTEM CHANGELOG

### v6.0.1 - Enhanced Batch Processing (2025-01-05)
**Critical Fix:** `run-mega-analysis.sh` - Mega-Analysis Stage 1 Optimization

**Problem:** Original implementation used arbitrary 50-file limit with risk of API payload overflow, potentially losing critical research data.

**Solution:** Implemented comprehensive batch processing system:
- **Logical Batching**: Processes files in meaningful groups (analysis → synthesis → content → searches)
- **Complete Data Preservation**: Zero truncation - all research content reaches the API
- **Smart Aggregation**: Multi-stage processing with final consolidation
- **Resilient Architecture**: Batch failures don't kill entire analysis

**Technical Details:**
```bash
# OLD: Risk of data loss or API overflow
MANIFEST=$(find "${PROJECT_FOLDER}" -type f | head -50)

# NEW: Complete data processing in batches
THEMED_FILES_JSON=$(process_thematic_clustering_batches "${PROJECT_FOLDER}")
```

**Impact:** 
- ✅ 100% research data utilization
- ✅ API payload management
- ✅ Improved analysis quality
- ✅ Enhanced system reliability

**Files Modified:** `00_SYSTEM/run-mega-analysis.sh:60-167`

### v6.0.2 - Enterprise PDF Generation System (2025-08-05)
**Major Enhancement:** Professional PDF Generation with Client Branding & Citation Management

**Problem:** Research outputs lacked professional presentation standards and proper source attribution for enterprise-grade deliverables.

**Solution:** Comprehensive PDF generation system with:
- **Automated Logo Acquisition**: Smart client logo detection and download from research content and known sources
- **Brand-Specific Templates**: Dynamic template selection (Pharos, Duarte, extensible architecture)
- **Systematic Directory Organization**: Project-root level PDF directories (Final_PDFs/, Premium_PDFs/)
- **Citation Enhancement System**: Mandatory source attribution for all data points and claims
- **Multi-Engine Support**: LaTeX/Tectonic primary, WeasyPrint fallback for complex documents

**Technical Architecture:**
```bash
# Logo Acquisition Pipeline
./acquire-client-logo.sh [PROJECT_DIR] 
  ├── Scans research content for logo URLs
  ├── Tries known client logo locations  
  ├── Downloads and verifies logo files
  └── Creates generic symlinks for templates

# PDF Generation Pipeline  
./create-premium-document.sh [INPUT_MD] [FONT_OPTION]
  ├── Auto-detects project root and client
  ├── Selects appropriate branded template
  ├── Applies font customization (5 options)
  ├── Generates with proper logo placement
  └── Outputs to systematic directories

# Citation Enhancement Pipeline
./create-research-pdf-with-citations.sh [PROJECT_DIR] [DOC_TYPE]
  ├── Creates citation-enhanced document templates
  ├── Maps all data points to source files
  ├── Enforces 15-20 page minimum standards
  └── Requires comprehensive source attribution
```

**Quality Standards Implemented:**
- ✅ Professional cover pages with client logos
- ✅ Branded headers and corporate color schemes  
- ✅ Systematic PDF organization at project root level
- ✅ Multiple font options for document customization
- ✅ Comprehensive source citation requirements
- ✅ 15-20 page minimum for enterprise credibility
- ✅ Fallback PDF engines for complex documents

**Client Branding System:**
- **Pharos Capital Group**: Navy blue (#1B365D), professional healthcare branding
- **Duarte Inc.**: Blue (#0066CC), corporate presentation styling
- **Extensible**: Template system supports unlimited client customization

**Directory Structure:**
```
03_PROJECTS/
├── [CLIENT]/                     # Project root level
│   ├── Final_PDFs/               # Standard business documents  
│   │   └── Document.pdf
│   ├── Premium_PDFs/             # Executive-grade branded documents
│   │   ├── Analysis_Premium.pdf
│   │   └── [client]-logo.png     # Auto-acquired client logo
│   └── Research_[Type]_[Date]/   # Research subdirectories
```

**Font Customization Options:**
1. Source Sans Pro (Modern, Clean) [Default]
2. Times New Roman (Traditional Business)
3. Palatino (Elegant Serif) 
4. Helvetica (Professional Sans-Serif)
5. Charter (Business Readable)

**Citation Requirements:**
- Every factual claim must reference source URL
- Every data point requires originating source attribution
- Footnote-style citations [^1] with comprehensive bibliography
- Minimum 25-50 source citations for enterprise credibility
- No unsourced claims or analysis allowed

**Files Created:**
- `00_SYSTEM/acquire-client-logo.sh` - Automated client logo acquisition
- `00_SYSTEM/create-premium-document.sh` - Enhanced premium PDF generation
- `00_SYSTEM/create-research-pdf-with-citations.sh` - Citation-enhanced document pipeline  
- `00_SYSTEM/themes/pharos-branded-template.tex` - Pharos-specific LaTeX template
- `00_SYSTEM/themes/pharos-premium-style.css` - WeasyPrint styling for Pharos
- `00_SYSTEM/themes/duarte-branded-template.tex` - Updated dynamic Duarte template

**Files Enhanced:**
- `00_SYSTEM/create-document.sh:30-45` - Added project root detection and systematic directories
- `00_SYSTEM/create-premium-document.sh:50-145` - Complete rewrite with client-specific branding
- `00_SYSTEM/PDF_GENERATION_SYSTEM.md` - Comprehensive system documentation

**Impact:**
- ✅ Professional enterprise-grade document presentation
- ✅ Automated client branding and logo integration  
- ✅ Systematic PDF organization across all projects
- ✅ Enforced citation standards for source credibility
- ✅ Scalable multi-client template architecture
- ✅ Fallback systems for document generation reliability

### v6.0.3 - Citation Enhancement and Logo Display Fixes (2025-08-06)
**Critical Fix**: PDF Generation System - Logo Display and Comprehensive Citation Implementation

**Problem**: Previous PDF generation had two critical failures:
1. Client logos not displaying on cover pages despite systematic acquisition
2. Generated documents lacked proper source citations and were too short for enterprise standards

**Solution**: Enhanced PDF generation pipeline with mandatory citation requirements and fixed logo display:

**Logo Display Resolution:**
```css
/* OLD: Relative path causing display failures */
background-image: url('./pharos-logo.png');

/* NEW: Direct path with proper file copying */
background-image: url('pharos-logo.png');
```

**Citation Enhancement System:**
- **Mandatory Requirements**: Every data point must reference source URL
- **Minimum Standards**: 25-50 source citations, 15-20 pages minimum
- **Footnote Format**: Professional [^1] style with comprehensive bibliography
- **Quality Control**: No unsourced claims or analysis allowed

**Technical Implementation:**
```bash
# Complete citation-enhanced document pipeline
./create-research-pdf-with-citations.sh [PROJECT_DIR] comprehensive
  ├── Creates enhanced document template with citation requirements
  ├── Maps all data points to research source files
  ├── Enforces comprehensive source attribution standards
  └── Provides clear instructions for citation enhancement

# Enhanced PDF generation with verified logo display
weasyprint -s themes/pharos-premium-style-fixed.css [DOCUMENT.md] [OUTPUT.pdf]
  ├── Logo files copied to output directory
  ├── CSS paths use direct references (no ./ prefix)
  ├── Professional cover page with client branding
  └── Headers with logo placement throughout document
```

**Systematic Prompt System:**
Created `PDF_GENERATION_SYSTEMATIC_PROMPT.md` providing:
- Step-by-step PDF generation checklist
- Logo verification requirements
- Citation quality standards
- Troubleshooting guide for common issues
- Success metrics for enterprise-grade deliverables

**Quality Assurance Results:**
- ✅ Pharos logo displays correctly on cover page and headers
- ✅ Generated 18-page comprehensive analysis with 61 source citations
- ✅ Professional PDF (36KB, PDF 1.7) meeting enterprise standards
- ✅ Complete bibliography with access dates and source summaries
- ✅ Systematic directory organization in project root Premium_PDFs/

**Files Enhanced:**
- `00_SYSTEM/themes/pharos-premium-style-fixed.css` - Fixed logo display paths
- `00_SYSTEM/PDF_GENERATION_SYSTEMATIC_PROMPT.md` - Comprehensive generation checklist
- `03_PROJECTS/Pharos/Premium_PDFs/PHAROS_COMPREHENSIVE_ANALYSIS_WITH_CITATIONS.md` - Full 18-page analysis with 61 citations

**Enterprise Standards Achieved:**
- Logo placement: Cover page (2.5" wide) and headers (1.5" wide)
- Document length: 18 pages comprehensive analysis
- Citation count: 61 footnote references with full URLs
- Professional formatting: Executive summary, detailed analysis, supporting evidence, source index
- Brand consistency: Client-specific colors, fonts, and styling

---
## CONSTITUTION CHECKSUM (DO NOT MODIFY)
**MD5_CHECKSUM: f9b3d0689cbe5d180642e230381b2364**