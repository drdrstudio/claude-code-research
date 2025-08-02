# Phase 3: Content Extraction URL Approval List
**Mission:** Pharos Capital Group Deep-Dive Analysis  
**Protocol:** MRP v4.0  
**Status:** PENDING USER APPROVAL

## 🎯 Priority URL List for Deep Content Extraction

### **Tier 1: Critical Sources (Company & Leadership)**
1. **https://www.pharosfunds.com/** - Company homepage and core information
2. **https://www.pharosfunds.com/kneeland-youngblood.php** - CEO profile and background
3. **https://www.pharosfunds.com/bob-crants.php** - CIO profile and background
4. **https://www.pharosfunds.com/our-team.php** - Complete team structure
5. **https://www.pharosfunds.com/portfolio.php** - Portfolio companies listing
6. **https://www.pharosfunds.com/philosophy.php** - Investment philosophy and approach

### **Tier 2: Public Records & Professional Network**
7. **https://en.wikipedia.org/wiki/Kneeland_Youngblood** - Comprehensive public biography
8. **https://www.linkedin.com/company/pharos-capital-group** - Professional network and posts
9. **https://www.cbinsights.com/investor/pharos-capital** - Investment tracking and portfolio data
10. **https://www.legistorm.com/organization/summary/39928/Pharos_Capital_Group_LLC.html** - Lobbying and regulatory information

### **Tier 3: Recent Activity & Media Coverage**
11. **https://www.prnewswire.com/news-releases/pharos-capital-invests-in-renal-care-360-capitalizes-new-chronic-kidney-care-management-platform-301621650.html** - 2022 Renal Care investment announcement
12. **https://www.paragonventures.com/market-pulse-posts/pharos-capital-makes-majority-investment-in-rhythmedix/** - 2024 RhythMedix acquisition details
13. **https://milkeninstitute.org/content-hub/newsletters/future-aging-newsletter/future-aging-springsummer-2025** - Milken Institute panel participation
14. **https://www.ontra.ai/resource/customer-story/pharos-capital-group/** - SEC exam compliance case study

### **Tier 4: Reputation Risk & Community Sentiment**
15. **https://reddit.com/r/DrainTheSwamp/comments/b9lht6/if_vaccine_damage_is_real_who_would_benefit_meet/** - 2019 conspiracy theory post (risk documentation)

### **Tier 5: Legal & Regulatory (Clean Record Verification)**
16. **https://reports.adviserinfo.sec.gov/reports/ADV/316789/PDF/316789.pdf** - SEC Form ADV filing
17. **https://www.forbes.com/sites/jabariyoung/2024/12/19/forbes-blk-50-2024/** - Forbes BLK50 recognition article

## 📋 Extraction Strategy by Tool

### **Firecrawl-MCP + webshare-cli (Mandatory Proxy)**
- Primary extraction tool for all URLs
- Full content analysis and data extraction
- Cache check before fetch

### **Playwright + webshare-cli (Escalation if needed)**
- Backup for complex JavaScript-heavy sites
- Used if Firecrawl-MCP fails

### **Content Focus Areas by URL**
- **URLs 1-6:** Company structure, investment approach, team backgrounds
- **URLs 7-10:** Public records, professional networks, third-party validation
- **URLs 11-14:** Recent investments, media presence, speaking engagements
- **URL 15:** Reputational risk documentation and context
- **URLs 16-17:** Regulatory compliance and recognition verification

## ⚠️ MRP v4.0 Compliance Notes
- **Proxy Requirement:** webshare-cli mandatory for all extractions
- **Cache Management:** Check 30-day cache before fetching
- **Source Attribution:** All extracted content will be URL-attributed
- **Risk Documentation:** Conspiracy theory post requires neutral fact-based extraction

## 🔍 Expected Deliverables from Phase 3
- 15-20 detailed content extractions saved to `02_fetched_content/`
- Structured data extraction for `03_extracted_data/`
- Foundation for Phase 4 analysis and Phase 5 synthesis

---

**APPROVAL REQUIRED:** Proceed with content extraction from these 17 priority URLs using webshare-cli proxy routing?