# Marketing MCP Servers Guide 2025

## Overview
Model Context Protocol (MCP) servers enable AI assistants like Claude to interact directly with marketing tools and platforms. This guide covers the most important marketing MCP servers available in 2025.

## Top Marketing MCP Servers

### 1. CRM & Sales Platforms

#### HubSpot MCP Server
- **Status**: Public Beta (First major CRM with MCP support)
- **Capabilities**: 
  - Access to 225,000+ companies' data
  - 21 powerful tools available
  - Create, read, update contacts, companies, deals
  - Create tasks and notes
  - Natural language queries
- **GitHub**: github.com/peakmojo/mcp-hubspot
- **Example**: "Find OpenAI in my HubSpot CRM and send me the details on Slack"

#### Salesforce MCP Server
- **Capabilities**:
  - SOQL and SOSL query execution
  - CRUD operations on Salesforce objects
  - Campaign performance metrics
  - Contact data management
- **Use Case**: Pull campaign metrics without leaving Claude

#### Klaviyo MCP Server
- **Status**: Active (you have klaviyo-mcp installed)
- **Capabilities**:
  - Profile management
  - Lists and segments
  - Campaign and flow management
  - Template handling
  - Metrics and analytics

### 2. Email Marketing Platforms

#### Mailchimp MCP Server
- **Capabilities**:
  - Campaign management
  - Audience management
  - Template handling
  - Performance reports
  - OAuth integration via Cloudflare Workers
- **Example**: "What was our best-performing email last quarter?"

#### SendGrid MCP Server
- **Capabilities**:
  - Transactional and marketing emails
  - Contact and list management
  - Template management
  - Delivery statistics
  - Suppression management

#### Mailgun MCP Server
- **Capabilities**:
  - Transactional email support
  - Follow-up automation
  - Delivery statistics monitoring

#### Smartlead MCP Server
- **Capabilities**:
  - Cold outreach campaign management
  - Sequence management
  - Performance tracking

### 3. Marketing Automation

#### ActiveCampaign MCP Server
- **Capabilities**:
  - Contact management
  - List management
  - Campaign automation
  - Deal tracking
  - Custom field handling

#### Zapier MCP Server
- **Capabilities**:
  - Connect to 7,000+ apps
  - 30,000+ actions available
  - Workflow automation
  - Trigger management
- **Note**: Central hub in MCP ecosystem

#### Make (Integromat) MCP Server
- **Capabilities**:
  - Visual workflow automation
  - Scenario triggering
  - Data exchange via conversation

#### n8n MCP Server
- **Capabilities**:
  - Workflow templates
  - AI agent building

### 4. Analytics & SEO

#### Google Analytics 4 MCP Server
- **Capabilities**:
  - Web analytics data fetching
  - Natural language analysis
  - Performance metrics

#### Google Search Console MCP Server
- **Capabilities**:
  - SEO data analysis
  - Search performance metrics
  - Natural language queries

#### DataForSEO MCP Server
- **Status**: Active (dataforseo-mcp-server running)
- **Capabilities**:
  - SEO tool integration
  - Keyword research
  - SERP analysis
  - Backlink data

#### Audiense Insights MCP Server
- **Capabilities**:
  - Audience analysis
  - Marketing insights
  - Report generation

### 5. Advertising Platforms

#### Google Ads MCP Server
- **Capabilities**:
  - Campaign data analysis
  - Performance metrics
  - Natural language queries

#### Facebook/Meta Ads MCP Server
- **Capabilities**:
  - Social advertising metrics
  - Creative performance analysis
  - Cross-platform insights
- **Example**: "Show me which ad creative has the highest conversion rate on Instagram"

### 6. Content Management

#### WordPress MCP Server
- **Capabilities**:
  - Content creation automation
  - SEO optimization
  - Bulk operations
  - AI-powered management

#### YouTube MCP Server
- **Capabilities**:
  - Transcript extraction
  - Content summarization
  - LinkedIn post generation

#### Webflow MCP Server
- **Status**: Active (webflow-mcp-server running)
- **Capabilities**:
  - Website content management
  - Design automation

### 7. E-commerce Integration

#### Shopify MCP Server
- **Status**: Available but disabled in your setup
- **Capabilities**:
  - Product management
  - Order processing
  - Coupon creation
  - Inventory tracking

### 8. Social Media

#### Reddit MCP Server
- **Status**: Active (reddit-mcp-server running)
- **Capabilities**:
  - Reddit search and analysis
  - Thread monitoring
  - Sentiment analysis

### 9. Multi-Platform Tools

#### Firecrawl MCP Server
- **Status**: Active (firecrawl-mcp running)
- **Tools**:
  - firecrawl_scrape: Most powerful web scraper
  - firecrawl_map: URL discovery
  - firecrawl_crawl: Full website crawling
  - firecrawl_search: Web search
  - firecrawl_batch_scrape: Multiple URL scraping

#### Playwright MCP Server
- **Status**: Active (24 tools enabled)
- **Capabilities**:
  - Browser automation
  - Complex page interactions
  - Screenshot capture
  - Form filling

#### Perplexity MCP Server
- **Status**: Active (perplexity-mcp running)
- **Capabilities**:
  - AI-powered search
  - Content synthesis
  - Research automation

#### Tavily MCP Server
- **Status**: Active (tavily-mcp running)
- **Capabilities**:
  - Web research
  - Content discovery
  - Search optimization

## Marketing Workflow Examples

### Example 1: Integrated Campaign Management
```
"Find all contacts added in the last 30 days who are based in Boston, 
create a list of them, and draft a personalized email about our 
upcoming event there."
```

### Example 2: Pipeline Analysis
```
"Analyze our sales pipeline, identify deals that haven't moved in 
30 days, and suggest next steps for each based on the last 
conversation notes."
```

### Example 3: Cross-Platform Promotion
```
"Create a 20% off coupon code for our email subscribers and draft 
an announcement email in Mailchimp"
```

## Cost Considerations
- MCP servers typically have minimal overhead
- Most integrate with existing API subscriptions
- Some require OAuth authentication
- Cost mainly comes from underlying service usage

## Getting Started
1. Install desired MCP servers via npm or specific installers
2. Configure authentication (API keys, OAuth)
3. Enable in your MCP client (Cursor, Claude Desktop, etc.)
4. Start using natural language commands

## Best Practices
1. Always use MCP tools when available over manual API calls
2. Batch operations when possible
3. Use specific, detailed prompts for best results
4. Monitor API usage to avoid rate limits
5. Keep MCP servers updated for latest features

## Future Outlook
- 72% of content marketing teams plan to increase AI investment in 2025
- MCP ecosystem growing rapidly (4,380+ servers)
- Major platforms actively developing MCP support
- Standardization improving cross-platform workflows

## Note on Claude Code CLI Limitations
While these MCP servers are available in Cursor's ecosystem, Claude Code CLI has limited access compared to Cursor's built-in AI. Currently, only `mcp__ide__` functions are accessible to Claude Code CLI. Use WebSearch and WebFetch as fallbacks when MCP access is restricted.