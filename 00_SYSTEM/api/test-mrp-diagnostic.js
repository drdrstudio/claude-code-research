const express = require('express');
const https = require('https');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

// Simple diagnostic test for each API
async function testFirecrawl() {
  console.log('Testing Firecrawl...');
  return new Promise((resolve) => {
    const postData = JSON.stringify({
      query: "test query",
      limit: 1
    });

    const options = {
      protocol: 'https:',
      hostname: 'api.firecrawl.dev',
      path: '/v1/search',
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${process.env.FIRECRAWL_API_KEY}`,
        'Content-Type': 'application/json',
        'Content-Length': Buffer.byteLength(postData)
      },
      timeout: 5000
    };

    const req = https.request(options, (res) => {
      let data = '';
      res.on('data', chunk => data += chunk);
      res.on('end', () => {
        try {
          const parsed = JSON.parse(data);
          console.log('Firecrawl response:', parsed.success ? 'SUCCESS' : 'FAILED');
          resolve({ api: 'firecrawl', success: !!parsed.success, data: parsed.data?.length || 0 });
        } catch (e) {
          console.log('Firecrawl error:', e.message);
          resolve({ api: 'firecrawl', success: false, error: e.message });
        }
      });
    });

    req.on('error', (e) => {
      console.log('Firecrawl request error:', e.message);
      resolve({ api: 'firecrawl', success: false, error: e.message });
    });

    req.on('timeout', () => {
      console.log('Firecrawl timeout');
      req.destroy();
      resolve({ api: 'firecrawl', success: false, error: 'timeout' });
    });

    req.write(postData);
    req.end();
  });
}

async function testPerplexity() {
  console.log('Testing Perplexity...');
  return new Promise((resolve) => {
    const postData = JSON.stringify({
      model: "sonar",
      messages: [{ role: "user", content: "Hi" }]
    });

    const options = {
      protocol: 'https:',
      hostname: 'api.perplexity.ai',
      path: '/chat/completions',
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${process.env.PERPLEXITY_API_KEY}`,
        'Content-Type': 'application/json',
        'Content-Length': Buffer.byteLength(postData)
      },
      timeout: 5000
    };

    const req = https.request(options, (res) => {
      let data = '';
      res.on('data', chunk => data += chunk);
      res.on('end', () => {
        try {
          const parsed = JSON.parse(data);
          console.log('Perplexity response:', parsed.choices ? 'SUCCESS' : 'FAILED');
          resolve({ api: 'perplexity', success: !!parsed.choices, content: parsed.choices?.[0]?.message?.content?.substring(0, 50) });
        } catch (e) {
          console.log('Perplexity error:', e.message);
          resolve({ api: 'perplexity', success: false, error: e.message });
        }
      });
    });

    req.on('error', (e) => {
      console.log('Perplexity request error:', e.message);
      resolve({ api: 'perplexity', success: false, error: e.message });
    });

    req.on('timeout', () => {
      console.log('Perplexity timeout');
      req.destroy();
      resolve({ api: 'perplexity', success: false, error: 'timeout' });
    });

    req.write(postData);
    req.end();
  });
}

async function testTavily() {
  console.log('Testing Tavily...');
  return new Promise((resolve) => {
    const postData = JSON.stringify({
      api_key: process.env.TAVILY_API_KEY,
      query: "test",
      max_results: 1
    });

    const options = {
      protocol: 'https:',
      hostname: 'api.tavily.com',
      path: '/search',
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Content-Length': Buffer.byteLength(postData)
      },
      timeout: 5000
    };

    const req = https.request(options, (res) => {
      let data = '';
      res.on('data', chunk => data += chunk);
      res.on('end', () => {
        try {
          const parsed = JSON.parse(data);
          console.log('Tavily response:', parsed.results ? 'SUCCESS' : 'FAILED');
          resolve({ api: 'tavily', success: !!parsed.results, results: parsed.results?.length || 0 });
        } catch (e) {
          console.log('Tavily error:', e.message);
          resolve({ api: 'tavily', success: false, error: e.message });
        }
      });
    });

    req.on('error', (e) => {
      console.log('Tavily request error:', e.message);
      resolve({ api: 'tavily', success: false, error: e.message });
    });

    req.on('timeout', () => {
      console.log('Tavily timeout');
      req.destroy();
      resolve({ api: 'tavily', success: false, error: 'timeout' });
    });

    req.write(postData);
    req.end();
  });
}

// Test endpoint
app.get('/test-apis', async (req, res) => {
  console.log('Starting API tests...');
  
  const results = {
    timestamp: new Date().toISOString(),
    env: {
      firecrawl: !!process.env.FIRECRAWL_API_KEY,
      perplexity: !!process.env.PERPLEXITY_API_KEY,
      tavily: !!process.env.TAVILY_API_KEY
    },
    tests: []
  };

  // Test each API with timeout
  try {
    const firecrawlResult = await Promise.race([
      testFirecrawl(),
      new Promise(resolve => setTimeout(() => resolve({ api: 'firecrawl', success: false, error: 'global timeout' }), 10000))
    ]);
    results.tests.push(firecrawlResult);
  } catch (e) {
    results.tests.push({ api: 'firecrawl', success: false, error: e.message });
  }

  try {
    const perplexityResult = await Promise.race([
      testPerplexity(),
      new Promise(resolve => setTimeout(() => resolve({ api: 'perplexity', success: false, error: 'global timeout' }), 10000))
    ]);
    results.tests.push(perplexityResult);
  } catch (e) {
    results.tests.push({ api: 'perplexity', success: false, error: e.message });
  }

  try {
    const tavilyResult = await Promise.race([
      testTavily(),
      new Promise(resolve => setTimeout(() => resolve({ api: 'tavily', success: false, error: 'global timeout' }), 10000))
    ]);
    results.tests.push(tavilyResult);
  } catch (e) {
    results.tests.push({ api: 'tavily', success: false, error: e.message });
  }

  res.json(results);
});

app.get('/', (req, res) => {
  res.json({ 
    message: 'MRP Diagnostic Test Server',
    endpoint: '/test-apis'
  });
});

const PORT = process.env.PORT || 8080;
app.listen(PORT, () => {
  console.log(`Diagnostic server running on port ${PORT}`);
});