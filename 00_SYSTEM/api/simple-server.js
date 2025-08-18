const http = require('http');
const url = require('url');
const fs = require('fs');
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
      version: '7.0',
      timestamp: new Date().toISOString()
    }));
    return;
  }

  // Start research
  if (pathname === '/api/research' && req.method === 'POST') {
    let body = '';
    req.on('data', chunk => body += chunk);
    req.on('end', () => {
      const data = JSON.parse(body);
      const jobId = Math.random().toString(36).substr(2, 9);
      
      jobs[jobId] = {
        id: jobId,
        state: 'pending',
        phase: 'Initializing',
        progress: 0,
        started: new Date().toISOString(),
        data: data
      };

      // Simulate progress
      setTimeout(() => {
        jobs[jobId].state = 'completed';
        jobs[jobId].progress = 100;
        jobs[jobId].message = `Research complete for ${data.target_name || 'Template Mode'}`;
      }, 10000);

      res.writeHead(200, headers);
      res.end(JSON.stringify({
        success: true,
        job_id: jobId,
        message: `Research job created for ${data.target_name || 'Template Mode'}`,
        note: 'Demo mode - simulated research'
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
  console.log(`🚀 MRP API Server running on http://localhost:${PORT}`);
  console.log('📝 This is a demo server for testing the interface');
});