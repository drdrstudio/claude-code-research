const http = require('http');
const url = require('url');
const { spawn } = require('child_process');
const path = require('path');
const fs = require('fs');

const PORT = process.env.PORT || 5001;

// Simple CORS headers
const headers = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type',
  'Content-Type': 'application/json'
};

// Store jobs in memory with detailed progress
const jobs = {};

// Progress phases with weights
const PROGRESS_PHASES = {
  'Initializing': 5,
  'Setting up environment': 10,
  'Searching with Firecrawl': 20,
  'Deep searching with Perplexity': 35,
  'Gathering from DataForSEO': 50,
  'Reddit sentiment analysis': 60,
  'Synthesizing with Gemini': 75,
  'Generating PDF': 90,
  'Finalizing': 95,
  'Complete': 100
};

const server = http.createServer((req, res) => {
  const parsedUrl = url.parse(req.url, true);
  const pathname = parsedUrl.pathname;

  // Serve static files (HTML, JS, CSS)
  if (pathname === '/' || pathname === '/index.html') {
    const htmlPath = path.join(__dirname, '../web-interface/index.html');
    fs.readFile(htmlPath, (err, data) => {
      if (err) {
        res.writeHead(404);
        res.end('Not found');
      } else {
        res.writeHead(200, {'Content-Type': 'text/html'});
        res.end(data);
      }
    });
    return;
  }

  if (pathname === '/config.js') {
    const jsPath = path.join(__dirname, '../web-interface/config.js');
    fs.readFile(jsPath, (err, data) => {
      if (err) {
        res.writeHead(404);
        res.end('Not found');
      } else {
        res.writeHead(200, {'Content-Type': 'application/javascript'});
        res.end(data);
      }
    });
    return;
  }

  // Handle CORS preflight
  if (req.method === 'OPTIONS') {
    res.writeHead(200, headers);
    res.end();
    return;
  }

  // Serve PDF files
  if (pathname.startsWith('/api/pdf/') && req.method === 'GET') {
    const filename = pathname.split('/').pop();
    const pdfPath = path.join(__dirname, '../../03_PROJECTS', filename);
    
    if (fs.existsSync(pdfPath)) {
      const pdfHeaders = {
        ...headers,
        'Content-Type': 'application/pdf',
        'Content-Disposition': `inline; filename="${filename}"`
      };
      res.writeHead(200, pdfHeaders);
      fs.createReadStream(pdfPath).pipe(res);
    } else {
      res.writeHead(404, headers);
      res.end(JSON.stringify({ error: 'PDF not found' }));
    }
    return;
  }

  // API Health check
  if (pathname === '/api/health' && req.method === 'GET') {
    res.writeHead(200, headers);
    res.end(JSON.stringify({
      status: 'healthy',
      version: '7.0 - Enhanced',
      timestamp: new Date().toISOString()
    }));
    return;
  }

  // Start REAL research with progress tracking
  if (pathname === '/api/research' && req.method === 'POST') {
    let body = '';
    req.on('data', chunk => body += chunk);
    req.on('end', () => {
      const data = JSON.parse(body);
      const jobId = Math.random().toString(36).substr(2, 9);
      const timestamp = new Date().toISOString().replace(/[:.]/g, '-').slice(0, -5);
      
      jobs[jobId] = {
        id: jobId,
        state: 'running',
        phase: 'Initializing',
        progress: 5,
        started: new Date().toISOString(),
        data: data,
        logs: [],
        pdf_url: null,
        project_folder: null
      };

      // Determine research parameters
      const researchType = data.research_type || 'individual';
      const targetName = data.target_name || 'Research_Target';
      const depth = data.depth || 'standard';
      const template = data.template || 'corporate';
      
      // Expected project folder name
      const projectFolder = `Research_${researchType}_${targetName.replace(/\s+/g, '_')}_${timestamp}`;
      jobs[jobId].project_folder = projectFolder;
      
      // Determine which script to run based on research type
      // Use absolute paths from project root for Railway deployment
      const projectRoot = path.join(__dirname, '../..');
      let scriptPath;
      switch(researchType) {
        case 'individual':
          scriptPath = path.join(projectRoot, 'quick_research.sh');
          break;
        case 'organization':
          scriptPath = path.join(projectRoot, 'quick_research_org.sh');
          break;
        case 'market':
          scriptPath = path.join(projectRoot, 'quick_research_gtm.sh');
          break;
        default:
          scriptPath = path.join(projectRoot, 'quick_research.sh');
      }
      
      // Check if script exists
      if (!fs.existsSync(scriptPath)) {
        console.error(`❌ Script not found: ${scriptPath}`);
        jobs[jobId].state = 'failed';
        jobs[jobId].error = `Research script not found: ${scriptPath}`;
        jobs[jobId].phase = 'Failed';
        
        res.writeHead(500, headers);
        res.end(JSON.stringify({ 
          error: 'Research script not found',
          details: `Looking for: ${scriptPath}`,
          suggestion: 'Please ensure research scripts are in the project root'
        }));
        return;
      }
      
      console.log(`🚀 Starting REAL research: ${targetName}`);
      console.log(`📁 Project: ${projectFolder}`);
      console.log(`🔍 Type: ${researchType}, Depth: ${depth}, Template: ${template}`);
      console.log(`📜 Script: ${scriptPath}`);
      
      // Update progress function
      const updateProgress = (phase, log) => {
        jobs[jobId].phase = phase;
        jobs[jobId].progress = PROGRESS_PHASES[phase] || jobs[jobId].progress;
        if (log) {
          jobs[jobId].logs.push({
            time: new Date().toISOString(),
            message: log
          });
          console.log(`📊 ${phase}: ${log}`);
        }
      };
      
      // Run the actual research script
      const research = spawn('bash', [scriptPath, targetName], {
        cwd: path.join(__dirname, '../..'),
        env: { 
          ...process.env, 
          RESEARCH_TYPE: researchType, 
          DEPTH: depth,
          TEMPLATE: template,
          OUTPUT_PDF: 'true'
        }
      });

      // Track output for progress
      research.stdout.on('data', (data) => {
        const output = data.toString();
        console.log(`Research: ${output}`);
        
        // Parse output for progress indicators
        if (output.includes('Firecrawl')) {
          updateProgress('Searching with Firecrawl', 'Deep web extraction in progress...');
        } else if (output.includes('Perplexity')) {
          updateProgress('Deep searching with Perplexity', 'AI-powered search running...');
        } else if (output.includes('DataForSEO')) {
          updateProgress('Gathering from DataForSEO', 'SEO and competitor data collection...');
        } else if (output.includes('Reddit')) {
          updateProgress('Reddit sentiment analysis', 'Community sentiment analysis...');
        } else if (output.includes('Gemini') || output.includes('synthesis')) {
          updateProgress('Synthesizing with Gemini', 'Strategic intelligence synthesis...');
        } else if (output.includes('PDF') || output.includes('document')) {
          updateProgress('Generating PDF', 'Creating professional document...');
        } else if (output.includes('complete') || output.includes('finished')) {
          updateProgress('Finalizing', 'Wrapping up research...');
        }
        
        // Add to logs
        jobs[jobId].logs.push({
          time: new Date().toISOString(),
          message: output.trim()
        });
      });

      research.stderr.on('data', (data) => {
        console.error(`Research error: ${data}`);
        jobs[jobId].logs.push({
          time: new Date().toISOString(),
          message: `Error: ${data.toString().trim()}`,
          type: 'error'
        });
      });

      research.on('close', (code) => {
        if (code === 0) {
          // Look for generated PDF
          const possiblePdfPaths = [
            `03_PROJECTS/${researchType}/${projectFolder}/PDFs/`,
            `03_PROJECTS/${projectFolder}/PDFs/`,
            `03_PROJECTS/ReputationalScans/${projectFolder}/PDFs/`
          ];
          
          let pdfFound = false;
          for (const pdfPath of possiblePdfPaths) {
            const fullPath = path.join(__dirname, '../..', pdfPath);
            if (fs.existsSync(fullPath)) {
              const files = fs.readdirSync(fullPath);
              const pdfFile = files.find(f => f.endsWith('.pdf'));
              if (pdfFile) {
                jobs[jobId].pdf_url = `/api/pdf/${pdfPath}${pdfFile}`;
                pdfFound = true;
                break;
              }
            }
          }
          
          jobs[jobId].state = 'completed';
          jobs[jobId].progress = 100;
          jobs[jobId].phase = 'Complete';
          jobs[jobId].message = `✅ Research complete for ${targetName}`;
          jobs[jobId].completion_time = new Date().toISOString();
          
          if (pdfFound) {
            jobs[jobId].message += ' - PDF ready for viewing!';
          }
          
          console.log(`✅ Research completed successfully for ${targetName}`);
        } else {
          jobs[jobId].state = 'failed';
          jobs[jobId].error = `Research process exited with code ${code}`;
          jobs[jobId].phase = 'Failed';
          console.error(`❌ Research failed with code ${code}`);
        }
      });

      res.writeHead(200, headers);
      res.end(JSON.stringify({
        success: true,
        job_id: jobId,
        message: `Research started for ${targetName}`,
        note: 'Real research running - check status for progress updates',
        estimated_time: depth === 'deep' ? '20-30 minutes' : '10-15 minutes'
      }));
    });
    return;
  }

  // Get job status with detailed progress
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

  // List all jobs
  if (pathname === '/api/jobs' && req.method === 'GET') {
    res.writeHead(200, headers);
    res.end(JSON.stringify(Object.values(jobs)));
    return;
  }

  // Default 404
  res.writeHead(404, headers);
  res.end(JSON.stringify({ error: 'Not found' }));
});

server.listen(PORT, () => {
  console.log(`🚀 MRP Enhanced Research Server running on http://localhost:${PORT}`);
  console.log('⚡ Real-time progress tracking enabled');
  console.log('📄 PDF viewing enabled when research completes');
  console.log('⏱️  Research takes 10-30 minutes depending on depth');
});