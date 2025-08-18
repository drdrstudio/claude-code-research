MCP-Stacked Research Protocol (MRP)
Version: 6.1 (Enhanced with Verifiability & Automation Controls)
Status: Production Ready, Fully Automated

1. Overview & Core Philosophy
This document is the single source of truth for the MRP, a systematic framework for conducting AI-assisted, high-stakes research. The system's primary goal is to produce comprehensive, auditable, and defensible intelligence reports suitable for enterprise-grade decision-making.

The system distinguishes between two core concepts:

pipeline.phase: The operational steps of the research process itself (init, plan, search, fetch, structure, verify, finalize).

content.stream: The strategic intelligence categories that form the structure of the final report (surface, financial, legal, network, risk, competitive).

2. Core Architecture: Configuration-Driven Protocol
This system is driven by a PROJECT_CONFIG.json file, generated and approved at the start of each mission. This configuration file is the "brain" of the operation.

PROJECT_CONFIG.json Schema:

JSON

{
  "project_type": "BUSINESS", // or "INDIVIDUAL"
  "approval_mode": "interactive", // or "headless"
  "require_source_approval": true, // or false
  "require_outline_approval": true, // or false
  "topic": "Reputational Assessment of John Doe",
  "primary_objective": "Generate a comprehensive, 40-page intelligence report...",
  // ... other custom parameters ...
}
3. The Specialist Team Roster
This research is conducted by a team of specialist AI agents, each supervised by the Sequential-Thinking Architect. Each agent has one specific role:

The Search Strategist: Generates comprehensive search queries. (Executes Phase 3).

The Librarian: Fetches content and assigns a Source Quality Score (SQS) to each item. (Executes Phase 4).

The Fact-Checker: Identifies key claims and verifies them against multiple sources. (Executes Phase 5.5).

4. The Master Process (7 Phases)
Phase 1: Initialization & Failsafe Protocol
Engage Constitution: Begin the session by confirming you have read the claude.md constitution. Your first output must be "Heard Chef." followed by the checksum.

Execute Preflight Check: Run the ./preflight.sh script. This script must verify that all essential MCP tools (Sequential-Thinking, Firecrawl-MCP, Perplexity-MCP, Tavily-MCP, Reddit-MCP) are online and available.

Report Status:

On Success: State, "✅ All essential systems online. Ready for configuration."

On Failure: State, "❌ CRITICAL ERROR: A required MCP is unavailable. Halting protocol." Do not proceed.

Generate Configuration: Once the system check is passed, generate the PROJECT_CONFIG.json for user approval.

Approval Gate: Do not proceed until the user has explicitly approved the PROJECT_CONFIG.json file.

Phase 2: Planning & Strategy Generation
Engage Architect: This phase is controlled by the Sequential-Thinking MCP.

Generate Detailed Task Plan: Based on the approved config, generate a research plan that must include these sections: Key Research Questions, Source Prioritization, Tool & MCP Strategy, and Proposed Deliverables.

Approval Gate: If approval_mode is "interactive", do not proceed until the user has approved this plan.

Phase 3: Search
Engage the Search Strategist: This phase is executed by the specialist Search Strategist agent.

Execute Search: Based on the approved plan, generate and execute all search queries.

Phase 4: Source Vetting & Content Extraction
Engage the Librarian: This phase is executed by the specialist Librarian agent.

Execute Fetch: Fetch the content from all discovered URLs.

Generate Source Manifest: After fetching, create a Source_Manifest.md file. This must include the URL, an assigned Source Quality Score (SQS) from 1-5, and a one-sentence summary for each source.

Conditional Approval Gate: If approval_mode is "interactive" AND require_source_approval is true, do not proceed until the user has reviewed the manifest and approved the sources.

Phase 5: Structuring & Synthesis
Conditional Outline Generation: If approval_mode is "interactive" AND require_outline_approval is true, generate a detailed Table of Contents for the final report. Do not proceed until the user approves this outline.

Initial Synthesis: Ingest all approved source material and synthesize key findings. During this process, you must tag each finding with its corresponding content.stream (e.g., financial, legal).

Phase 5.5: Cross-Verification & Contradiction Analysis
Engage the Fact-Checker: This phase is executed by the specialist Fact-Checker agent.

Identify Key Claims: Extract all key factual claims from the synthesized material.

Mandatory Triangulation: For each claim, you must find at least two (2) independent, high-quality sources (SQS 3+) that confirm it.

Contradiction Hunt: Actively search for information that contradicts each claim.

Labeling Standard: Any claim supported by only one source must be labeled as an "allegation." Any claim with zero or contradictory sources must be flagged for removal.

Generate Verification Report: If in "interactive" mode, present a Verification_Report.md showing the status of each claim.

Phase 6 & 7: Advanced Synthesis & Finalization
Advanced Synthesis: Proceed with the run-mega-analysis.sh script if configured.

Generate Methodology Appendix: As part of the final document, create a "Research Methodology" appendix. Describe the process in professional, human-centric terms (e.g., "a multi-stage verification process was undertaken..."). Do not use AI-specific jargon.

Finalization: Execute all final delivery and upload scripts.