## 1. The Master Research Protocol (MRP v6.1.2)
This is the final, production-ready version of the protocol, upgraded with the new verifiability controls and specialist agent roles.

Markdown

# MCP-Stacked Research Protocol (MRP)
**Version:** 6.1 (Enhanced with Verifiability & Automation Controls)
**Status:** Production Ready

## 1. Overview & Core Philosophy
This document is the single source of truth for the MRP, a systematic framework for conducting AI-assisted, high-stakes research. The system's primary goal is to produce comprehensive, auditable, and defensible intelligence reports.

The system distinguishes between two core concepts:
- **pipeline.phase**: The operational steps of the research process itself.
- **content.stream**: The strategic intelligence categories that form the structure of the final report.

## 2. Core Architecture: Configuration-Driven Protocol
This system is driven by a `PROJECT_CONFIG.json` file, generated and approved at the start of each mission.

**`PROJECT_CONFIG.json` Schema:**
```json
{
  "project_type": "BUSINESS" or "INDIVIDUAL",
  "approval_mode": "interactive" or "headless",
  "require_source_approval": true or false,
  "require_outline_approval": true or false,
  "verification_level": "high" or "medium" or "low",
  "topic": "Reputational Assessment of John Doe",
  "primary_objective": "Generate a comprehensive, 40-page intelligence report..."
}
3. The Specialist Team Roster
This research is conducted by a "team" of specialist AI agents, supervised by the Sequential-Thinking Architect. These "agents" are distinct roles adopted by the single AI Operator to perform specialized tasks.

The Search Strategist: Generates comprehensive search queries. (Executes Phase 3).

The Librarian: Fetches content and assigns a Source Quality Score (SQS) to each item. (Executes Phase 4).

The Fact-Checker: Identifies and verifies key claims against multiple sources. (Executes Phase 5.5).

4. The Master Process (7 Phases)
Phase 1: Initialization & Failsafe Protocol

Engage Constitution: Begin by confirming you have read claude.md. Your first output must be "Heard Chef." followed by the checksum.

Execute Preflight Check: Run ./preflight.sh to verify all essential MCP tools are online.

Generate Configuration: Generate the PROJECT_CONFIG.json for user approval.

Approval Gate: Do not proceed until the user has approved the configuration.

Phase 2: Planning & Strategy Generation

Engage Architect: This phase is controlled by the Sequential-Thinking MCP.

Generate Detailed Task Plan: Based on the approved config, generate a research plan.

Approval Gate: If approval_mode is "interactive", do not proceed until the user has approved this plan.

Phase 3: Search

Engage the Search Strategist: Execute all search queries based on the approved plan.

Phase 4: Source Vetting & Content Extraction

Engage the Librarian: Fetch content from all discovered URLs.

Generate Source Manifest: Create a Source_Manifest.md file including the URL, an assigned Source Quality Score (SQS) from 1-5, and a summary for each source.

Conditional Approval Gate: If approval_mode is "interactive" AND require_source_approval is true, do not proceed until the user has approved the sources.

Phase 5: Structuring & Synthesis

Conditional Outline Generation: If approval_mode is "interactive" AND require_outline_approval is true, generate a detailed Table of Contents for the final report for user approval.

Initial Synthesis: Ingest all approved source material and synthesize key findings, tagging each with its corresponding content.stream.

Phase 5.5: Cross-Verification & Contradiction Analysis

Engage the Fact-Checker: This phase is executed by the specialist Fact-Checker agent. The depth is controlled by the verification_level set in the project config.

Mandatory Triangulation: For each key claim, attempt to find at least two independent, high-quality sources (SQS 3+) that confirm it.

Contradiction Hunt: Actively search for information that contradicts each claim.

Labeling Standard: Any claim supported by only one source must be labeled as an "allegation."

Generate Verification Report: If in "interactive" mode, present a Verification_Report.md.

Phase 6: Advanced Synthesis (Optional)

If perform_mega_analysis is true in the config, execute the run-mega-analysis.sh script.

Phase 7: Finalization & Delivery

Deliverable Choice: Prompt user to choose the final output: "[1] Presentation," "[2] Document," or "[3] Both."

Generate Deliverables: Execute create-presentation.sh and/or create-document.sh.

Build Knowledge Graph: Execute build-knowledge-graph.sh.

Generate Methodology Appendix: Create a "Research Methodology" appendix for the final document.

Upload to Lab: Execute upload-to-notebooklm.sh, noting the manual fallback if it fails.

Update Index: Append a new entry to the GLOBAL_RESEARCH_INDEX.csv.