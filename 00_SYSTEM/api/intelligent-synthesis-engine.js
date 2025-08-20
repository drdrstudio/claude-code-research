/**
 * INTELLIGENT SYNTHESIS ENGINE v1.0
 * Based on the Youngblood Protocol - Reverse-engineered from successful manual intelligence report
 * 
 * This engine actually processes source content to extract real intelligence,
 * not just generate template text.
 */

class IntelligentSynthesisEngine {
  constructor(targetName, sources, projectPath) {
    this.targetName = targetName;
    this.sources = sources;
    this.projectPath = projectPath;
    
    // Intelligence containers
    this.entities = {
      people: new Map(),
      organizations: new Map(),
      events: [],
      financials: [],
      legal: [],
      locations: new Set()
    };
    
    this.findings = {
      critical: [],
      high: [],
      medium: [],
      low: []
    };
    
    this.citations = new Map();
    this.citationCounter = 1;
    
    this.patterns = {
      lawsuit: [],
      bankruptcy: [],
      fraud: [],
      scandal: [],
      achievement: [],
      appointment: []
    };
    
    this.riskFactors = {
      legal: 0,
      financial: 0,
      reputational: 0,
      regulatory: 0,
      political: 0
    };
  }

  /**
   * Main processing pipeline
   */
  async process() {
    console.log(`[SYNTHESIS] Starting intelligent synthesis for ${this.targetName}`);
    console.log(`[SYNTHESIS] Processing ${this.sources.length} collected sources`);
    
    // Stage 1: Extract entities and facts from all sources
    await this.extractEntitiesFromSources();
    
    // Stage 2: Identify patterns and relationships
    this.identifyPatterns();
    
    // Stage 3: Calculate risk scores from actual evidence
    this.calculateRiskScores();
    
    // Stage 4: Generate intelligence sections with real data
    const report = this.generateIntelligenceReport();
    
    return report;
  }

  /**
   * Extract actual entities and facts from source content
   */
  async extractEntitiesFromSources() {
    let processedSources = 0;
    
    for (const source of this.sources) {
      if (!source.markdown || source.markdown.length < 100) {
        continue; // Skip empty or error sources
      }
      
      processedSources++;
      const content = source.markdown;
      const url = source.url;
      const title = source.title || '';
      
      // Extract monetary amounts (including thousands with K)
      const moneyMatches = content.match(/\$[\d,]+(?:\.\d{2})?(?:\s*(?:million|billion|thousand|M|B|K))?/gi);
      if (moneyMatches) {
        moneyMatches.forEach(match => {
          const amount = this.parseMoneyAmount(match);
          if (amount > 100000) { // Track amounts over $100K
            this.entities.financials.push({
              amount: amount,
              original: match,
              context: this.extractContext(content, match),
              source: url,
              title: title
            });
            
            // Add citation
            const citationId = this.addCitation(url, title);
            
            // If it's a really large amount, it's probably important
            if (amount > 100000000) { // $100M+
              this.findings.critical.push({
                type: 'financial',
                finding: `${match} transaction or claim identified`,
                details: this.extractContext(content, match),
                source: url,
                citation: citationId
              });
            }
          }
        });
      }
      
      // Extract lawsuit mentions
      const lawsuitPatterns = [
        /(?:lawsuit|litigation|sued|suing|plaintiff|defendant)/gi,
        /(?:federal court|state court|district court)/gi,
        /(?:Chapter \d+|bankruptcy)/gi
      ];
      
      lawsuitPatterns.forEach(pattern => {
        const matches = content.match(pattern);
        if (matches) {
          matches.forEach(match => {
            const context = this.extractContext(content, match, 200);
            this.entities.legal.push({
              type: match.toLowerCase(),
              context: context,
              source: url,
              title: title
            });
            
            // Check if this is about our target
            if (context.toLowerCase().includes(this.targetName.toLowerCase())) {
              const citationId = this.addCitation(url, title);
              this.patterns.lawsuit.push({
                type: match,
                details: context,
                source: url,
                citation: citationId
              });
            }
          });
        }
      });
      
      // Extract company names
      const companyPatterns = content.match(/[A-Z][a-zA-Z\s&,.]+(?:LLC|Inc|Corp|Ltd|Group|Capital|Partners|Holdings|plc|Company|Corporation)/g);
      if (companyPatterns) {
        companyPatterns.forEach(company => {
          const cleanName = company.trim();
          if (cleanName.length > 3 && cleanName.length < 100) {
            if (!this.entities.organizations.has(cleanName)) {
              this.entities.organizations.set(cleanName, {
                name: cleanName,
                mentions: 0,
                sources: [],
                contexts: []
              });
            }
            
            const org = this.entities.organizations.get(cleanName);
            org.mentions++;
            org.sources.push(url);
            org.contexts.push(this.extractContext(content, cleanName, 100));
          }
        });
      }
      
      // Extract people names (looking for patterns like "John Smith" near titles)
      const titlePatterns = /(CEO|Chief Executive|President|Founder|Chairman|Director|Partner|Manager)\s+([A-Z][a-z]+\s+[A-Z][a-z]+)/g;
      const reversePatterns = /([A-Z][a-z]+\s+[A-Z][a-z]+),?\s+(CEO|Chief Executive|President|Founder|Chairman|Director|Partner|Manager)/g;
      
      [titlePatterns, reversePatterns].forEach(pattern => {
        let match;
        while ((match = pattern.exec(content)) !== null) {
          const name = match[1].includes('CEO') ? match[2] : match[1];
          const title = match[1].includes('CEO') ? match[1] : match[2];
          
          if (!this.entities.people.has(name)) {
            this.entities.people.set(name, {
              name: name,
              titles: new Set(),
              companies: new Set(),
              sources: []
            });
          }
          
          const person = this.entities.people.get(name);
          person.titles.add(title);
          person.sources.push(url);
        }
      });
      
      // Extract dates and events
      const datePatterns = content.match(/(?:January|February|March|April|May|June|July|August|September|October|November|December)\s+\d{1,2},?\s+\d{4}|\d{4}/g);
      if (datePatterns) {
        datePatterns.forEach(date => {
          const context = this.extractContext(content, date, 150);
          // Look for significant events near dates
          if (context.match(/(?:filed|announced|resigned|appointed|bankruptcy|acquired|launched|settled)/i)) {
            this.entities.events.push({
              date: date,
              context: context,
              source: url,
              title: title
            });
          }
        });
      }
      
      // Extract regulatory mentions
      const regulatoryPatterns = /(?:SEC|FEC|FDA|FTC|DOJ|FBI|IRS|EPA)\b/g;
      let regMatch;
      while ((regMatch = regulatoryPatterns.exec(content)) !== null) {
        const context = this.extractContext(content, regMatch[0], 200);
        if (context.toLowerCase().includes(this.targetName.toLowerCase())) {
          this.riskFactors.regulatory += 0.5;
          const citationId = this.addCitation(url, title);
          this.findings.high.push({
            type: 'regulatory',
            finding: `${regMatch[0]} involvement or mention`,
            details: context,
            source: url,
            citation: citationId
          });
        }
      }
      
      // Extract political contributions and bundling
      const politicalPatterns = /(?:bundled?|raised?|contributed?|donated?|fundrais|campaign|political|FEC|election)\s+(?:over\s+)?\$[\d,]+(?:K|thousand|million)?/gi;
      let politicalMatch;
      while ((politicalMatch = politicalPatterns.exec(content)) !== null) {
        const context = this.extractContext(content, politicalMatch[0], 200);
        const amountMatch = politicalMatch[0].match(/\$[\d,]+(?:K|thousand|million)?/);
        if (amountMatch) {
          const amount = this.parseMoneyAmount(amountMatch[0]);
          if (amount > 10000) { // Political contributions over $10K
            this.riskFactors.political += Math.min(2, amount / 100000); // Scale by amount
            const citationId = this.addCitation(url, title);
            this.findings.medium.push({
              type: 'political',
              finding: `Political contribution/bundling: ${amountMatch[0]}`,
              details: context,
              source: url,
              citation: citationId
            });
          }
        }
      }
      
      // Extract scandal/controversy indicators
      const scandalPatterns = /(?:scandal|fraud|investigation|probe|allegation|accused|violation|breach|misconduct|corruption)/gi;
      let scandalMatch;
      while ((scandalMatch = scandalPatterns.exec(content)) !== null) {
        const context = this.extractContext(content, scandalMatch[0], 200);
        if (context.toLowerCase().includes(this.targetName.toLowerCase())) {
          this.riskFactors.reputational += 1;
          const citationId = this.addCitation(url, title);
          this.patterns.scandal.push({
            type: scandalMatch[0],
            details: context,
            source: url,
            citation: citationId
          });
        }
      }
      
      // Extract achievements and positive mentions
      const achievementPatterns = /(?:award|honor|recognition|achievement|pioneer|first|landmark|success|victory|win)/gi;
      let achievementMatch;
      while ((achievementMatch = achievementPatterns.exec(content)) !== null) {
        const context = this.extractContext(content, achievementMatch[0], 150);
        if (context.toLowerCase().includes(this.targetName.toLowerCase())) {
          this.patterns.achievement.push({
            type: achievementMatch[0],
            details: context,
            source: url
          });
        }
      }
    }
    
    console.log(`[SYNTHESIS] Processed ${processedSources} sources with content`);
    console.log(`[SYNTHESIS] Extracted: ${this.entities.organizations.size} organizations, ${this.entities.people.size} people, ${this.entities.financials.length} financial items, ${this.entities.legal.length} legal items`);
  }

  /**
   * Identify patterns across extracted entities
   */
  identifyPatterns() {
    // Pattern: Multiple bankruptcies
    const bankruptcyMentions = this.entities.legal.filter(l => 
      l.type.includes('bankruptcy') || l.type.includes('chapter')
    );
    
    if (bankruptcyMentions.length > 0) {
      const uniqueSources = [...new Set(bankruptcyMentions.map(b => b.source))];
      this.findings.high.push({
        type: 'pattern',
        finding: `Bankruptcy involvement detected across ${uniqueSources.length} sources`,
        details: `Found ${bankruptcyMentions.length} bankruptcy-related mentions`,
        sources: uniqueSources
      });
      this.riskFactors.financial += bankruptcyMentions.length * 2;
    }
    
    // Pattern: Large financial exposures
    const largeAmounts = this.entities.financials.filter(f => f.amount > 10000000); // $10M+
    if (largeAmounts.length > 0) {
      largeAmounts.forEach(item => {
        const citationId = this.addCitation(item.source, item.title);
        this.findings.high.push({
          type: 'financial',
          finding: `Significant financial exposure: ${item.original}`,
          details: item.context,
          source: item.source,
          citation: citationId
        });
      });
      this.riskFactors.financial += largeAmounts.length * 3;
    }
    
    // Pattern: Litigation involvement
    if (this.patterns.lawsuit.length > 0) {
      const totalLawsuits = this.patterns.lawsuit.length;
      const uniqueLawsuits = [...new Set(this.patterns.lawsuit.map(l => l.source))].length;
      this.findings.critical.push({
        type: 'legal',
        finding: `Active litigation detected: ${totalLawsuits} references across ${uniqueLawsuits} sources`,
        details: this.patterns.lawsuit[0].details,
        citations: this.patterns.lawsuit.map(l => l.citation)
      });
      this.riskFactors.legal += totalLawsuits * 2;
    }
    
    // Pattern: Regulatory issues
    const secMentions = this.entities.legal.filter(l => l.context.includes('SEC'));
    if (secMentions.length > 0) {
      this.riskFactors.regulatory += secMentions.length * 1.5;
    }
    
    // Pattern: Board positions (from organization mentions)
    const boardPositions = [];
    this.entities.organizations.forEach((org, name) => {
      if (org.mentions > 2 && (name.includes('Inc') || name.includes('Corp') || name.includes('Ltd'))) {
        boardPositions.push(name);
      }
    });
    
    if (boardPositions.length > 0) {
      this.findings.medium.push({
        type: 'professional',
        finding: `Associated with ${boardPositions.length} corporate entities`,
        details: boardPositions.slice(0, 5).join(', ')
      });
    }
  }

  /**
   * Calculate risk scores based on actual evidence
   */
  calculateRiskScores() {
    // Normalize risk scores to 0-10 scale
    Object.keys(this.riskFactors).forEach(key => {
      this.riskFactors[key] = Math.min(10, this.riskFactors[key]);
    });
    
    // Calculate overall risk
    const totalRisk = Object.values(this.riskFactors).reduce((a, b) => a + b, 0);
    const avgRisk = totalRisk / Object.keys(this.riskFactors).length;
    
    this.overallRisk = avgRisk > 7 ? 'CRITICAL' :
                       avgRisk > 5 ? 'HIGH' :
                       avgRisk > 3 ? 'MEDIUM' :
                       avgRisk > 1 ? 'LOW' : 'MINIMAL';
    
    console.log(`[SYNTHESIS] Risk Assessment: ${this.overallRisk} (score: ${avgRisk.toFixed(1)})`);
    console.log(`[SYNTHESIS] Risk Factors:`, this.riskFactors);
  }

  /**
   * Generate the actual intelligence report with real extracted data
   */
  generateIntelligenceReport() {
    const report = {
      executive_summary: this.generateExecutiveSummary(),
      key_findings: this.generateKeyFindings(),
      entity_analysis: this.generateEntityAnalysis(),
      financial_intelligence: this.generateFinancialIntelligence(),
      legal_intelligence: this.generateLegalIntelligence(),
      risk_assessment: this.generateRiskAssessment(),
      timeline: this.generateTimeline(),
      recommendations: this.generateRecommendations(),
      citations: this.generateCitations(),
      metadata: {
        target: this.targetName,
        sources_processed: this.sources.length,
        entities_extracted: {
          people: this.entities.people.size,
          organizations: this.entities.organizations.size,
          financial_items: this.entities.financials.length,
          legal_items: this.entities.legal.length,
          events: this.entities.events.length
        },
        risk_level: this.overallRisk,
        generated_at: new Date().toISOString()
      }
    };
    
    return report;
  }

  /**
   * Generate executive summary with actual findings
   */
  generateExecutiveSummary() {
    let summary = `# EXECUTIVE SUMMARY: ${this.targetName}\n\n`;
    summary += `**Risk Assessment:** ${this.overallRisk}\n`;
    summary += `**Sources Analyzed:** ${this.sources.length}\n`;
    summary += `**Key Entities Identified:** ${this.entities.people.size + this.entities.organizations.size}\n\n`;
    
    if (this.findings.critical.length > 0) {
      summary += `## CRITICAL FINDINGS\n`;
      this.findings.critical.slice(0, 3).forEach(finding => {
        summary += `- **${finding.finding}**`;
        if (finding.citation) summary += `[${finding.citation}]`;
        summary += `\n`;
        if (finding.details) {
          summary += `  ${finding.details.substring(0, 200)}...\n`;
        }
      });
      summary += `\n`;
    }
    
    if (this.findings.high.length > 0) {
      summary += `## HIGH-PRIORITY FINDINGS\n`;
      this.findings.high.slice(0, 3).forEach(finding => {
        summary += `- ${finding.finding}`;
        if (finding.citation) summary += `[${finding.citation}]`;
        summary += `\n`;
      });
      summary += `\n`;
    }
    
    // Add quantified summary
    summary += `## INTELLIGENCE OVERVIEW\n`;
    
    if (this.entities.financials.length > 0) {
      const totalAmount = this.entities.financials.reduce((sum, f) => sum + f.amount, 0);
      if (totalAmount > 0) {
        summary += `- **Financial Exposure:** $${this.formatNumber(totalAmount)} across ${this.entities.financials.length} items\n`;
      }
    }
    
    if (this.patterns.lawsuit.length > 0) {
      summary += `- **Legal Matters:** ${this.patterns.lawsuit.length} litigation references identified\n`;
    }
    
    if (this.patterns.scandal.length > 0) {
      summary += `- **Reputational Concerns:** ${this.patterns.scandal.length} potential issues flagged\n`;
    }
    
    if (this.patterns.achievement.length > 0) {
      summary += `- **Positive Indicators:** ${this.patterns.achievement.length} achievements/recognitions noted\n`;
    }
    
    return summary;
  }

  /**
   * Generate key findings section with actual extracted data
   */
  generateKeyFindings() {
    let findings = `## KEY FINDINGS\n\n`;
    
    const allFindings = [
      ...this.findings.critical.map(f => ({...f, priority: 'CRITICAL'})),
      ...this.findings.high.map(f => ({...f, priority: 'HIGH'})),
      ...this.findings.medium.slice(0, 5).map(f => ({...f, priority: 'MEDIUM'}))
    ];
    
    if (allFindings.length === 0) {
      findings += `No significant findings identified from ${this.sources.length} sources analyzed.\n`;
      findings += `This may indicate:\n`;
      findings += `- Limited public information available\n`;
      findings += `- Clean record with no major issues\n`;
      findings += `- Need for deeper investigation with specialized sources\n`;
    } else {
      allFindings.forEach((finding, idx) => {
        findings += `### ${idx + 1}. [${finding.priority}] ${finding.finding}\n`;
        if (finding.details) {
          findings += `${finding.details}\n`;
        }
        if (finding.source) {
          findings += `Source: ${finding.source}\n`;
        }
        findings += `\n`;
      });
    }
    
    return findings;
  }

  /**
   * Generate entity analysis with extracted organizations and people
   */
  generateEntityAnalysis() {
    let analysis = `## ENTITY ANALYSIS\n\n`;
    
    // Top organizations by mentions
    if (this.entities.organizations.size > 0) {
      analysis += `### Key Organizations Identified\n`;
      const topOrgs = Array.from(this.entities.organizations.entries())
        .sort((a, b) => b[1].mentions - a[1].mentions)
        .slice(0, 10);
      
      topOrgs.forEach(([name, data]) => {
        analysis += `- **${name}** (${data.mentions} mentions across ${data.sources.length} sources)\n`;
        if (data.contexts[0]) {
          analysis += `  Context: "${data.contexts[0].substring(0, 150)}..."\n`;
        }
      });
      analysis += `\n`;
    }
    
    // Key people identified
    if (this.entities.people.size > 0) {
      analysis += `### Key People Identified\n`;
      this.entities.people.forEach((person, name) => {
        if (name !== this.targetName) {
          analysis += `- **${name}**`;
          if (person.titles.size > 0) {
            analysis += ` - ${Array.from(person.titles).join(', ')}`;
          }
          analysis += `\n`;
        }
      });
      analysis += `\n`;
    }
    
    return analysis;
  }

  /**
   * Generate financial intelligence from extracted monetary data
   */
  generateFinancialIntelligence() {
    let intel = `## FINANCIAL INTELLIGENCE\n\n`;
    
    if (this.entities.financials.length === 0) {
      intel += `No significant financial data extracted from available sources.\n`;
    } else {
      intel += `### Financial Exposures Identified\n`;
      
      // Group by magnitude
      const huge = this.entities.financials.filter(f => f.amount >= 100000000);
      const large = this.entities.financials.filter(f => f.amount >= 10000000 && f.amount < 100000000);
      const medium = this.entities.financials.filter(f => f.amount >= 1000000 && f.amount < 10000000);
      
      if (huge.length > 0) {
        intel += `\n#### Massive Exposures ($100M+)\n`;
        huge.forEach(item => {
          const citationId = this.addCitation(item.source, item.title);
          intel += `- **${item.original}**[${citationId}]\n`;
          intel += `  Context: "${item.context.substring(0, 200)}..."\n`;
        });
      }
      
      if (large.length > 0) {
        intel += `\n#### Large Exposures ($10M-$100M)\n`;
        large.forEach(item => {
          const citationId = this.addCitation(item.source, item.title);
          intel += `- ${item.original}[${citationId}] - ${item.title}\n`;
        });
      }
      
      if (medium.length > 0) {
        intel += `\n#### Significant Amounts ($1M-$10M)\n`;
        intel += `- ${medium.length} items totaling $${this.formatNumber(medium.reduce((s, i) => s + i.amount, 0))}\n`;
      }
      
      // Total exposure
      const total = this.entities.financials.reduce((sum, f) => sum + f.amount, 0);
      intel += `\n### Total Financial Exposure\n`;
      intel += `**$${this.formatNumber(total)}** across ${this.entities.financials.length} identified items\n`;
    }
    
    return intel;
  }

  /**
   * Generate legal intelligence from extracted legal data
   */
  generateLegalIntelligence() {
    let intel = `## LEGAL & REGULATORY INTELLIGENCE\n\n`;
    
    if (this.entities.legal.length === 0 && this.patterns.lawsuit.length === 0) {
      intel += `No legal matters identified in available sources.\n`;
    } else {
      if (this.patterns.lawsuit.length > 0) {
        intel += `### Active Litigation\n`;
        const uniqueLawsuits = this.consolidateLawsuits();
        uniqueLawsuits.forEach(lawsuit => {
          intel += `- **${lawsuit.type}**[${lawsuit.citation}]\n`;
          intel += `  Details: ${lawsuit.details.substring(0, 300)}...\n\n`;
        });
      }
      
      const bankruptcies = this.entities.legal.filter(l => l.type.includes('bankruptcy'));
      if (bankruptcies.length > 0) {
        intel += `### Bankruptcy Involvement\n`;
        bankruptcies.forEach(b => {
          const citationId = this.addCitation(b.source, b.title);
          intel += `- ${b.title}[${citationId}]\n`;
          intel += `  Context: "${b.context.substring(0, 200)}..."\n`;
        });
        intel += `\n`;
      }
      
      const regulatory = this.entities.legal.filter(l => 
        l.context.match(/SEC|FEC|FDA|FTC|DOJ|FBI|IRS|EPA/)
      );
      if (regulatory.length > 0) {
        intel += `### Regulatory Mentions\n`;
        regulatory.forEach(r => {
          const agency = r.context.match(/SEC|FEC|FDA|FTC|DOJ|FBI|IRS|EPA/)[0];
          const citationId = this.addCitation(r.source, r.title);
          intel += `- **${agency}** involvement mentioned[${citationId}]\n`;
        });
      }
    }
    
    return intel;
  }

  /**
   * Generate risk assessment based on calculated scores
   */
  generateRiskAssessment() {
    let assessment = `## RISK ASSESSMENT\n\n`;
    assessment += `### Overall Risk Level: ${this.overallRisk}\n\n`;
    
    assessment += `### Risk Factor Breakdown\n`;
    assessment += `| Category | Score | Level | Key Drivers |\n`;
    assessment += `|----------|-------|-------|-------------|\n`;
    
    Object.entries(this.riskFactors).forEach(([category, score]) => {
      const level = score > 7 ? 'CRITICAL' : score > 5 ? 'HIGH' : score > 3 ? 'MEDIUM' : score > 1 ? 'LOW' : 'MINIMAL';
      let drivers = '';
      
      switch(category) {
        case 'legal':
          drivers = this.patterns.lawsuit.length > 0 ? `${this.patterns.lawsuit.length} litigation items` : 'No issues found';
          break;
        case 'financial':
          drivers = this.entities.financials.length > 0 ? `$${this.formatNumber(this.entities.financials.reduce((s, f) => s + f.amount, 0))} exposure` : 'No issues found';
          break;
        case 'reputational':
          drivers = this.patterns.scandal.length > 0 ? `${this.patterns.scandal.length} concerns identified` : 'Clean record';
          break;
        case 'regulatory':
          drivers = score > 0 ? 'Agency mentions detected' : 'No regulatory issues';
          break;
        case 'political':
          drivers = score > 0 ? 'Political exposure identified' : 'No political involvement';
          break;
      }
      
      assessment += `| ${category.charAt(0).toUpperCase() + category.slice(1)} | ${score.toFixed(1)}/10 | ${level} | ${drivers} |\n`;
    });
    
    assessment += `\n### Risk Trajectory\n`;
    if (this.patterns.lawsuit.length > 0 || this.patterns.scandal.length > 0) {
      assessment += `**Increasing** - Active issues requiring monitoring\n`;
    } else if (this.patterns.achievement.length > this.patterns.scandal.length) {
      assessment += `**Stable/Positive** - More positive indicators than negative\n`;
    } else {
      assessment += `**Stable** - No significant changes detected\n`;
    }
    
    return assessment;
  }

  /**
   * Generate timeline from extracted events
   */
  generateTimeline() {
    let timeline = `## CHRONOLOGICAL TIMELINE\n\n`;
    
    if (this.entities.events.length === 0) {
      timeline += `No dated events extracted from sources.\n`;
    } else {
      // Sort events by date (approximation)
      const sortedEvents = this.entities.events.sort((a, b) => {
        const yearA = parseInt(a.date.match(/\d{4}/)?.[0] || '0');
        const yearB = parseInt(b.date.match(/\d{4}/)?.[0] || '0');
        return yearB - yearA; // Most recent first
      });
      
      sortedEvents.slice(0, 10).forEach(event => {
        const citationId = this.addCitation(event.source, event.title);
        timeline += `### ${event.date}\n`;
        timeline += `${event.context}[${citationId}]\n\n`;
      });
    }
    
    return timeline;
  }

  /**
   * Generate actionable recommendations based on findings
   */
  generateRecommendations() {
    const recs = [];
    
    // Critical recommendations
    if (this.findings.critical.length > 0) {
      recs.push('**IMMEDIATE ACTION:** Address critical findings identified in this report');
      this.findings.critical.forEach(f => {
        if (f.type === 'legal') {
          recs.push('Conduct thorough legal review of active litigation exposure');
        } else if (f.type === 'financial') {
          recs.push('Perform detailed financial due diligence on large exposures identified');
        }
      });
    }
    
    // High-priority recommendations
    if (this.riskFactors.legal > 5) {
      recs.push('Engage legal counsel to assess litigation risk and develop mitigation strategy');
    }
    
    if (this.riskFactors.financial > 5) {
      recs.push('Commission forensic financial analysis to verify exposures and obligations');
    }
    
    if (this.riskFactors.reputational > 5) {
      recs.push('Implement reputation monitoring and crisis communication protocols');
    }
    
    if (this.riskFactors.regulatory > 3) {
      recs.push('Review regulatory compliance status and address any deficiencies');
    }
    
    // Standard recommendations
    if (this.sources.length < 40) {
      recs.push(`Expand intelligence gathering - only ${this.sources.length} sources analyzed (minimum 40 recommended)`);
    }
    
    recs.push('Schedule follow-up intelligence review in 90 days');
    recs.push('Monitor identified entities and organizations for new developments');
    
    let recommendations = `## RECOMMENDATIONS\n\n`;
    recs.forEach((rec, idx) => {
      recommendations += `${idx + 1}. ${rec}\n`;
    });
    
    return recommendations;
  }

  /**
   * Generate citations section
   */
  generateCitations() {
    let citations = `## SOURCES & CITATIONS\n\n`;
    
    this.citations.forEach((data, id) => {
      citations += `[${id}]: ${data.title || 'Untitled'} - ${data.url}\n`;
    });
    
    citations += `\n**Total Sources:** ${this.sources.length}\n`;
    citations += `**Sources with Content:** ${this.sources.filter(s => s.markdown && s.markdown.length > 100).length}\n`;
    citations += `**Unique Citations:** ${this.citations.size}\n`;
    
    return citations;
  }

  // Utility functions
  
  extractContext(content, searchTerm, contextLength = 150) {
    const index = content.indexOf(searchTerm);
    if (index === -1) return '';
    
    const start = Math.max(0, index - contextLength);
    const end = Math.min(content.length, index + searchTerm.length + contextLength);
    
    return content.substring(start, end).replace(/\n/g, ' ').trim();
  }
  
  parseMoneyAmount(moneyString) {
    let amount = parseFloat(moneyString.replace(/[$,]/g, ''));
    
    if (moneyString.toLowerCase().includes('billion') || moneyString.includes('B')) {
      amount *= 1000000000;
    } else if (moneyString.toLowerCase().includes('million') || moneyString.includes('M')) {
      amount *= 1000000;
    } else if (moneyString.toLowerCase().includes('thousand') || moneyString.includes('K')) {
      amount *= 1000;
    }
    
    return amount;
  }
  
  formatNumber(num) {
    if (num >= 1000000000) {
      return (num / 1000000000).toFixed(1) + 'B';
    } else if (num >= 1000000) {
      return (num / 1000000).toFixed(1) + 'M';
    } else if (num >= 1000) {
      return (num / 1000).toFixed(0) + 'K';
    }
    return num.toFixed(0);
  }
  
  addCitation(url, title) {
    // Check if we already have this citation
    let citationId = null;
    this.citations.forEach((data, id) => {
      if (data.url === url) {
        citationId = id;
      }
    });
    
    if (!citationId) {
      citationId = `^${this.citationCounter}`;
      this.citations.set(citationId, { url, title });
      this.citationCounter++;
    }
    
    return citationId;
  }
  
  consolidateLawsuits() {
    // Group similar lawsuits together
    const consolidated = [];
    const seen = new Set();
    
    this.patterns.lawsuit.forEach(lawsuit => {
      const key = lawsuit.details.substring(0, 50);
      if (!seen.has(key)) {
        seen.add(key);
        consolidated.push(lawsuit);
      }
    });
    
    return consolidated;
  }
}

module.exports = IntelligentSynthesisEngine;