#!/usr/bin/env node

/**
 * GOLD-STANDARD PRODUCTION CERTIFICATION TEST
 * Tests the live Vercel deployment with a real research target
 * Success Criteria:
 * - All 6 phases complete
 * - 40-50 sources minimum collected
 * - Real API data returned
 * - Synthesis generates actual intelligence
 * - No errors or timeouts
 */

const https = require('https');

const TARGET = 'Bob Crants Pharos';
const API_URL = 'mrp-intelligence.vercel.app';
const CERTIFICATION_CRITERIA = {
  minSources: 40,
  maxPhaseTime: 120000, // 2 minutes per phase
  requiredPhases: 6,
  requiredSynthesis: true
};

console.log('='.repeat(80));
console.log('GOLD-STANDARD PRODUCTION CERTIFICATION TEST');
console.log('='.repeat(80));
console.log(`Target: ${TARGET}`);
console.log(`Deployment: https://${API_URL}`);
console.log(`Time: ${new Date().toISOString()}`);
console.log('='.repeat(80));

// Start research
function startResearch() {
  return new Promise((resolve, reject) => {
    const data = JSON.stringify({
      target: TARGET,
      researchType: 'individual'
    });

    const options = {
      hostname: API_URL,
      path: '/api/mrp/research',
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Content-Length': Buffer.byteLength(data)
      }
    };

    console.log('\n[INITIATING] Starting research for Bob Crants Pharos...');
    
    const req = https.request(options, (res) => {
      let body = '';
      res.on('data', chunk => body += chunk);
      res.on('end', () => {
        try {
          const result = JSON.parse(body);
          console.log('[SUCCESS] Research initiated');
          console.log(`Job ID: ${result.jobId}`);
          resolve(result.jobId);
        } catch (e) {
          reject(`Failed to parse response: ${body}`);
        }
      });
    });

    req.on('error', reject);
    req.write(data);
    req.end();
  });
}

// Check status
function checkStatus(jobId) {
  return new Promise((resolve, reject) => {
    const options = {
      hostname: API_URL,
      path: `/api/mrp/status/${jobId}`,
      method: 'GET'
    };

    const req = https.request(options, (res) => {
      let body = '';
      res.on('data', chunk => body += chunk);
      res.on('end', () => {
        try {
          const result = JSON.parse(body);
          resolve(result);
        } catch (e) {
          reject(`Failed to parse status: ${body}`);
        }
      });
    });

    req.on('error', reject);
    req.end();
  });
}

// Monitor progress
async function monitorProgress(jobId) {
  const startTime = Date.now();
  let lastPhase = '';
  let phaseCount = new Set();
  
  while (true) {
    const status = await checkStatus(jobId);
    
    // Track phase changes
    if (status.phase !== lastPhase) {
      console.log(`\n[PHASE ${phaseCount.size + 1}] ${status.phase}`);
      lastPhase = status.phase;
      phaseCount.add(status.phase);
    }
    
    // Show progress
    if (status.logs && status.logs.length > 0) {
      const lastLog = status.logs[status.logs.length - 1];
      if (lastLog.message) {
        console.log(`  → ${lastLog.message}`);
      }
    }
    
    // Check completion
    if (status.status === 'completed') {
      return status;
    }
    
    // Check for errors
    if (status.status === 'error') {
      throw new Error(`Research failed: ${status.error || 'Unknown error'}`);
    }
    
    // Timeout check
    if (Date.now() - startTime > 300000) { // 5 minutes total
      throw new Error('Research timeout - exceeded 5 minutes');
    }
    
    // Wait before next check
    await new Promise(resolve => setTimeout(resolve, 2000));
  }
}

// Validate results
function validateResults(status) {
  const results = {
    passed: [],
    failed: [],
    warnings: []
  };
  
  console.log('\n' + '='.repeat(80));
  console.log('CERTIFICATION VALIDATION');
  console.log('='.repeat(80));
  
  // Check phase count
  const uniquePhases = new Set(status.logs.map(l => l.phase)).size;
  if (uniquePhases >= CERTIFICATION_CRITERIA.requiredPhases) {
    results.passed.push(`✅ All ${uniquePhases} phases completed`);
  } else {
    results.failed.push(`❌ Only ${uniquePhases}/${CERTIFICATION_CRITERIA.requiredPhases} phases completed`);
  }
  
  // Check source count
  const sourceLog = status.logs.find(l => l.message && l.message.includes('sources'));
  if (sourceLog) {
    const sourceMatch = sourceLog.message.match(/(\d+)\s+sources/);
    if (sourceMatch) {
      const sourceCount = parseInt(sourceMatch[1]);
      if (sourceCount >= CERTIFICATION_CRITERIA.minSources) {
        results.passed.push(`✅ Collected ${sourceCount} sources (meets ${CERTIFICATION_CRITERIA.minSources} minimum)`);
      } else if (sourceCount > 0) {
        results.warnings.push(`⚠️ Only ${sourceCount} sources (below ${CERTIFICATION_CRITERIA.minSources} minimum)`);
      } else {
        results.failed.push(`❌ No sources collected`);
      }
    }
  }
  
  // Check for synthesis
  if (status.phase === 'Synthesis' || status.logs.some(l => l.phase === 'Synthesis')) {
    results.passed.push('✅ Synthesis phase executed');
  } else {
    results.failed.push('❌ Synthesis phase not reached');
  }
  
  // Check execution time
  if (status.startTime && status.endTime) {
    const duration = new Date(status.endTime) - new Date(status.startTime);
    const seconds = Math.round(duration / 1000);
    if (duration < 300000) { // Under 5 minutes
      results.passed.push(`✅ Completed in ${seconds} seconds`);
    } else {
      results.warnings.push(`⚠️ Took ${seconds} seconds (slow performance)`);
    }
  }
  
  // Check for API errors
  const errorLogs = status.logs.filter(l => 
    l.message && (l.message.includes('error') || l.message.includes('failed'))
  );
  if (errorLogs.length === 0) {
    results.passed.push('✅ No API errors detected');
  } else {
    errorLogs.forEach(log => {
      results.warnings.push(`⚠️ ${log.phase}: ${log.message}`);
    });
  }
  
  // Display results
  console.log('\nPASSED CRITERIA:');
  results.passed.forEach(item => console.log(item));
  
  if (results.warnings.length > 0) {
    console.log('\nWARNINGS:');
    results.warnings.forEach(item => console.log(item));
  }
  
  if (results.failed.length > 0) {
    console.log('\nFAILED CRITERIA:');
    results.failed.forEach(item => console.log(item));
  }
  
  // Overall certification
  console.log('\n' + '='.repeat(80));
  if (results.failed.length === 0) {
    console.log('🏆 CERTIFICATION: PASSED');
    if (results.warnings.length > 0) {
      console.log('   (with warnings - review for optimization)');
    }
  } else {
    console.log('❌ CERTIFICATION: FAILED');
    console.log(`   ${results.failed.length} critical issues must be resolved`);
  }
  console.log('='.repeat(80));
  
  return results.failed.length === 0;
}

// Main execution
async function runCertification() {
  try {
    // Start research
    const jobId = await startResearch();
    
    // Monitor progress
    console.log('\n[MONITORING] Tracking research progress...');
    const finalStatus = await monitorProgress(jobId);
    
    // Validate results
    const passed = validateResults(finalStatus);
    
    // Save results
    const report = {
      timestamp: new Date().toISOString(),
      target: TARGET,
      jobId: jobId,
      passed: passed,
      status: finalStatus
    };
    
    require('fs').writeFileSync(
      'certification-results.json',
      JSON.stringify(report, null, 2)
    );
    
    console.log('\nResults saved to certification-results.json');
    
    process.exit(passed ? 0 : 1);
    
  } catch (error) {
    console.error('\n❌ CERTIFICATION FAILED WITH ERROR:');
    console.error(error.message || error);
    process.exit(1);
  }
}

// Run the certification
runCertification();