#!/usr/bin/env node

/**
 * Test script for the Intelligent Synthesis Engine
 * Tests with sample data similar to what would be collected in Phase 1
 */

const IntelligentSynthesisEngine = require('./intelligent-synthesis-engine');
const fs = require('fs');
const path = require('path');

// Sample sources with real-like content
const testSources = [
  {
    url: 'https://www.wsj.com/articles/conocophillips-lawsuit',
    title: 'Texas Businessman Sues ConocoPhillips for $900 Million',
    markdown: `
      Texas businessman Kneeland Youngblood has filed a lawsuit against energy giant ConocoPhillips,
      seeking $900 million in damages related to ancestral land rights. The lawsuit, filed in federal court
      in November 2023, claims that ConocoPhillips has been extracting resources from land that belonged
      to Youngblood's ancestors. The case represents one of the largest individual claims against a major
      energy corporation in recent years. Youngblood, who is the founder and CEO of Pharos Capital Group,
      a healthcare-focused private equity firm, is being represented by prominent attorneys in this matter.
    `
  },
  {
    url: 'https://www.healthcarefinancenews.com/charter-bankruptcy',
    title: 'Charter Healthcare Files for Chapter 11 Bankruptcy',
    markdown: `
      Charter Healthcare, a portfolio company of Pharos Capital Group, has filed for Chapter 11 bankruptcy
      protection with $37 million in liabilities. The bankruptcy affects approximately 13,000 patients
      across multiple facilities. The filing comes amid broader challenges in the healthcare services sector.
      Pharos Capital, led by Kneeland Youngblood, had acquired Charter Healthcare in 2019 as part of its
      healthcare services investment strategy. This represents one of the most significant portfolio failures
      for the Dallas-based private equity firm.
    `
  },
  {
    url: 'https://www.sec.gov/edgar/pharos-capital',
    title: 'SEC Registration Status - Pharos Capital Group',
    markdown: `
      Pharos Capital Group's SEC registration has been revoked as of 2024. The firm, founded by
      Kneeland Youngblood in 1997, previously managed over $785 million in assets under management.
      The revocation affects the firm's ability to raise funds from certain institutional investors.
      No enforcement action was associated with the registration revocation, which appears to be
      administrative in nature.
    `
  },
  {
    url: 'https://www.fec.gov/data/contributions',
    title: 'FEC Political Contribution Records',
    markdown: `
      Federal Election Commission records show that Kneeland Youngblood bundled over $317,000
      for Hillary Clinton's presidential campaigns. Youngblood served as a major fundraiser for
      the 2016 campaign, hosting events and coordinating donations from his network. He has also
      made personal contributions to various Democratic candidates and causes over the years.
    `
  },
  {
    url: 'https://www.blackenterprise.com/youngblood-profile',
    title: 'Kneeland Youngblood: From Emergency Room to Boardroom',
    markdown: `
      Kneeland Youngblood, 69, represents a unique success story in American business. Born in 1955
      in Galena Park, Texas, Youngblood graduated from Princeton University in 1978 and earned his M.D.
      from UT Southwestern in 1982. He spent 12 years as an emergency physician at Parkland Hospital
      in Dallas before founding Pharos Capital Group in 1997. In 2014, he became the first African American
      member of the Dallas Country Club. He currently serves on the boards of Light & Wonder Inc,
      California Institute of Technology, and the Milken Institute. In 2022, he resigned from the board
      of Mallinckrodt plc during the company's bankruptcy proceedings related to opioid litigation.
    `
  },
  {
    url: 'https://www.dallasnews.com/business/pharos-capital',
    title: 'Pharos Capital Portfolio Company Struggles',
    markdown: `
      Several portfolio companies of Pharos Capital Group are facing financial difficulties in the
      post-COVID healthcare environment. The firm, led by Kneeland Youngblood, has seen mixed results
      across its 50+ portfolio company investments. Industry sources suggest the firm is having
      difficulty raising new funds following the Charter Healthcare bankruptcy and other portfolio
      challenges. Youngblood has not responded to requests for comment.
    `
  }
];

async function testSynthesis() {
  console.log('='.repeat(80));
  console.log('TESTING INTELLIGENT SYNTHESIS ENGINE - YOUNGBLOOD PROTOCOL');
  console.log('='.repeat(80));
  
  // Create test project directory
  const testProjectPath = path.join(__dirname, 'test-synthesis-output');
  if (!fs.existsSync(testProjectPath)) {
    fs.mkdirSync(testProjectPath, { recursive: true });
  }
  
  // Initialize the engine
  const engine = new IntelligentSynthesisEngine(
    'Kneeland Youngblood',
    testSources,
    testProjectPath
  );
  
  // Process the sources
  console.log('\nProcessing test sources...\n');
  const report = await engine.process();
  
  // Display results
  console.log('='.repeat(80));
  console.log('SYNTHESIS RESULTS');
  console.log('='.repeat(80));
  
  console.log('\nMETADATA:');
  console.log(JSON.stringify(report.metadata, null, 2));
  
  console.log('\n' + '='.repeat(80));
  console.log('EXECUTIVE SUMMARY:');
  console.log('='.repeat(80));
  console.log(report.executive_summary);
  
  console.log('\n' + '='.repeat(80));
  console.log('KEY FINDINGS:');
  console.log('='.repeat(80));
  console.log(report.key_findings);
  
  console.log('\n' + '='.repeat(80));
  console.log('FINANCIAL INTELLIGENCE:');
  console.log('='.repeat(80));
  console.log(report.financial_intelligence);
  
  console.log('\n' + '='.repeat(80));
  console.log('LEGAL INTELLIGENCE:');
  console.log('='.repeat(80));
  console.log(report.legal_intelligence);
  
  console.log('\n' + '='.repeat(80));
  console.log('RISK ASSESSMENT:');
  console.log('='.repeat(80));
  console.log(report.risk_assessment);
  
  // Save full report to file
  const fullReport = `# INTELLIGENT SYNTHESIS TEST REPORT\n\n` +
    `Generated: ${new Date().toISOString()}\n\n` +
    `---\n\n` +
    report.executive_summary + '\n\n---\n\n' +
    report.key_findings + '\n\n---\n\n' +
    report.entity_analysis + '\n\n---\n\n' +
    report.financial_intelligence + '\n\n---\n\n' +
    report.legal_intelligence + '\n\n---\n\n' +
    report.risk_assessment + '\n\n---\n\n' +
    report.timeline + '\n\n---\n\n' +
    report.recommendations + '\n\n---\n\n' +
    report.citations;
  
  const outputPath = path.join(testProjectPath, 'test-synthesis-report.md');
  fs.writeFileSync(outputPath, fullReport);
  
  console.log('\n' + '='.repeat(80));
  console.log(`Full report saved to: ${outputPath}`);
  console.log('='.repeat(80));
  
  // Validate extraction quality
  console.log('\nVALIDATION CHECKS:');
  console.log('-'.repeat(40));
  
  const checks = [
    {
      name: 'Extracted $900M lawsuit',
      passed: fullReport.includes('$900') && fullReport.includes('million')
    },
    {
      name: 'Extracted Charter Healthcare bankruptcy',
      passed: fullReport.includes('Charter Healthcare') && fullReport.includes('bankruptcy')
    },
    {
      name: 'Extracted $37M liabilities',
      passed: fullReport.includes('$37') || fullReport.includes('37M')
    },
    {
      name: 'Extracted 13,000 patients',
      passed: fullReport.includes('13,000') || fullReport.includes('13000')
    },
    {
      name: 'Extracted SEC registration revoked',
      passed: fullReport.includes('SEC') && fullReport.includes('revoked')
    },
    {
      name: 'Extracted $317K political bundling',
      passed: fullReport.includes('$317') || fullReport.includes('317,000')
    },
    {
      name: 'Generated risk assessment from evidence',
      passed: report.metadata.risk_level !== 'MINIMAL'
    },
    {
      name: 'Created proper citations',
      passed: report.citations.includes('[^')
    }
  ];
  
  checks.forEach(check => {
    console.log(`${check.passed ? '✅' : '❌'} ${check.name}`);
  });
  
  const passedChecks = checks.filter(c => c.passed).length;
  const totalChecks = checks.length;
  const successRate = (passedChecks / totalChecks * 100).toFixed(1);
  
  console.log('-'.repeat(40));
  console.log(`SUCCESS RATE: ${passedChecks}/${totalChecks} (${successRate}%)`);
  
  if (successRate >= 75) {
    console.log('\n✅ INTELLIGENT SYNTHESIS ENGINE WORKING CORRECTLY!');
  } else {
    console.log('\n❌ SYNTHESIS ENGINE NEEDS ADJUSTMENT');
  }
}

// Run the test
testSynthesis().catch(console.error);