# PROJECT TYPE CLASSIFICATION SYSTEM - CRITICAL PRE-QUESTION

## MANDATORY PROJECT TYPE DETERMINATION

**⚠️ CRITICAL: Before starting ANY research project, Claude MUST ask this fundamental classification question:**

---

### **PRIMARY CLASSIFICATION QUESTION (MANDATORY):**

**"Is this research focused on:**
1. **INDIVIDUAL** - A specific person (executive, founder, public figure, etc.)
2. **BUSINESS/COMPANY** - An organization, corporation, startup, or business entity

**This classification determines the entire framework, terminology, and analytical approach for the research."**

---

## FRAMEWORK SELECTION BASED ON CLASSIFICATION

### **INDIVIDUAL RESEARCH FRAMEWORK:**
- **Document Type:** Individual Reputational Assessment
- **Template:** `individual-assessment-template.html`
- **Section Headings:**
  1. Personal Background and Professional Foundation
  2. Professional Achievements and Leadership  
  3. Public Service and Civic Involvement
  4. Professional Networks and Influence
  5. Reputational Risk Assessment
  6. Overall Standing and Future Outlook

- **Terminology Guidelines:**
  - ✅ "Professional Distinction" (not "Competitive Advantage")
  - ✅ "Professional Strengths" (not "Competitive Strengths") 
  - ✅ "Potential Limitations" (not "Strategic Vulnerabilities")
  - ✅ "Individual Standing Assessment" (not "Strategic Positioning")
  - ✅ "Reputational Risk Assessment" (not "Risk Assessment")
  - ✅ "Future Opportunities" (not "Strategic Opportunities")

### **BUSINESS/COMPANY RESEARCH FRAMEWORK:**
- **Document Type:** Strategic Business Intelligence Analysis
- **Template:** `business-analysis-template.html` 
- **Section Headings:**
  1. Phase 1: Surface Intelligence - Comprehensive Baseline Analysis
  2. Phase 2: Financial Intelligence - Performance Analysis
  3. Phase 3: Legal and Regulatory Intelligence
  4. Phase 4: Network Intelligence - Stakeholder Analysis
  5. Phase 5: Risk Assessment - Comprehensive Analysis
  6. Phase 6: Competitive Intelligence - Strategic Market Position

- **Terminology Guidelines:**
  - ✅ "Competitive Advantage" 
  - ✅ "Strategic Positioning Assessment"
  - ✅ "Competitive Strengths"
  - ✅ "Strategic Vulnerabilities"
  - ✅ "Market Position and Differentiation"
  - ✅ "Investment Thesis and Value Creation"

---

## IMPLEMENTATION REQUIREMENTS

### **FOR INDIVIDUAL ASSESSMENTS:**
- **NO CLIENT LOGO** on cover page (individual entity assessment)
- **Personal-focused language** throughout document
- **Reputational emphasis** rather than business metrics
- **Professional standing** rather than market position
- **Civic involvement** and public service sections
- **Personal risk factors** rather than business risks

### **FOR BUSINESS ASSESSMENTS:**
- **CLIENT LOGO REQUIRED** on cover page and headers
- **Business-focused terminology** throughout
- **Market positioning** and competitive analysis
- **Financial performance metrics** and investment thesis
- **Strategic partnerships** and stakeholder analysis
- **Operational and market risk assessment**

---

## CRITICAL SYSTEM FAILURE WARNING

**⚠️ PREVIOUS MISTAKE TO AVOID:**

Using business terminology for individual assessments creates confusion and inappropriate framing. Terms like "Competitive Advantage," "Strategic Positioning," and "Market Position" are incorrect when analyzing a person's reputational standing.

**EXAMPLE FAILURE:**
- ❌ "Dr. Smith's competitive advantage in the healthcare sector..."
- ✅ "Dr. Smith's professional distinction in the healthcare sector..."

---

## TEMPLATE LOCATIONS

- **Individual Template:** `/00_SYSTEM/themes/individual-assessment-template.html`
- **Business Template:** `/00_SYSTEM/themes/business-analysis-template.html`

## INTEGRATION WITH EXISTING SYSTEMS

This classification question must be asked BEFORE:
- PDF generation (determines logo inclusion)
- Document structure creation
- Research methodology selection
- Final report formatting

**UPDATE REQUIRED:** Add this question to all relevant system prompts including:
- `PDF_GENERATION_SYSTEMATIC_PROMPT.md`
- `CLAUDE.md` constitution
- Research initiation protocols
- Project setup procedures

---

## SUCCESS METRICS

A properly classified project will have:
- ✅ Appropriate terminology throughout the document
- ✅ Correct section headings for the subject type
- ✅ Proper visual formatting (logo/no logo)
- ✅ Relevant analytical framework
- ✅ Consistent language that matches the subject type

**NEVER mix individual and business terminology within the same document.**