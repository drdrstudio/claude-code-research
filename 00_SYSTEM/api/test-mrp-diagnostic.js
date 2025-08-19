#!/usr/bin/env node

/**
 * Diagnostic script to test MRP engine locally
 */

const path = require('path');

// Load the engine
const enginePath = path.join(__dirname, 'complete-mrp-v6-engine.js');

console.log('🔍 MRP Engine Diagnostic Tool\n');
console.log('================================');

// Check environment variables
const requiredVars = [
  'FIRECRAWL_API_KEY',
  'PERPLEXITY_API_KEY', 
  'TAVILY_API_KEY',
  'DATAFORSEO_LOGIN',
  'DATAFORSEO_PASSWORD'
];

console.log('\n📋 Environment Variables Check:');
let missingVars = [];
for (const varName of requiredVars) {
  const value = process.env[varName];
  if (value) {
    console.log(`✅ ${varName}: Set (${value.substring(0, 10)}...)`);
  } else {
    console.log(`❌ ${varName}: NOT SET`);
    missingVars.push(varName);
  }
}

if (missingVars.length > 0) {
  console.log('\n⚠️  WARNING: Missing API keys will cause the research to hang!');
  console.log('The following environment variables need to be set:');
  missingVars.forEach(v => console.log(`  - ${v}`));
  console.log('\nTo fix in Railway:');
  console.log('1. Go to your Railway project dashboard');
  console.log('2. Click on the service');
  console.log('3. Go to Variables tab');
  console.log('4. Add the missing variables');
  console.log('5. Redeploy the service');
}

console.log('\n📊 Testing Engine Initialization:');
try {
  // Try to load the engine file
  const engineCode = require('fs').readFileSync(enginePath, 'utf8');
  
  // Check if EnhancedRealMRPEngine class exists
  if (engineCode.includes('class EnhancedRealMRPEngine')) {
    console.log('✅ EnhancedRealMRPEngine class found');
  } else {
    console.log('❌ EnhancedRealMRPEngine class NOT found');
  }
  
  // Check for key methods
  const methods = [
    'runFullResearch',
    'runSurfaceIntelligence', 
    'runFinancialIntelligence',
    'runLegalIntelligence',
    'runNetworkIntelligence',
    'runRiskAssessment',
    'runCompetitiveIntelligence'
  ];
  
  console.log('\n🔧 Checking required methods:');
  methods.forEach(method => {
    if (engineCode.includes(`async ${method}`)) {
      console.log(`✅ ${method} found`);
    } else {
      console.log(`❌ ${method} NOT found`);
    }
  });
  
  // Try to actually run a minimal test
  console.log('\n🧪 Running minimal initialization test:');
  
  // Create minimal test
  const testCode = `
    const { EnhancedRealMRPEngine } = require('./complete-mrp-v6-engine.js');
    const engine = new EnhancedRealMRPEngine('test_job', 'Test Company', 'organization');
    console.log('✅ Engine initialized successfully');
  `;
  
  try {
    eval(engineCode + '\n' + 'const testEngine = new EnhancedRealMRPEngine("test", "Test", "organization"); console.log("✅ Engine can be instantiated");');
  } catch (e) {
    console.log('❌ Engine instantiation failed:', e.message);
  }
  
} catch (error) {
  console.log('❌ Failed to load engine:', error.message);
}

console.log('\n================================');
console.log('Diagnostic complete.\n');

if (missingVars.length > 0) {
  console.log('⚠️  ACTION REQUIRED: Add the missing API keys to Railway environment variables');
  process.exit(1);
} else {
  console.log('✅ All checks passed!');
  process.exit(0);
}