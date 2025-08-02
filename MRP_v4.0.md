# MCP-Stacked Research Protocol (MRP)
**Version:** 4.0
**Status:** Final, Comprehensive
**Last Updated:** Saturday, August 2, 2025 at 1:56 AM PDT

## 1. Overview & Core Philosophy
This document is the single source of truth for the MCP-Stacked Research Protocol (MRP), a systematic framework for conducting AI-assisted research. The core philosophy is to combine structured, multi-phase processes with intelligent tool selection and human-in-the-loop oversight. This ensures all research is comprehensive, auditable, repeatable, and cost-aware.

---

## 2. Core Architecture: Unified Protocol
This is a unified system. Instead of multiple protocol files, it uses **Execution Profiles** to tailor the research process for different tasks. The AI will follow the same core 6-phase process, but its tool selection, scope, and final outputs will vary based on the user-selected profile.

---

## 3. The Official MCP Toolkit
The AI is authorized to use only the following MCPs. These names represent the specific wrapper scripts in the environment.

| Category | MCP Name | Role & Key Function | Proxy Use |
| :--- | :--- | :--- | :--- |
| **Orchestration** | `Sequential-Thinking` | **The Planner:** Breaks down complex topics and plans the research phases. | No |
| | `MCP-Compass` | **Tool Discovery:** Recommends which MCP to use for a specific sub-task. | No |
| **Web Search** | `Perplexity-MCP` | **Q&A & Synthesis Engine:** Answers direct questions and synthesizes web search results. | No |
| | `Tavily-MCP` | **Primary Search & Crawl:** Performs deep web searches and extracts content from URLs. | Recommended |
| **Web Scraping** | `Firecrawl-MCP` | **Default Fetcher/Scraper:** Primary tool for scraping standard web pages. | **Mandatory** |
| | `Playwright` | **Escalation Fetcher:** For complex, JavaScript-heavy sites that Firecrawl cannot handle. | **Mandatory** |
| **Social & Ads**| `Reddit-MCP` | **Public Sentiment:** Gathers insights from Reddit communities. | Recommended |
| | `LinkedIn-MCP` | **Professional Backgrounds:** Researches people and company profiles on LinkedIn. | **Mandatory** |
| | `Twitter-MCP` | **Real-time Discourse:** Scans X/Twitter for breaking news and expert opinions. | **Mandatory** |
| | `GoogleAds-MCP` | **Ad Intelligence:** Analyzes ad copy and campaign strategies on Google. | No |
| | `FacebookAds-MCP`| **Ad Intelligence:** Analyzes ad copy and campaign strategies on Facebook. | No |
| **Specialized** | `Web3-Research` | **Crypto & Blockchain:** Fetches prices and on-chain data. | No |
| | `Klaviyo` | **Email Marketing:** Fetches campaign performance and segment data from Klaviyo. | No |

---

## 4. Network & Identity Management (Webshare Proxies)
To ensure reliability and avoid blocks, certain MCPs **MUST** be executed through the residential proxy network.

### 4.1 Webshare-CLI Overview
The `webshare-cli` is a custom command-line tool that provides access to Webshare's residential rotating proxy network. It automatically rotates IP addresses to avoid detection and blocks when scraping websites.

### 4.2 Proxy Usage Commands
**Important:** Webshare-cli is a proxy management tool, NOT a scraper. Use it to configure proxy settings for other tools:

* **Basic Usage:** `webshare-cli proxy-config --endpoint [URL]` - Returns proxy configuration for the endpoint
* **Status Check:** `webshare-cli status` - Checks proxy service availability  
* **Rotate IP:** `webshare-cli rotate` - Forces IP rotation for next request

### 4.3 Integration with MCP Tools
When using MCP tools that support proxy configuration:

* **Firecrawl-MCP:** Configure proxy in environment or tool parameters using webshare-cli output
* **Playwright:** Set proxy configuration in browser launch options using webshare-cli credentials
* **Other tools:** Use webshare-cli to get current proxy endpoint and credentials for manual configuration

### 4.4 Mandatory vs. Recommended Usage
* **Mandatory Use:** The use of proxies via `webshare-cli` is **mandatory** for: `Firecrawl-MCP`, `Playwright`, `LinkedIn-MCP`, and `Twitter-MCP`.
* **Recommended Use:** The use of proxies is **recommended** for: `Tavily-MCP` and `Reddit-MCP`.
* **Fallback Strategy:** If webshare-cli fails or is unavailable, attempt direct connection but document the limitation.

---

---

## 5. Global Infrastructure & Project Structure
All work must adhere to this standardized file structure. Global assets (Cache, Index) live at the top level, while projects are organized into client-specific subdirectories for clean management.

~/Documents/cursor/Claude-Code-Research/
├── CACHE/
├── GLOBAL_RESEARCH_INDEX.csv
├── MRP_PROTOCOL_v4.0.md
└── [CLIENT_NAME]/
└── Research_[PROFILE][TOPIC][YYYYMMDD_HHMMSS]/
├── 00_LOGS/
│   ├── RESEARCH_LOG.md
│   └── search_log.csv
├── 01_searches/
├── 02_fetched_content/
├── 03_extracted_data/
├── 04_analysis/
├── TodoWrite.md
└── FINAL_REPORTS/
└── 00_Executive_Summary.md




---

## 6. Execution Profiles (Formerly Research Types)
The user will initiate a task by specifying one of the following profiles.

* **`Profile: Comprehensive`**: A deep, balanced investigation on any topic. This is the default.
* **`Profile: Quick-Scan`**: A fast, high-level overview. Scope is limited to ~3 searches and ~5 fetches.
* **`Profile: Deep-Dive`**: An exhaustive report using 10+ academic and technical sources via `Perplexity-MCP` and `Tavily-MCP`.
* **`Profile: News-Scan`**: Focuses on recent developments using `Tavily-MCP` with date filters and `Twitter-MCP`.
* **`Profile: GTM-Campaign`**: A Go-To-Market analysis using `Reddit-MCP`, `GoogleAds-MCP`, `FacebookAds-MCP`, and `Klaviyo` to inform strategy.

---

## 7. The Master Process (6 Phases)
All profiles follow this core process.

* **Phase 1: Initialization:** The AI creates the project directory. It then uses `Sequential-Thinking` to analyze the topic and generate a detailed task plan in `TodoWrite.md` for user approval.

* **Phase 2: Search (Approval Gate):** The AI proposes targeted queries using the primary tools for the selected profile (e.g., `Tavily-MCP`, `Perplexity-MCP`, `Reddit-MCP`). User must approve queries.

* **Phase 3: Fetch & Extract with Caching (Approval Gate):** The AI proposes URLs to fetch. After user approval, it executes the fetch:
    1.  **Check Cache:** For each URL, the AI checks for a recent (<30 days) version in the `CACHE/`. If found, it uses the cached version.
    2.  **Fetch on Cache Miss:** If no valid cache exists, it fetches using `Firecrawl-MCP` (routed via `webshare-cli`).
    3.  **Populate Cache:** Upon success, it saves a copy of the result to the `CACHE/` directory.
    4.  **Escalate on Failure:** If `Firecrawl-MCP` fails, the AI announces the reason and re-attempts with `Playwright` (also routed via `webshare-cli`).

* **Phase 4: Analysis & Structuring:** The AI processes fetched content into structured JSON (`key_entities.json`, `timeline.json`) and generates analytical documents.

* **Phase 5: Synthesis:** The AI synthesizes all findings into the final reports, tailored to the profile's goal.

* **Phase 6: Finalization & Indexing:** The AI appends a new entry to the `GLOBAL_RESEARCH_INDEX.csv` with the project's details and a one-sentence summary.

---

## 8. Operational & Meta Commands

* **`MRP-RESUME [PROJECT_NAME]`**: Resumes an incomplete project by reading `RESEARCH_LOG.md` and `TodoWrite.md`.
* **`MRP-DEBRIEF [PROJECT_NAME]`**: After a project, the AI analyzes the `RESEARCH_LOG.md` to identify inefficiencies and propose one improvement to this protocol.

---

## 9. Core Principles & Best Practices
1.  **Follow the Protocol:** Adhere strictly to the phases and procedures defined in this document.
2.  **Structure Data Early:** Prioritize converting raw text into structured JSON.
3.  **Use Approval Gates:** Always await user confirmation for search and fetch phases to control scope and cost.
4.  **Log Everything:** Maintain the `RESEARCH_LOG.md` for a complete audit trail of every action taken.
5.  **Use Proxies as Required:** All designated MCPs must be routed through the `webshare-cli` as specified in Section 4.
6.  **Build Institutional Knowledge:** Leverage the `CACHE` and `GLOBAL_RESEARCH_INDEX.csv` to ensure past work accelerates future efforts.

---

## 10. How to Use This Protocol: The Master Prompt
To initiate any mission, provide the AI with the following prompt. This prompt ensures the AI always reads this document first, guaranteeing compliance with the latest version of the protocol.

```markdown
# MISSION: Execute MRP Research

**1. Load Protocol & Acknowledge:**
You MUST begin by reading the entire contents of the master protocol file located at `~/Documents/cursor/Claude-Code-Research/MRP_PROTOCOL_v4.0.md`. This document contains your complete operating instructions. After reading, confirm that you have understood the rules of MRP v4.0 before proceeding.

**2. Mission Parameters:**
- **Execution Profile:** `[PROFILE_NAME]`
- **Topic:** `[TOPIC]`

**3. Commence Mission:**
Once you have acknowledged the protocol, begin with Phase 1: Initialization. Use `Sequential-Thinking` to generate the plan for my approval.

Acknowledge these orders and await my command.
