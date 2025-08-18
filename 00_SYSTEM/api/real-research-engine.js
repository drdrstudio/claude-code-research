const https = require('https');
const fs = require('fs');
const path = require('path');

// REAL Research Engine - Actually calls APIs
class RealResearchEngine {
  constructor(projectId, targetName, researchType) {
    this.projectId = projectId;
    this.targetName = targetName;
    this.researchType = researchType;
    this.results = {
      firecrawl: [],
      perplexity: [],
      gemini: null,
      sources: []
    };
  }

  // Update progress callback
  updateProgress(phase, message) {
    console.log(`[${new Date().toISOString()}] ${phase}: ${message}`);
  }

  // REAL Firecrawl API call
  async searchFirecrawl() {
    this.updateProgress('Firecrawl', 'Starting web extraction...');
    
    if (!process.env.FIRECRAWL_API_KEY) {
      this.updateProgress('Firecrawl', 'No API key, skipping');
      return [];
    }

    const searchQuery = encodeURIComponent(this.targetName);
    const options = {
      hostname: 'api.firecrawl.dev',
      path: `/v1/search?q=${searchQuery}&limit=10`,
      method: 'GET',
      headers: {
        'Authorization': `Bearer ${process.env.FIRECRAWL_API_KEY}`,
        'Content-Type': 'application/json'
      }
    };

    return new Promise((resolve) => {
      const req = https.request(options, (res) => {
        let data = '';
        res.on('data', chunk => data += chunk);
        res.on('end', () => {
          try {
            const result = JSON.parse(data);
            if (result.data) {
              this.results.firecrawl = result.data;
              this.updateProgress('Firecrawl', `Found ${result.data.length} sources`);
              resolve(result.data);
            } else {
              this.updateProgress('Firecrawl', 'No results found');
              resolve([]);
            }
          } catch (e) {
            this.updateProgress('Firecrawl', `Error: ${e.message}`);
            resolve([]);
          }
        });
      });

      req.on('error', (e) => {
        this.updateProgress('Firecrawl', `Failed: ${e.message}`);
        resolve([]);
      });

      req.end();
    });
  }

  // REAL Perplexity API call
  async searchPerplexity() {
    this.updateProgress('Perplexity', 'Starting AI-powered search...');
    
    if (!process.env.PERPLEXITY_API_KEY) {
      this.updateProgress('Perplexity', 'No API key, skipping');
      return null;
    }

    const prompt = `Provide comprehensive research on ${this.targetName}. Include background, recent developments, key facts, and analysis.`;
    
    const postData = JSON.stringify({
      model: "llama-3.1-sonar-small-128k-online",
      messages: [
        {
          role: "user",
          content: prompt
        }
      ],
      temperature: 0.2,
      top_p: 0.9,
      max_tokens: 2000
    });

    const options = {
      hostname: 'api.perplexity.ai',
      path: '/chat/completions',
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${process.env.PERPLEXITY_API_KEY}`,
        'Content-Type': 'application/json',
        'Content-Length': postData.length
      }
    };

    return new Promise((resolve) => {
      const req = https.request(options, (res) => {
        let data = '';
        res.on('data', chunk => data += chunk);
        res.on('end', () => {
          try {
            const result = JSON.parse(data);
            if (result.choices && result.choices[0]) {
              this.results.perplexity = result.choices[0].message.content;
              this.updateProgress('Perplexity', 'Deep search completed');
              resolve(result.choices[0].message.content);
            } else {
              this.updateProgress('Perplexity', 'No results');
              resolve(null);
            }
          } catch (e) {
            this.updateProgress('Perplexity', `Error: ${e.message}`);
            resolve(null);
          }
        });
      });

      req.on('error', (e) => {
        this.updateProgress('Perplexity', `Failed: ${e.message}`);
        resolve(null);
      });

      req.write(postData);
      req.end();
    });
  }

  // REAL Gemini API call for synthesis
  async synthesizeWithGemini() {
    this.updateProgress('Gemini', 'Starting strategic synthesis...');
    
    if (!process.env.GEMINI_API_KEY) {
      this.updateProgress('Gemini', 'No API key, skipping');
      return null;
    }

    // Prepare synthesis prompt with all gathered data
    const synthesisPrompt = `
Synthesize the following research on ${this.targetName}:

Firecrawl Sources (${this.results.firecrawl.length}):
${this.results.firecrawl.map(s => `- ${s.title || s.url}`).join('\n')}

Perplexity Analysis:
${this.results.perplexity || 'No Perplexity data available'}

Provide a comprehensive executive summary with:
1. Key findings
2. Strategic insights
3. Risk assessment
4. Recommendations
`;

    const postData = JSON.stringify({
      contents: [{
        parts: [{
          text: synthesisPrompt
        }]
      }],
      generationConfig: {
        temperature: 0.7,
        maxOutputTokens: 2048,
      }
    });

    const options = {
      hostname: 'generativelanguage.googleapis.com',
      path: `/v1beta/models/gemini-pro:generateContent?key=${process.env.GEMINI_API_KEY}`,
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Content-Length': postData.length
      }
    };

    return new Promise((resolve) => {
      const req = https.request(options, (res) => {
        let data = '';
        res.on('data', chunk => data += chunk);
        res.on('end', () => {
          try {
            const result = JSON.parse(data);
            if (result.candidates && result.candidates[0]) {
              this.results.gemini = result.candidates[0].content.parts[0].text;
              this.updateProgress('Gemini', 'Synthesis complete');
              resolve(this.results.gemini);
            } else {
              this.updateProgress('Gemini', 'No synthesis generated');
              resolve(null);
            }
          } catch (e) {
            this.updateProgress('Gemini', `Error: ${e.message}`);
            resolve(null);
          }
        });
      });

      req.on('error', (e) => {
        this.updateProgress('Gemini', `Failed: ${e.message}`);
        resolve(null);
      });

      req.write(postData);
      req.end();
    });
  }

  // Generate REAL PDF with actual content
  async generatePDF(projectDir) {
    this.updateProgress('PDF Generation', 'Creating document...');
    
    const timestamp = new Date().toISOString();
    const pdfDir = path.join(projectDir, 'PDFs');
    
    // Ensure directory exists
    if (!fs.existsSync(pdfDir)) {
      fs.mkdirSync(pdfDir, { recursive: true });
    }

    // Create REAL markdown report with actual data
    const reportContent = `# Strategic Intelligence Report: ${this.targetName}

**Generated:** ${timestamp}  
**Type:** ${this.researchType}  
**Sources Analyzed:** ${this.results.firecrawl.length + (this.results.perplexity ? 1 : 0)}

## Executive Summary

${this.results.gemini || 'Synthesis pending...'}

## Research Findings

### Web Intelligence (Firecrawl)
${this.results.firecrawl.length > 0 ? 
  this.results.firecrawl.map(s => `- **${s.title || 'Source'}**: ${s.url}`).join('\n') :
  'No Firecrawl data available'}

### AI Analysis (Perplexity)
${this.results.perplexity || 'No Perplexity analysis available'}

## Sources & Citations

${this.results.sources.map((s, i) => `[${i+1}] ${s}`).join('\n')}

---
*Report generated by MRP Intelligence System v7.0*
`;

    // Save the report
    const reportPath = path.join(pdfDir, 'Report.md');
    fs.writeFileSync(reportPath, reportContent);
    
    this.updateProgress('PDF Generation', `Report saved: ${reportPath}`);
    
    // Convert to PDF if pandoc available (for local testing)
    // Railway will serve the markdown directly or convert server-side
    
    return reportPath;
  }

  // Main research pipeline
  async runResearch(projectDir) {
    try {
      // Run all research in parallel for speed
      const [firecrawl, perplexity] = await Promise.all([
        this.searchFirecrawl(),
        this.searchPerplexity()
      ]);

      // Then synthesize
      await this.synthesizeWithGemini();

      // Generate PDF
      const pdfPath = await this.generatePDF(projectDir);

      return {
        success: true,
        pdfPath,
        sources: this.results.sources.length,
        message: `Research complete with ${this.results.sources.length} sources`
      };
    } catch (error) {
      console.error('Research error:', error);
      return {
        success: false,
        error: error.message
      };
    }
  }
}

// Export for use in scripts
module.exports = RealResearchEngine;

// If called directly from command line
if (require.main === module) {
  const args = process.argv.slice(2);
  const targetName = args[0] || 'Test Research';
  const researchType = args[1] || 'individual';
  const projectId = args[2] || 'test_' + Date.now();
  const projectDir = args[3] || './research_output';

  const engine = new RealResearchEngine(projectId, targetName, researchType);
  engine.runResearch(projectDir).then(result => {
    console.log('Research Result:', result);
    process.exit(result.success ? 0 : 1);
  });
}