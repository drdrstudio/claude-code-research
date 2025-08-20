#!/usr/bin/env node

/**
 * Test the Ground Truth Engine integration with real-mrp-v6-engine.js
 */

const http = require('http');

async function testResearch() {
  return new Promise((resolve, reject) => {
    const data = JSON.stringify({
      target: 'Test Subject Alpha',
      type: 'individual'
    });

    const options = {
      hostname: 'localhost',
      port: 3000,
      path: '/api/mrp/research',
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Content-Length': Buffer.byteLength(data)
      }
    };

    console.log('='.repeat(60));
    console.log('TESTING GROUND TRUTH ENGINE INTEGRATION');
    console.log('='.repeat(60));
    console.log('\nStarting research for: Test Subject Alpha');
    
    const req = http.request(options, (res) => {
      let body = '';
      res.on('data', chunk => body += chunk);
      res.on('end', () => {
        try {
          const result = JSON.parse(body);
          console.log('\n✅ Research started successfully');
          console.log('Job ID:', result.jobId);
          console.log('Status URL:', result.statusUrl);
          
          // Check status after a few seconds
          setTimeout(() => checkStatus(result.jobId), 5000);
          
          resolve(result);
        } catch (e) {
          console.error('❌ Error:', e.message);
          reject(e);
        }
      });
    });

    req.on('error', (e) => {
      console.error('❌ Request error:', e.message);
      reject(e);
    });

    req.write(data);
    req.end();
  });
}

async function checkStatus(jobId) {
  return new Promise((resolve) => {
    const options = {
      hostname: 'localhost',
      port: 3000,
      path: `/api/mrp/status/${jobId}`,
      method: 'GET'
    };

    const req = http.request(options, (res) => {
      let body = '';
      res.on('data', chunk => body += chunk);
      res.on('end', () => {
        try {
          const status = JSON.parse(body);
          console.log('\n' + '='.repeat(60));
          console.log('STATUS CHECK');
          console.log('='.repeat(60));
          console.log('Phase:', status.phase);
          console.log('Progress:', status.progress + '%');
          console.log('Status:', status.status);
          
          if (status.logs && status.logs.length > 0) {
            console.log('\nRecent logs:');
            status.logs.slice(-5).forEach(log => {
              console.log(`  [${log.phase}] ${log.message}`);
            });
          }
          
          // Check again if still running
          if (status.status === 'running' && status.progress < 100) {
            console.log('\nChecking again in 10 seconds...');
            setTimeout(() => checkStatus(jobId), 10000);
          } else if (status.status === 'completed') {
            console.log('\n✅ Research completed successfully!');
            checkFinalResults(jobId);
          }
          
          resolve(status);
        } catch (e) {
          console.error('Status check error:', e.message);
          resolve(null);
        }
      });
    });

    req.on('error', (e) => {
      console.error('Status request error:', e.message);
      resolve(null);
    });

    req.end();
  });
}

async function checkFinalResults(jobId) {
  // Get the final status to see the results
  const options = {
    hostname: 'localhost',
    port: 3000,
    path: `/api/mrp/status/${jobId}`,
    method: 'GET'
  };

  const req = http.request(options, (res) => {
    let body = '';
    res.on('data', chunk => body += chunk);
    res.on('end', () => {
      try {
        const status = JSON.parse(body);
        console.log('\n' + '='.repeat(60));
        console.log('FINAL RESULTS');
        console.log('='.repeat(60));
        
        // Count sources from logs
        const sourceLogs = status.logs.filter(log => 
          log.message.includes('sources') || log.message.includes('Collected')
        );
        
        if (sourceLogs.length > 0) {
          console.log('\nSource Collection:');
          sourceLogs.forEach(log => {
            console.log(`  ${log.message}`);
          });
        }
        
        // Check for phases completed
        const phases = ['Phase 1', 'Phase 2', 'Phase 3', 'Phase 4', 'Phase 5', 'Phase 6'];
        console.log('\nPhases Completed:');
        phases.forEach(phase => {
          const phaseLog = status.logs.find(log => log.phase.includes(phase));
          if (phaseLog) {
            console.log(`  ✅ ${phase}`);
          } else {
            console.log(`  ❌ ${phase}`);
          }
        });
        
        console.log('\n' + '='.repeat(60));
        console.log('TEST COMPLETE');
        console.log('='.repeat(60));
        
      } catch (e) {
        console.error('Final results error:', e.message);
      }
    });
  });

  req.on('error', (e) => {
    console.error('Final results request error:', e.message);
  });

  req.end();
}

// Start the test
testResearch().catch(console.error);