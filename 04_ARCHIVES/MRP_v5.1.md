# MCP-Stacked Research Protocol (MRP)
**Version:** 5.1
**Status:** Final, Configuration-Driven
**Last Updated:** Monday, August 4, 2025 at 7:45 AM PDT

## 1. Overview & Core Philosophy
This document is the single source of truth for the MCP-Stacked Research Protocol (MRP). Its philosophy is to combine a structured, multi-phase process with a flexible, configuration-driven approach to tool selection, ensuring all research is comprehensive, auditable, and cost-aware.

## 2. Core Architecture: Configuration-Driven Protocol
This system is driven by a `PROJECT_CONFIG.json` file, which is generated and approved at the start of each mission. This configuration file dictates the scope, tools, optional modules, and final deliverables for the entire workflow.

## 3. The Official MCP Toolkit
The AI is authorized to use the following MCPs. Some tools are project-specific and must be enabled in the `PROJECT_CONFIG.json`.

| Category          | MCP Name              | Role & Key Function           | Proxy Use    | Status       |
| :---------------- | :-------------------- | :---------------------------- | :----------- | :----------- |
| **Orchestration** | `Sequential-Thinking` | The Planner                   | No           | Standard     |
| **Web Search** | `Perplexity-MCP`, `Tavily-MCP` | Search & Synthesis Engines    | Recommended  | Standard     |
| **Web Scraping** | `Firecrawl-MCP`       | Default Fetcher/Scraper       | **Mandatory**| Standard     |
|                   | `Playwright`          | Escalation Fetcher            | **Mandatory**| Standard     |
| **SEO & Data** | `DataForSEO-MCP`      | SEO & Keyword Data            | No           | **Optional** |
| **Social** | `Reddit-MCP`, `LinkedIn-MCP` | Sentiment & Professional Vetting | Varies       | Standard     |
| **Specialized** | `Web3-Research`, `Klaviyo` | Crypto & Email Data           | No           | **Optional** |

## 4. Project Configuration
At the start of each mission, the AI will generate a `PROJECT_CONFIG.json` for user approval.

**Example `PROJECT_CONFIG.json`:**
```json
{
  "profile": "Deep-Dive",
  "topic": "ICP Analysis for Duarte Inc.",
  "use_dataforseo_mcp": true,
  "perform_mega_analysis": true,
  "default_deliverable": "document"
}