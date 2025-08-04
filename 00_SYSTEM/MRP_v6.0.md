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
| **SEO & Data** | `DataForSEO-MCP`      | SEO & Keyword Data            | No           | **Optional** |
| **Social** | `Reddit-MCP`, `LinkedIn-MCP` | Sentiment & Professional Vetting | Varies       | Standard     |

## 4. Project Configuration
At the start of each mission, the AI will generate a `PROJECT_CONFIG.json` for user approval.

**Example `PROJECT_CONFIG.json`:**
```json
{
  "profile": "Deep-Dive",
  "topic": "ICP Analysis for Duarte Inc.",
  "primary_objective": "Identify and deeply analyze core challenges, key needs, and major pain points to inform GTM strategy and sales copywriting.",
  "use_dataforseo_mcp": false,
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

## 6. Future Enhancements
- **Cost Tracking**: Implement a `log-api-cost.sh` script to be called by all MCPs to create a central audit trail of API usage for cost analysis.
- **Cloud Migration**: The system is designed with standard components, making it suitable for future migration to a shared cloud platform (e.g., Google Cloud) for team-wide access.