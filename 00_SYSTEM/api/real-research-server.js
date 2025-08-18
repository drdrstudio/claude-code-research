const http = require('http');
const url = require('url');
const { spawn } = require('child_process');
const path = require('path');

const PORT = 5001;

// Simple CORS headers
const headers = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type',
  'Content-Type': 'application/json'
};

// Store jobs in memory
const jobs = {};

const server = http.createServer((req, res) => {
  const parsedUrl = url.parse(req.url, true);
  const pathname = parsedUrl.pathname;

  // Handle CORS preflight
  if (req.method === 'OPTIONS') {
    res.writeHead(200, headers);
    res.end();
    return;
  }

  // API Health check
  if (pathname === '/api/health' && req.method === 'GET') {
    res.writeHead(200, headers);
    res.end(JSON.stringify({
      status: 'healthy',
      version: '7.0 - REAL',
      timestamp: new Date().toISOString()
    }));
    return;
  }

  // Start REAL research
  if (pathname === '/api/research' && req.method === 'POST') {
    let body = '';
    req.on('data', chunk => body += chunk);
    req.on('end', () => {
      const data = JSON.parse(body);
      const jobId = Math.random().toString(36).substr(2, 9);
      
      jobs[jobId] = {
        id: jobId,
        state: 'running',
        phase: 'Starting real research',
        progress: 5,
        started: new Date().toISOString(),
        data: data
      };

      // Determine research type and script
      let scriptPath;
      const researchType = data.research_type || 'individual';
      const targetName = data.target_name || 'Research_Target';
      const depth = data.depth || 'standard';
      
      // Path to quick_research.sh
      scriptPath = path.join(__dirname, '../../quick_research.sh');
      
      console.log(`🚀 Starting REAL research: ${targetName}`);
      console.log(`📁 Script: ${scriptPath}`);
      console.log(`🔍 Type: ${researchType}, Depth: ${depth}`);
      
      // Run the actual research script
      const research = spawn('bash', [scriptPath, targetName], {
        cwd: path.join(__dirname, '../..'),
        env: { ...process.env, RESEARCH_TYPE: researchType, DEPTH: depth }
      });

      research.stdout.on('data', (data) => {
        console.log(`Research output: ${data}`);
        jobs[jobId].phase = 'Gathering intelligence...';
        jobs[jobId].progress = Math.min(jobs[jobId].progress + 10, 90);
      });

      research.stderr.on('data', (data) => {
        console.error(`Research error: ${data}`);
      });

      research.on('close', (code) => {
        if (code === 0) {
          jobs[jobId].state = 'completed';
          jobs[jobId].progress = 100;
          jobs[jobId].message = `✅ REAL research complete for ${targetName}`;
          console.log(`✅ Research completed successfully for ${targetName}`);
        } else {
          jobs[jobId].state = 'failed';
          jobs[jobId].error = `Research process exited with code ${code}`;
          console.error(`❌ Research failed with code ${code}`);
        }
      });

      res.writeHead(200, headers);
      res.end(JSON.stringify({
        success: true,
        job_id: jobId,
        message: `REAL research started for ${targetName}`,
        note: 'This is running actual research scripts - may take 5-30 minutes depending on depth'
      }));
    });
    return;
  }

  // Get job status
  if (pathname.startsWith('/api/status/') && req.method === 'GET') {
    const jobId = pathname.split('/').pop();
    if (jobs[jobId]) {
      res.writeHead(200, headers);
      res.end(JSON.stringify(jobs[jobId]));
    } else {
      res.writeHead(404, headers);
      res.end(JSON.stringify({ error: 'Job not found' }));
    }
    return;
  }

  // Default 404
  res.writeHead(404, headers);
  res.end(JSON.stringify({ error: 'Not found' }));
});

server.listen(PORT, () => {
  console.log(`🚀 MRP REAL Research Server running on http://localhost:${PORT}`);
  console.log('⚡ This server runs ACTUAL research scripts');
  console.log('⏱️  Research may take 5-30 minutes depending on depth');
});