# CLAUDE CODE RESEARCH PROTOCOLS

## COMPREHENSIVE RESEARCH on [TOPIC]

When user says this command, execute:

1. **Project Setup**
   ```bash
   mkdir ~/Documents/cursor/Claude-Code-Research/Research_[TOPIC]_$(date +%Y%m%d_%H%M%S)
   cd Research_[TOPIC]_[DATE]
   cp -r ../Claude_Code_Research_Template/* .
   ```

2. **Initialize TodoWrite**
   - Create comprehensive task list
   - Track each phase completion

3. **Search Phase** (5-7 searches)
   ```
   WebSearch queries:
   - "[TOPIC]" 
   - "[TOPIC] latest news 2024 2025"
   - "[TOPIC] research papers"
   - "[TOPIC] market analysis"
   - "[TOPIC] expert opinions"
   - "[TOPIC] challenges problems"
   - "[TOPIC] future trends"
   ```
   Save each to: `01_searches/YYYYMMDD_HHMMSS_websearch_[query].json`

4. **Fetch Phase** (10-15 fetches)
   For each important URL from searches:
   ```
   WebFetch with prompts:
   - "Extract all key information about [TOPIC] from this page"
   - "What are the main points, challenges, and opportunities?"
   - "List any statistics, data, or expert quotes"
   ```
   Save to: `02_fetched_content/YYYYMMDD_HHMMSS_webfetch_[source].md`

5. **Extract & Analyze**
   - Create structured JSON in 03_extracted_data/
   - Generate analysis docs in 04_analysis/
   - Build comparison tables
   - Create timelines

6. **Synthesize**
   - Executive summary
   - Comprehensive report
   - Key insights document
   - Resource compilation

## QUICK RESEARCH on [TOPIC]

Limited scope version:
- 3 WebSearch queries max
- 5 WebFetch operations max
- Focus on executive summary
- 15-minute completion target

## RESUME RESEARCH [NAME]

1. Load existing project
2. Read RESEARCH_LOG.md
3. Check search_log.csv
4. Continue from last task in TodoWrite

## DEEP DIVE on [TOPIC]

Extended version:
- 10+ searches including academic sources
- 20+ fetches with detailed analysis
- Multiple synthesis passes
- Comprehensive bibliography

## NEWS SCAN on [TOPIC]

Focus on recent developments:
- Search queries with date filters
- Prioritize news sources
- Timeline of recent events
- Trend analysis

## Key Differences from MCP Version

| Feature | MCP Version | Claude Code Version |
|---------|-------------|-------------------|
| Search | Firecrawl | WebSearch |
| Scraping | Firecrawl/Playwright | WebFetch |
| Synthesis | Perplexity | WebFetch + prompts |
| File Ops | Desktop Commander | Native tools |

## Important Notes

1. **Always save raw results** - WebSearch and WebFetch outputs
2. **Track all operations** - Update search_log.csv
3. **Use TodoWrite** - Essential for progress tracking
4. **Batch operations** - Multiple searches/fetches in one message
5. **Cost awareness** - Estimate before extensive operations