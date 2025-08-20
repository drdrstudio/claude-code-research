#!/usr/bin/env node

/**
 * FINAL CERTIFICATION TEST - Youngblood Protocol
 * Tests the intelligent synthesis engine with live Vercel deployment
 */

const https = require('https');
const fs = require('fs');
const path = require('path');

// Test configuration
const VERCEL_API_URL = 'mrp-intelligence.vercel.app';
const TEST_TARGET = 'Sam Altman'; // Test with a well-known figure for validation
const OUTPUT_DIR = path.join(__dirname, 'certification-output');

// Ensure output directory exists
if (!fs.existsSync(OUTPUT_DIR)) {
  fs.mkdirSync(OUTPUT_DIR, { recursive: true });
}

console.log('='.repeat(80));
console.log('FINAL CERTIFICATION TEST - YOUNGBLOOD PROTOCOL v6.1.8');
console.log('Deployment: https://mrp-intelligence.vercel.app');
console.log('='.repeat(80));

/**
 * Make API request to Vercel deployment
 */
async function runCertificationTest() {
  console.log(`\n[CERT] Starting certification test for: ${TEST_TARGET}`);
  console.log('[CERT] Endpoint: https://mrp-intelligence.vercel.app/api/mrp/research');
  
  const requestData = JSON.stringify({
    target: TEST_TARGET,
    type: 'individual'
  });

  const options = {
    protocol: 'https:',
    hostname: VERCEL_API_URL,
    path: '/api/mrp/research',
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Content-Length': Buffer.byteLength(requestData)
    },
    timeout: 180000 // 3 minutes for full 6-phase research
  };

  return new Promise((resolve, reject) => {
    console.log('[CERT] Sending research request to Vercel API...');
    
    const req = https.request(options, (res) => {
      let data = '';
      
      res.on('data', (chunk) => {
        data += chunk;
        // Show progress
        if (data.includes('progress')) {
          try {
            const lines = data.split('\n').filter(line => line.trim());
            const lastLine = lines[lines.length - 1];
            if (lastLine.includes('progress')) {
              const progress = JSON.parse(lastLine);
              process.stdout.write(`\r[CERT] ${progress.phase || 'Processing'}: ${progress.progress || 0}%`);
            }
          } catch (e) {
            // Ignore parse errors during streaming
          }
        }
      });

      res.on('end', () => {
        console.log('\n[CERT] Response received, processing results...');
        
        try {
          // Parse the final JSON response
          const lines = data.split('\n').filter(line => line.trim());
          const finalResponse = lines.find(line => line.includes('"success"'));
          
          if (finalResponse) {
            const result = JSON.parse(finalResponse);
            
            if (result.success) {
              console.log('[CERT] ✅ Research completed successfully!');
              
              // Save full response
              const responseFile = path.join(OUTPUT_DIR, 'api-response.json');
              fs.writeFileSync(responseFile, JSON.stringify(result, null, 2));
              console.log(`[CERT] Full response saved to: ${responseFile}`);
              
              // Extract and save the synthesis report if available
              if (result.data && result.data.synthesis) {
                const reportFile = path.join(OUTPUT_DIR, 'synthesis-report.md');
                
                // Format the synthesis report
                let report = `# CERTIFICATION TEST REPORT - ${TEST_TARGET}\n\n`;
                report += `Generated: ${new Date().toISOString()}\n\n`;
                report += `---\n\n`;
                
                const synthesis = result.data.synthesis;
                
                if (synthesis.executive_summary) {
                  report += synthesis.executive_summary + '\n\n---\n\n';
                }
                
                if (synthesis.key_findings) {
                  report += synthesis.key_findings + '\n\n---\n\n';
                }
                
                if (synthesis.entity_analysis) {
                  report += synthesis.entity_analysis + '\n\n---\n\n';
                }
                
                if (synthesis.financial_intelligence) {
                  report += synthesis.financial_intelligence + '\n\n---\n\n';
                }
                
                if (synthesis.legal_intelligence) {
                  report += synthesis.legal_intelligence + '\n\n---\n\n';
                }
                
                if (synthesis.risk_assessment) {
                  report += synthesis.risk_assessment + '\n\n---\n\n';
                }
                
                if (synthesis.timeline) {
                  report += synthesis.timeline + '\n\n---\n\n';
                }
                
                if (synthesis.recommendations) {
                  report += synthesis.recommendations + '\n\n---\n\n';
                }
                
                if (synthesis.citations) {
                  report += synthesis.citations + '\n\n';
                }
                
                fs.writeFileSync(reportFile, report);
                console.log(`[CERT] Synthesis report saved to: ${reportFile}`);
                
                // Validate the synthesis quality
                validateSynthesisQuality(synthesis, result.data);
              }
              
              resolve(result);
            } else {
              console.error('[CERT] ❌ Research failed:', result.error);
              reject(new Error(result.error));
            }
          } else {
            console.error('[CERT] ❌ Invalid response format');
            console.error('[CERT] Raw response:', data.substring(0, 500));
            reject(new Error('Invalid response format'));
          }
        } catch (error) {
          console.error('[CERT] ❌ Error parsing response:', error.message);
          console.error('[CERT] Raw data:', data.substring(0, 500));
          reject(error);
        }
      });
    });

    req.on('error', (error) => {
      console.error('[CERT] ❌ Request error:', error.message);
      reject(error);
    });

    req.on('timeout', () => {
      console.error('[CERT] ❌ Request timeout after 3 minutes');
      req.destroy();
      reject(new Error('Request timeout'));
    });

    req.write(requestData);
    req.end();
  });
}

/**
 * Validate synthesis quality against Youngblood Protocol standards
 */
function validateSynthesisQuality(synthesis, fullData) {
  console.log('\n' + '='.repeat(80));
  console.log('SYNTHESIS QUALITY VALIDATION');
  console.log('='.repeat(80));
  
  const checks = [];
  
  // Check for real entity extraction
  if (synthesis.entity_analysis) {
    const hasOrganizations = synthesis.entity_analysis.includes('Key Organizations');
    const hasPeople = synthesis.entity_analysis.includes('Key People');
    checks.push({
      name: 'Entity extraction (organizations & people)',
      passed: hasOrganizations || hasPeople,
      details: `Organizations: ${hasOrganizations}, People: ${hasPeople}`
    });
  }
  
  // Check for real financial data
  if (synthesis.financial_intelligence) {
    const hasAmounts = /\$[\d,]+(?:\.\d{2})?(?:\s*(?:million|billion|M|B))?/i.test(synthesis.financial_intelligence);
    const notTemplate = !synthesis.financial_intelligence.includes('No significant financial data');
    checks.push({
      name: 'Financial data extraction',
      passed: hasAmounts && notTemplate,
      details: `Found monetary amounts: ${hasAmounts}`
    });
  }
  
  // Check for risk assessment based on evidence
  if (synthesis.risk_assessment) {
    const hasRiskLevel = /Risk Level: (CRITICAL|HIGH|MEDIUM|LOW|MINIMAL)/i.test(synthesis.risk_assessment);
    const hasRiskFactors = synthesis.risk_assessment.includes('Risk Factor Breakdown');
    checks.push({
      name: 'Evidence-based risk assessment',
      passed: hasRiskLevel && hasRiskFactors,
      details: `Risk level: ${hasRiskLevel}, Factors: ${hasRiskFactors}`
    });
  }
  
  // Check for proper citations
  if (synthesis.citations) {
    const citationCount = (synthesis.citations.match(/\[\^?\d+\]/g) || []).length;
    checks.push({
      name: 'Citation system',
      passed: citationCount > 10,
      details: `${citationCount} citations found`
    });
  }
  
  // Check source count
  if (fullData.phase1 && fullData.phase1.sources) {
    const sourceCount = fullData.phase1.sources.length;
    checks.push({
      name: 'Source minimum (40-50 required)',
      passed: sourceCount >= 40,
      details: `${sourceCount} sources collected`
    });
  }
  
  // Check for specific findings (not templates)
  const hasSpecificFindings = synthesis.key_findings && 
    !synthesis.key_findings.includes('No significant findings') &&
    synthesis.key_findings.length > 500;
  checks.push({
    name: 'Specific findings (not templates)',
    passed: hasSpecificFindings,
    details: hasSpecificFindings ? 'Contains detailed findings' : 'Generic template text'
  });
  
  // Check for executive summary quality
  const hasExecutiveSummary = synthesis.executive_summary &&
    synthesis.executive_summary.includes(TEST_TARGET) &&
    synthesis.executive_summary.length > 300;
  checks.push({
    name: 'Executive summary quality',
    passed: hasExecutiveSummary,
    details: hasExecutiveSummary ? 'Comprehensive summary' : 'Missing or inadequate'
  });
  
  // Check for timeline/chronology
  const hasTimeline = synthesis.timeline && 
    (synthesis.timeline.includes('202') || synthesis.timeline.includes('201'));
  checks.push({
    name: 'Chronological timeline',
    passed: hasTimeline,
    details: hasTimeline ? 'Timeline with dates' : 'No timeline data'
  });
  
  // Display validation results
  console.log('\nValidation Results:');
  console.log('-'.repeat(40));
  
  checks.forEach(check => {
    const icon = check.passed ? '✅' : '❌';
    console.log(`${icon} ${check.name}`);
    if (check.details) {
      console.log(`   └─ ${check.details}`);
    }
  });
  
  const passedChecks = checks.filter(c => c.passed).length;
  const totalChecks = checks.length;
  const successRate = (passedChecks / totalChecks * 100).toFixed(1);
  
  console.log('-'.repeat(40));
  console.log(`\nOVERALL SCORE: ${passedChecks}/${totalChecks} (${successRate}%)`);
  
  if (successRate >= 75) {
    console.log('\n🎉 CERTIFICATION PASSED - Youngblood Protocol Working!');
  } else if (successRate >= 50) {
    console.log('\n⚠️ PARTIAL SUCCESS - Synthesis needs improvement');
  } else {
    console.log('\n❌ CERTIFICATION FAILED - Major issues with synthesis');
  }
  
  // Specific recommendations
  console.log('\nRecommendations:');
  checks.filter(c => !c.passed).forEach(check => {
    console.log(`- Fix: ${check.name}`);
  });
  
  return successRate >= 75;
}

// Run the certification test
async function main() {
  try {
    console.log('\n[CERT] Initializing certification test...');
    const result = await runCertificationTest();
    
    console.log('\n' + '='.repeat(80));
    console.log('CERTIFICATION TEST COMPLETE');
    console.log('='.repeat(80));
    
    // Summary statistics
    if (result.data) {
      console.log('\nResearch Statistics:');
      console.log(`- Target: ${TEST_TARGET}`);
      console.log(`- Execution Time: ${result.executionTime || 'Unknown'}`);
      console.log(`- Total Sources: ${result.data.phase1?.sources?.length || 0}`);
      console.log(`- Phases Completed: ${result.data.phasesCompleted || 'Unknown'}`);
      
      if (result.data.synthesis?.metadata) {
        const meta = result.data.synthesis.metadata;
        console.log(`- Risk Level: ${meta.risk_level || 'Not assessed'}`);
        console.log(`- Entities Extracted: ${JSON.stringify(meta.entities_extracted || {})}`);
      }
    }
    
    console.log('\n✅ Certification test completed successfully');
    console.log(`📁 Results saved to: ${OUTPUT_DIR}`);
    
  } catch (error) {
    console.error('\n❌ Certification test failed:', error.message);
    process.exit(1);
  }
}

// Execute
main();