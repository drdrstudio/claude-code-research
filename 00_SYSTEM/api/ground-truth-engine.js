/**
 * GROUND TRUTH DATA COLLECTION ENGINE v1.0
 * Real implementation of all 6 MRP phases with actual API calls
 * No mocks, no fakes, no placeholders - only real data
 */

const https = require('https');
const fs = require('fs');
const path = require('path');

class GroundTruthEngine {
  constructor(targetName, researchType = 'organization') {
    this.targetName = targetName;
    this.researchType = researchType;
    this.isServerless = process.env.VERCEL === '1' || !!process.env.AWS_LAMBDA_FUNCTION_NAME;
    
    // Initialize results structure
    this.results = {
      surface: {
        firecrawl: [],
        perplexity: [],
        tavily: [],
        total_sources: 0
      },
      financial: {
        keyword_data: [],
        serp_results: [],
        competitor_data: []
      },
      legal: {
        court_records: [],
        sec_filings: [],
        regulatory_items: []
      },
      network: {
        relationships: [],
        board_members: [],
        partnerships: []
      },
      risk: {
        vulnerabilities: [],
        risk_level: 'UNKNOWN',
        mitigation_strategies: []
      },
      competitive: {
        reddit_posts: [],
        sentiment_score: 0,
        market_position: {}
      },
      all_sources: []
    };
    
    // API Keys
    this.apiKeys = {
      firecrawl: process.env.FIRECRAWL_API_KEY,
      perplexity: process.env.PERPLEXITY_API_KEY,
      tavily: process.env.TAVILY_API_KEY,
      dataforseo_login: process.env.DATAFORSEO_LOGIN,
      dataforseo_password: process.env.DATAFORSEO_PASSWORD,
      reddit_client_id: process.env.REDDIT_CLIENT_ID,
      reddit_client_secret: process.env.REDDIT_CLIENT_SECRET
    };
  }

  /**
   * PHASE 1: SURFACE INTELLIGENCE
   * Collect 40-50 sources minimum using multiple search engines
   */
  async runSurfaceIntelligence(updateProgress) {
    updateProgress('Phase 1: Surface Intelligence', 'Starting comprehensive search across multiple sources');
    
    const searches = [
      // Primary searches
      this.searchFirecrawl(this.targetName),
      this.queryPerplexity(`Who is ${this.targetName}? What are their business activities, controversies, and achievements?`),
      this.searchTavily(this.targetName),
      
      // Deep searches for different aspects
      this.searchFirecrawl(`${this.targetName} lawsuit litigation scandal`),
      this.searchFirecrawl(`${this.targetName} CEO founder executive board`),
      this.searchFirecrawl(`${this.targetName} financial revenue funding investment`),
      this.queryPerplexity(`What legal issues or controversies involve ${this.targetName}?`),
      this.searchTavily(`${this.targetName} news recent developments`),
      
      // Professional searches
      this.searchFirecrawl(`site:linkedin.com ${this.targetName}`),
      this.searchFirecrawl(`site:bloomberg.com ${this.targetName}`),
      this.searchFirecrawl(`site:sec.gov ${this.targetName}`),
      
      // Document searches
      this.searchFirecrawl(`${this.targetName} filetype:pdf`),
      this.searchTavily(`${this.targetName} annual report financial statement`)
    ];
    
    // Execute all searches in parallel with timeout protection
    const searchResults = await Promise.allSettled(
      searches.map(promise => 
        Promise.race([
          promise,
          new Promise((_, reject) => 
            setTimeout(() => reject(new Error('Search timeout')), 30000)
          )
        ])
      )
    );
    
    // Process results
    searchResults.forEach((result, index) => {
      if (result.status === 'fulfilled' && result.value) {
        this.processSearchResult(result.value, index);
      }
    });
    
    // Collect all sources
    this.results.surface.total_sources = 
      this.results.surface.firecrawl.length + 
      this.results.surface.perplexity.length + 
      this.results.surface.tavily.length;
    
    updateProgress('Phase 1: Surface Intelligence', 
      `Collected ${this.results.surface.total_sources} sources`);
    
    // Warn if below minimum
    if (this.results.surface.total_sources < 40) {
      updateProgress('Phase 1: Surface Intelligence', 
        `WARNING: Only ${this.results.surface.total_sources} sources found. Expanding search...`);
      
      // Additional searches to meet minimum
      const additionalSearches = [
        this.searchFirecrawl(`${this.targetName} profile background history`),
        this.searchTavily(`${this.targetName} analysis review opinion`),
        this.queryPerplexity(`What is the reputation and track record of ${this.targetName}?`)
      ];
      
      const moreResults = await Promise.allSettled(additionalSearches);
      moreResults.forEach((result, index) => {
        if (result.status === 'fulfilled' && result.value) {
          this.processSearchResult(result.value, index + searches.length);
        }
      });
      
      this.results.surface.total_sources = 
        this.results.surface.firecrawl.length + 
        this.results.surface.perplexity.length + 
        this.results.surface.tavily.length;
    }
    
    return this.results.surface;
  }

  /**
   * Search using Firecrawl API
   */
  async searchFirecrawl(query) {
    if (!this.apiKeys.firecrawl) return null;
    
    return new Promise((resolve) => {
      const data = JSON.stringify({
        query: query,
        limit: 10,
        scrapeOptions: {
          formats: ['markdown'],
          onlyMainContent: true
        }
      });

      const options = {
        protocol: 'https:',
        hostname: 'api.firecrawl.dev',
        path: '/v1/search',
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${this.apiKeys.firecrawl}`,
          'Content-Type': 'application/json',
          'Content-Length': Buffer.byteLength(data)
        },
        timeout: 30000
      };

      const req = https.request(options, (res) => {
        let body = '';
        res.on('data', chunk => body += chunk);
        res.on('end', () => {
          try {
            const result = JSON.parse(body);
            if (result.data && Array.isArray(result.data)) {
              resolve({
                source: 'firecrawl',
                query: query,
                results: result.data.map(item => ({
                  url: item.url,
                  title: item.title || '',
                  content: item.markdown || item.content || '',
                  snippet: item.snippet || ''
                }))
              });
            } else {
              resolve(null);
            }
          } catch (e) {
            console.error('[Firecrawl] Parse error:', e.message);
            resolve(null);
          }
        });
      });

      req.on('error', () => resolve(null));
      req.on('timeout', () => {
        req.destroy();
        resolve(null);
      });

      req.write(data);
      req.end();
    });
  }

  /**
   * Query Perplexity AI for comprehensive analysis
   */
  async queryPerplexity(prompt) {
    if (!this.apiKeys.perplexity) return null;
    
    return new Promise((resolve) => {
      const data = JSON.stringify({
        model: 'sonar',
        messages: [
          {
            role: 'system',
            content: 'You are a research assistant. Provide comprehensive, factual information with specific details, dates, and sources when available.'
          },
          {
            role: 'user',
            content: prompt
          }
        ]
      });

      const options = {
        protocol: 'https:',
        hostname: 'api.perplexity.ai',
        path: '/chat/completions',
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${this.apiKeys.perplexity}`,
          'Content-Type': 'application/json',
          'Content-Length': Buffer.byteLength(data)
        },
        timeout: 30000
      };

      const req = https.request(options, (res) => {
        let body = '';
        res.on('data', chunk => body += chunk);
        res.on('end', () => {
          try {
            const result = JSON.parse(body);
            if (result.choices && result.choices[0]) {
              const content = result.choices[0].message.content;
              resolve({
                source: 'perplexity',
                query: prompt,
                results: [{
                  url: 'perplexity-analysis',
                  title: `Perplexity Analysis: ${prompt.substring(0, 100)}`,
                  content: content,
                  citations: result.citations || []
                }]
              });
            } else {
              resolve(null);
            }
          } catch (e) {
            console.error('[Perplexity] Parse error:', e.message);
            resolve(null);
          }
        });
      });

      req.on('error', () => resolve(null));
      req.on('timeout', () => {
        req.destroy();
        resolve(null);
      });

      req.write(data);
      req.end();
    });
  }

  /**
   * Search using Tavily API
   */
  async searchTavily(query) {
    if (!this.apiKeys.tavily) return null;
    
    return new Promise((resolve) => {
      const data = JSON.stringify({
        api_key: this.apiKeys.tavily,
        query: query,
        search_depth: 'advanced',
        include_raw_content: true,
        max_results: 10
      });

      const options = {
        protocol: 'https:',
        hostname: 'api.tavily.com',
        path: '/search',
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Content-Length': Buffer.byteLength(data)
        },
        timeout: 30000
      };

      const req = https.request(options, (res) => {
        let body = '';
        res.on('data', chunk => body += chunk);
        res.on('end', () => {
          try {
            const result = JSON.parse(body);
            if (result.results && Array.isArray(result.results)) {
              resolve({
                source: 'tavily',
                query: query,
                results: result.results.map(item => ({
                  url: item.url,
                  title: item.title || '',
                  content: item.raw_content || item.content || '',
                  snippet: item.snippet || ''
                }))
              });
            } else {
              resolve(null);
            }
          } catch (e) {
            console.error('[Tavily] Parse error:', e.message);
            resolve(null);
          }
        });
      });

      req.on('error', () => resolve(null));
      req.on('timeout', () => {
        req.destroy();
        resolve(null);
      });

      req.write(data);
      req.end();
    });
  }

  /**
   * Process search results and add to appropriate collections
   */
  processSearchResult(searchData, index) {
    if (!searchData || !searchData.results) return;
    
    const { source, query, results } = searchData;
    
    results.forEach(item => {
      // Create source object
      const sourceObj = {
        source: source,
        query: query,
        url: item.url,
        title: item.title,
        content: item.content || item.snippet || '',
        collected_at: new Date().toISOString()
      };
      
      // Add to appropriate collection
      if (source === 'firecrawl') {
        this.results.surface.firecrawl.push(sourceObj);
      } else if (source === 'perplexity') {
        this.results.surface.perplexity.push(sourceObj);
      } else if (source === 'tavily') {
        this.results.surface.tavily.push(sourceObj);
      }
      
      // Add to all sources
      this.results.all_sources.push(sourceObj);
    });
  }

  /**
   * PHASE 2: FINANCIAL INTELLIGENCE
   * Use DataForSEO to gather financial and SEO data
   */
  async runFinancialIntelligence(updateProgress) {
    updateProgress('Phase 2: Financial Intelligence', 'Analyzing financial data and market presence');
    
    if (!this.apiKeys.dataforseo_login || !this.apiKeys.dataforseo_password) {
      updateProgress('Phase 2: Financial Intelligence', 'DataForSEO credentials not available');
      return this.results.financial;
    }
    
    // Prepare auth
    const auth = Buffer.from(`${this.apiKeys.dataforseo_login}:${this.apiKeys.dataforseo_password}`).toString('base64');
    
    // Financial-related keywords
    const keywords = [
      this.targetName,
      `${this.targetName} revenue`,
      `${this.targetName} funding`,
      `${this.targetName} valuation`,
      `${this.targetName} financial performance`
    ];
    
    // Get keyword data
    const keywordData = await this.getDataForSEOKeywordData(keywords, auth);
    if (keywordData) {
      this.results.financial.keyword_data = keywordData;
    }
    
    // Get SERP data for financial queries
    const serpData = await this.getDataForSEOSerpData(this.targetName, auth);
    if (serpData) {
      this.results.financial.serp_results = serpData;
    }
    
    updateProgress('Phase 2: Financial Intelligence', 
      `Collected ${this.results.financial.keyword_data.length} keyword insights`);
    
    return this.results.financial;
  }

  /**
   * Get keyword data from DataForSEO
   */
  async getDataForSEOKeywordData(keywords, auth) {
    return new Promise((resolve) => {
      const data = JSON.stringify([{
        keywords: keywords,
        location_name: "United States",
        language_code: "en"
      }]);

      const options = {
        protocol: 'https:',
        hostname: 'api.dataforseo.com',
        path: '/v3/keywords_data/google_ads/search_volume/live',
        method: 'POST',
        headers: {
          'Authorization': `Basic ${auth}`,
          'Content-Type': 'application/json',
          'Content-Length': Buffer.byteLength(data)
        },
        timeout: 30000
      };

      const req = https.request(options, (res) => {
        let body = '';
        res.on('data', chunk => body += chunk);
        res.on('end', () => {
          try {
            const result = JSON.parse(body);
            if (result.tasks && result.tasks[0] && result.tasks[0].result) {
              resolve(result.tasks[0].result);
            } else {
              resolve(null);
            }
          } catch (e) {
            console.error('[DataForSEO] Parse error:', e.message);
            resolve(null);
          }
        });
      });

      req.on('error', () => resolve(null));
      req.on('timeout', () => {
        req.destroy();
        resolve(null);
      });

      req.write(data);
      req.end();
    });
  }

  /**
   * Get SERP data from DataForSEO
   */
  async getDataForSEOSerpData(keyword, auth) {
    return new Promise((resolve) => {
      const data = JSON.stringify([{
        keyword: keyword,
        location_name: "United States",
        language_code: "en",
        device: "desktop",
        depth: 20
      }]);

      const options = {
        protocol: 'https:',
        hostname: 'api.dataforseo.com',
        path: '/v3/serp/google/organic/live/advanced',
        method: 'POST',
        headers: {
          'Authorization': `Basic ${auth}`,
          'Content-Type': 'application/json',
          'Content-Length': Buffer.byteLength(data)
        },
        timeout: 30000
      };

      const req = https.request(options, (res) => {
        let body = '';
        res.on('data', chunk => body += chunk);
        res.on('end', () => {
          try {
            const result = JSON.parse(body);
            if (result.tasks && result.tasks[0] && result.tasks[0].result) {
              const items = result.tasks[0].result[0].items || [];
              resolve(items.filter(item => item.type === 'organic'));
            } else {
              resolve(null);
            }
          } catch (e) {
            console.error('[DataForSEO SERP] Parse error:', e.message);
            resolve(null);
          }
        });
      });

      req.on('error', () => resolve(null));
      req.on('timeout', () => {
        req.destroy();
        resolve(null);
      });

      req.write(data);
      req.end();
    });
  }

  /**
   * PHASE 3: LEGAL INTELLIGENCE
   * Search for legal records and regulatory filings
   */
  async runLegalIntelligence(updateProgress) {
    updateProgress('Phase 3: Legal Intelligence', 'Searching legal records and regulatory filings');
    
    const legalSearches = [
      this.searchFirecrawl(`${this.targetName} lawsuit court case litigation`),
      this.searchFirecrawl(`${this.targetName} SEC filing violation penalty`),
      this.searchFirecrawl(`site:sec.gov "${this.targetName}"`),
      this.searchFirecrawl(`site:justice.gov "${this.targetName}"`),
      this.searchTavily(`${this.targetName} legal settlement judgment verdict`),
      this.queryPerplexity(`What legal cases, lawsuits, or regulatory actions involve ${this.targetName}?`)
    ];
    
    const results = await Promise.allSettled(legalSearches);
    
    results.forEach((result) => {
      if (result.status === 'fulfilled' && result.value) {
        const { results: searchResults } = result.value;
        if (searchResults) {
          searchResults.forEach(item => {
            // Analyze content for legal indicators
            const content = (item.content || item.snippet || '').toLowerCase();
            
            if (content.includes('lawsuit') || content.includes('litigation')) {
              this.results.legal.court_records.push({
                url: item.url,
                title: item.title,
                summary: item.snippet || content.substring(0, 200)
              });
            }
            
            if (content.includes('sec') || content.includes('filing')) {
              this.results.legal.sec_filings.push({
                url: item.url,
                title: item.title,
                summary: item.snippet || content.substring(0, 200)
              });
            }
            
            if (content.includes('violation') || content.includes('penalty') || content.includes('regulatory')) {
              this.results.legal.regulatory_items.push({
                url: item.url,
                title: item.title,
                summary: item.snippet || content.substring(0, 200)
              });
            }
          });
        }
      }
    });
    
    updateProgress('Phase 3: Legal Intelligence', 
      `Found ${this.results.legal.court_records.length} court records, ${this.results.legal.sec_filings.length} SEC filings`);
    
    return this.results.legal;
  }

  /**
   * PHASE 4: NETWORK INTELLIGENCE
   * Map relationships and connections
   */
  async runNetworkIntelligence(updateProgress) {
    updateProgress('Phase 4: Network Intelligence', 'Mapping professional relationships and connections');
    
    const networkSearches = [
      this.searchFirecrawl(`${this.targetName} board directors executives team`),
      this.searchFirecrawl(`${this.targetName} partners partnership collaboration`),
      this.searchFirecrawl(`site:linkedin.com ${this.targetName} connections`),
      this.queryPerplexity(`Who are the key executives, board members, and partners of ${this.targetName}?`),
      this.searchTavily(`${this.targetName} management leadership team structure`)
    ];
    
    const results = await Promise.allSettled(networkSearches);
    
    results.forEach((result) => {
      if (result.status === 'fulfilled' && result.value) {
        const { results: searchResults } = result.value;
        if (searchResults) {
          searchResults.forEach(item => {
            const content = (item.content || item.snippet || '');
            
            // Extract names and titles
            const executivePattern = /(CEO|CFO|CTO|COO|President|Director|Chairman|Founder)\s+([A-Z][a-z]+\s+[A-Z][a-z]+)/g;
            let match;
            while ((match = executivePattern.exec(content)) !== null) {
              this.results.network.relationships.push({
                name: match[2],
                title: match[1],
                source: item.url
              });
            }
            
            // Look for partnerships
            if (content.includes('partner') || content.includes('collaboration')) {
              this.results.network.partnerships.push({
                url: item.url,
                title: item.title,
                summary: item.snippet || content.substring(0, 200)
              });
            }
          });
        }
      }
    });
    
    // Deduplicate relationships
    const uniqueRelationships = [];
    const seen = new Set();
    this.results.network.relationships.forEach(rel => {
      const key = `${rel.name}-${rel.title}`;
      if (!seen.has(key)) {
        seen.add(key);
        uniqueRelationships.push(rel);
      }
    });
    this.results.network.relationships = uniqueRelationships;
    
    updateProgress('Phase 4: Network Intelligence', 
      `Identified ${this.results.network.relationships.length} key relationships`);
    
    return this.results.network;
  }

  /**
   * PHASE 5: RISK ASSESSMENT
   * Analyze vulnerabilities and risks
   */
  async runRiskAssessment(updateProgress) {
    updateProgress('Phase 5: Risk Assessment', 'Analyzing vulnerabilities and risk factors');
    
    // Analyze all collected data for risk indicators
    let riskScore = 0;
    const vulnerabilities = [];
    
    // Legal risks
    if (this.results.legal.court_records.length > 0) {
      riskScore += this.results.legal.court_records.length * 2;
      vulnerabilities.push({
        type: 'Legal',
        severity: 'High',
        details: `${this.results.legal.court_records.length} potential legal issues identified`
      });
    }
    
    // Regulatory risks
    if (this.results.legal.regulatory_items.length > 0) {
      riskScore += this.results.legal.regulatory_items.length * 1.5;
      vulnerabilities.push({
        type: 'Regulatory',
        severity: 'Medium',
        details: `${this.results.legal.regulatory_items.length} regulatory concerns found`
      });
    }
    
    // Search for specific risk keywords in all sources
    let scandalCount = 0;
    let fraudCount = 0;
    let investigationCount = 0;
    
    this.results.all_sources.forEach(source => {
      const content = (source.content || '').toLowerCase();
      if (content.includes('scandal')) scandalCount++;
      if (content.includes('fraud')) fraudCount++;
      if (content.includes('investigation')) investigationCount++;
    });
    
    if (scandalCount > 0) {
      riskScore += scandalCount * 3;
      vulnerabilities.push({
        type: 'Reputational',
        severity: 'High',
        details: `${scandalCount} sources mention scandals`
      });
    }
    
    if (fraudCount > 0) {
      riskScore += fraudCount * 5;
      vulnerabilities.push({
        type: 'Fraud',
        severity: 'Critical',
        details: `${fraudCount} sources mention fraud`
      });
    }
    
    if (investigationCount > 0) {
      riskScore += investigationCount * 2;
      vulnerabilities.push({
        type: 'Investigation',
        severity: 'Medium',
        details: `${investigationCount} sources mention investigations`
      });
    }
    
    // Calculate risk level
    let riskLevel = 'LOW';
    if (riskScore > 20) riskLevel = 'CRITICAL';
    else if (riskScore > 15) riskLevel = 'HIGH';
    else if (riskScore > 8) riskLevel = 'MEDIUM';
    else if (riskScore > 3) riskLevel = 'LOW';
    else riskLevel = 'MINIMAL';
    
    this.results.risk = {
      vulnerabilities: vulnerabilities,
      risk_level: riskLevel,
      risk_score: riskScore,
      mitigation_strategies: this.generateMitigationStrategies(vulnerabilities)
    };
    
    updateProgress('Phase 5: Risk Assessment', 
      `Risk Level: ${riskLevel} (Score: ${riskScore})`);
    
    return this.results.risk;
  }

  /**
   * Generate mitigation strategies based on vulnerabilities
   */
  generateMitigationStrategies(vulnerabilities) {
    const strategies = [];
    
    vulnerabilities.forEach(vuln => {
      switch(vuln.type) {
        case 'Legal':
          strategies.push('Conduct comprehensive legal review and establish litigation reserve');
          break;
        case 'Regulatory':
          strategies.push('Implement compliance monitoring and regulatory engagement strategy');
          break;
        case 'Reputational':
          strategies.push('Deploy reputation management and crisis communication protocols');
          break;
        case 'Fraud':
          strategies.push('Initiate forensic investigation and strengthen internal controls');
          break;
        case 'Investigation':
          strategies.push('Prepare legal defense and document preservation protocols');
          break;
      }
    });
    
    return strategies;
  }

  /**
   * PHASE 6: COMPETITIVE INTELLIGENCE
   * Analyze market position and sentiment
   */
  async runCompetitiveIntelligence(updateProgress) {
    updateProgress('Phase 6: Competitive Intelligence', 'Analyzing market position and community sentiment');
    
    // Reddit sentiment analysis (simplified without OAuth)
    const sentimentSearches = [
      this.searchFirecrawl(`site:reddit.com ${this.targetName}`),
      this.searchTavily(`reddit ${this.targetName} opinion review`),
      this.queryPerplexity(`What is the public opinion and sentiment about ${this.targetName} on social media and forums?`)
    ];
    
    const results = await Promise.allSettled(sentimentSearches);
    
    let positiveCount = 0;
    let negativeCount = 0;
    let neutralCount = 0;
    
    results.forEach((result) => {
      if (result.status === 'fulfilled' && result.value) {
        const { results: searchResults } = result.value;
        if (searchResults) {
          searchResults.forEach(item => {
            const content = (item.content || item.snippet || '').toLowerCase();
            
            // Simple sentiment analysis
            const positiveWords = ['good', 'great', 'excellent', 'amazing', 'love', 'best', 'awesome', 'fantastic'];
            const negativeWords = ['bad', 'terrible', 'awful', 'hate', 'worst', 'scam', 'fraud', 'sucks'];
            
            let positive = 0;
            let negative = 0;
            
            positiveWords.forEach(word => {
              if (content.includes(word)) positive++;
            });
            
            negativeWords.forEach(word => {
              if (content.includes(word)) negative++;
            });
            
            if (positive > negative) positiveCount++;
            else if (negative > positive) negativeCount++;
            else neutralCount++;
            
            // Store Reddit posts
            if (item.url.includes('reddit.com')) {
              this.results.competitive.reddit_posts.push({
                url: item.url,
                title: item.title,
                sentiment: positive > negative ? 'positive' : negative > positive ? 'negative' : 'neutral'
              });
            }
          });
        }
      }
    });
    
    // Calculate sentiment score
    const total = positiveCount + negativeCount + neutralCount;
    const sentimentScore = total > 0 ? 
      ((positiveCount - negativeCount) / total * 100).toFixed(1) : 0;
    
    this.results.competitive.sentiment_score = sentimentScore;
    this.results.competitive.market_position = {
      positive_mentions: positiveCount,
      negative_mentions: negativeCount,
      neutral_mentions: neutralCount,
      overall_sentiment: sentimentScore > 20 ? 'Positive' : 
                         sentimentScore < -20 ? 'Negative' : 'Neutral'
    };
    
    updateProgress('Phase 6: Competitive Intelligence', 
      `Sentiment Score: ${sentimentScore}% (${this.results.competitive.market_position.overall_sentiment})`);
    
    return this.results.competitive;
  }

  /**
   * Execute all 6 phases
   */
  async executeFullResearch(updateProgress) {
    console.log('[GROUND TRUTH] Starting 6-phase intelligence gathering');
    
    // Phase 1: Surface Intelligence
    await this.runSurfaceIntelligence(updateProgress);
    
    // Phase 2: Financial Intelligence
    await this.runFinancialIntelligence(updateProgress);
    
    // Phase 3: Legal Intelligence
    await this.runLegalIntelligence(updateProgress);
    
    // Phase 4: Network Intelligence
    await this.runNetworkIntelligence(updateProgress);
    
    // Phase 5: Risk Assessment
    await this.runRiskAssessment(updateProgress);
    
    // Phase 6: Competitive Intelligence
    await this.runCompetitiveIntelligence(updateProgress);
    
    console.log('[GROUND TRUTH] All 6 phases completed');
    console.log(`[GROUND TRUTH] Total sources collected: ${this.results.all_sources.length}`);
    
    return this.results;
  }
}

module.exports = GroundTruthEngine;