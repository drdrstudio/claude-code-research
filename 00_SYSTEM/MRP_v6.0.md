# MCP-Stacked Research Protocol (MRP)
**Version:** 6.0
**Status:** Production Ready, Fully Automated

## 1. Overview
This document is the single source of truth for the MRP, a systematic framework for conducting AI-assisted research. It uses a configuration-driven, multi-phase process to ensure all research is comprehensive, auditable, and cost-aware.

## 2. Core Architecture: Configuration-Driven Protocol
This system is driven by a `PROJECT_CONFIG.json` file, generated and approved at the start of each mission. This file dictates the scope, tools, optional modules, and final deliverables for the entire workflow.

## 3. The Official MCP Toolkit
| Category          | MCP Name              | Role & Key Function           | Proxy Use    | Status       |
| :---------------- | :-------------------- | :---------------------------- | :----------- | :----------- |
| **Orchestration** | `Sequential-Thinking` | The Planner                   | No           | Standard     |
| **Web Search** | `Perplexity-MCP`, `Tavily-MCP` | Search & Synthesis Engines    | Recommended  | Standard     |
| **Web Scraping** | `Firecrawl-MCP`       | Default Fetcher/Scraper       | **Mandatory**| Standard     |
|                   | `Playwright`          | Escalation Fetcher            | **Mandatory**| Standard     |
|                   | `Enhanced-Playwright` | **NEW** Anti-Detection Browser| **Mandatory**| Enhanced     |
| **SEO & Data** | `DataForSEO-MCP`      | SEO & Keyword Data            | No           | **Optional** |
| **Social** | `Reddit-MCP`, `LinkedIn-MCP` | Sentiment & Professional Vetting | Varies       | Standard     |
| **YouTube** | `YouTube-Transcript`, `YouTube-Analysis` | Video Intelligence Extraction | Recommended  | Standard     |

## 4. Project Configuration
At the start of each mission, the AI will generate a `PROJECT_CONFIG.json` for user approval.

**Example `PROJECT_CONFIG.json`:**
```json
{
  "profile": "Deep-Dive",
  "topic": "ICP Analysis for Duarte Inc.",
  "primary_objective": "Identify and deeply analyze core challenges, key needs, and major pain points to inform GTM strategy and sales copywriting.",
  "use_dataforseo_mcp": true,
  "perform_mega_analysis": true,
  "default_deliverable": "document",
  "custom_parameters": {
    "target_roles": ["Marketing Director", "VP Marketing", "CMO"],
    "enterprise_focus": true,
    "include_technology_stack": true,
    "include_decision_making_process": true,
    "geographic_scope": "North America + Europe",
    "company_size_range": "1000+ employees"
  }
}
```

## 5. The Master Process (7 Phases)
1.  **Phase 1: Initialization & Configuration**: Create project directory. Generate a `PROJECT_CONFIG.json`. **User must approve this configuration before proceeding.**

2.  **Phase 2: Planning**: Use `Sequential-Thinking` to generate a detailed task plan.

3.  **Phase 3: Search (Approval Gate)**: Propose targeted queries for **user approval**.

4.  **Phase 4: Fetch (Approval Gate)**: Propose a "Primary List" and "Reserve List" of URLs for **user approval**.

5.  **Phase 5: Structuring & Initial Synthesis**: The Operator will perform two key tasks:
    - Execute `auto-extract-entities.sh` to create the structured JSON files.
    - Synthesize key findings into standard deliverable drafts, including `Sales_Copywriting_Guide.md` and a comprehensive, Marp-ready **`Presentation_Source.md`**.

6.  **Phase 6: Advanced Synthesis (Automated)**: If `perform_mega_analysis` is true, the protocol concludes by automatically running the **`run-mega-analysis.sh`** orchestrator script. This script manages the entire three-stage synthesis by calling the Gemini API to get the blueprints and directing the local Operator to execute them.

7.  **Phase 7: Finalization & Delivery**: Execute the `FINISH AND UPLOAD` protocol.

## 6. Enhanced Anti-Detection Capabilities (NEW in v6.0)

### 6.1 Anti-Detection System Overview
The research system now includes sophisticated anti-detection capabilities to improve scraping success rates and avoid blocks during data extraction phases.

### 6.2 Enhanced Browser Automation
**Script:** `enhanced-playwright-wrapper.js`
**Configuration:** `enhanced-scraping-config.sh`

**Key Features:**
- **Browser Fingerprint Randomization**: Randomizes WebGL renderer, canvas fingerprints, screen resolution
- **Behavioral Simulation**: Human-like mouse movements, scrolling patterns, reading delays
- **Request Timing Control**: Configurable delays (3-8 seconds default) with jitter
- **Session Management**: Automatic session rotation and warmup periods
- **User Agent Cycling**: Realistic browser profiles with matching viewports

**Environment Variables:**
```bash
export SCRAPING_MIN_DELAY=3              # Minimum delay between requests (seconds)
export SCRAPING_MAX_DELAY=8              # Maximum delay between requests (seconds)
export SCRAPING_SESSION_WARMUP=true      # Enable session warmup browsing
export SCRAPING_BEHAVIORAL_SIM=true      # Enable human behavior simulation
export SCRAPING_REQUESTS_PER_SESSION=50  # Max requests per browser session
export PROXY_ROTATION_FREQUENCY=25       # Change proxy every N requests
```

### 6.3 Webshare Proxy Integration
**Status:** ✅ **CONFIGURED AND OPERATIONAL**
- **Available Proxies**: 20M+ residential proxies across 200+ countries
- **US Proxies**: 6.6M available
- **EU Proxies**: 2.7M available  
- **API Key**: Configured in environment (`WEBSHARE_API_KEY`)
- **Rotation**: Automatic proxy switching every 25 requests

### 6.4 Usage in Research Phases

**Phase 3 (Search)**: 
- Light fingerprinting with basic proxy rotation
- Standard request timing for search engines

**Phase 4 (Content Extraction)**:
- Full stealth mode activated
- Enhanced behavioral simulation
- Webshare proxy mandatory for designated tools
- Session management with automatic rotation

**Phase 5+ (Analysis)**:
- Fallback methods if primary scraping fails
- Alternative proxy sources if needed

### 6.5 Success Rate Improvements
**Expected Improvements:**
- **YouTube Transcripts**: 50-200 successful extractions/day (vs 10-20 without proxies)
- **General Web Scraping**: 85-95% success rate (vs 60-70% without anti-detection)
- **Social Media**: Significant improvement in profile/post extraction
- **News Sites**: Better success with paywall and rate-limited sites

### 6.6 Monitoring and Optimization
**Session Health Tracking:**
- Request count per session
- Success/failure rates by target domain
- Proxy performance metrics
- Automatic session rotation triggers

## 7. Future Enhancements
- **Cost Tracking**: Implement a `log-api-cost.sh` script to be called by all MCPs to create a central audit trail of API usage for cost analysis.
- **Cloud Migration**: The system is designed with standard components, making it suitable for future migration to a shared cloud platform (e.g., Google Cloud) for team-wide access.
- **Advanced Detection Evasion**: Integration with cloud browser farms (BrowserStack, LambdaTest)
- **Captcha Solving**: Integration with 2captcha/Anti-Captcha services for automatic solving