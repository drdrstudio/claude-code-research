#!/usr/bin/env node

/**
 * Test API calls directly on Vercel deployment
 */

const https = require('https');

async function testFirecrawl() {
  const apiKey = process.env.FIRECRAWL_API_KEY || 'fc-99ce2e081f9644c4aa9a669d86073f73';
  
  return new Promise((resolve, reject) => {
    const data = JSON.stringify({
      query: 'Bob Crants',
      limit: 3
    });

    const options = {
      protocol: 'https:',
      hostname: 'api.firecrawl.dev',
      path: '/v1/search',
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${apiKey}`,
        'Content-Type': 'application/json',
        'Content-Length': Buffer.byteLength(data)
      },
      timeout: 10000
    };

    console.log('[FIRECRAWL] Testing search API...');
    
    const req = https.request(options, (res) => {
      let body = '';
      res.on('data', chunk => body += chunk);
      res.on('end', () => {
        try {
          const result = JSON.parse(body);
          if (result.data && result.data.length > 0) {
            console.log('[FIRECRAWL] ✅ Success - Found', result.data.length, 'results');
            resolve(true);
          } else {
            console.log('[FIRECRAWL] ⚠️ No results but API working');
            resolve(true);
          }
        } catch (e) {
          console.log('[FIRECRAWL] ❌ Error:', e.message);
          console.log('Response:', body.substring(0, 200));
          resolve(false);
        }
      });
    });

    req.on('error', (e) => {
      console.log('[FIRECRAWL] ❌ Request error:', e.message);
      resolve(false);
    });
    
    req.on('timeout', () => {
      console.log('[FIRECRAWL] ❌ Timeout');
      req.destroy();
      resolve(false);
    });

    req.write(data);
    req.end();
  });
}

async function testPerplexity() {
  const apiKey = process.env.PERPLEXITY_API_KEY || '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';
  
  return new Promise((resolve, reject) => {
    const data = JSON.stringify({
      model: 'sonar',
      messages: [
        {
          role: 'user',
          content: 'Who is Bob Crants? Brief answer.'
        }
      ]
    });

    const options = {
      protocol: 'https:',
      hostname: 'api.perplexity.ai',
      path: '/chat/completions',
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${apiKey}`,
        'Content-Type': 'application/json',
        'Content-Length': Buffer.byteLength(data)
      },
      timeout: 10000
    };

    console.log('[PERPLEXITY] Testing chat API...');
    
    const req = https.request(options, (res) => {
      let body = '';
      res.on('data', chunk => body += chunk);
      res.on('end', () => {
        try {
          const result = JSON.parse(body);
          if (result.choices && result.choices[0]) {
            console.log('[PERPLEXITY] ✅ Success - Got response');
            resolve(true);
          } else {
            console.log('[PERPLEXITY] ⚠️ Unexpected response format');
            console.log('Response:', body.substring(0, 200));
            resolve(false);
          }
        } catch (e) {
          console.log('[PERPLEXITY] ❌ Error:', e.message);
          console.log('Response:', body.substring(0, 200));
          resolve(false);
        }
      });
    });

    req.on('error', (e) => {
      console.log('[PERPLEXITY] ❌ Request error:', e.message);
      resolve(false);
    });
    
    req.on('timeout', () => {
      console.log('[PERPLEXITY] ❌ Timeout');
      req.destroy();
      resolve(false);
    });

    req.write(data);
    req.end();
  });
}

async function testTavily() {
  const apiKey = process.env.TAVILY_API_KEY || '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';
  
  return new Promise((resolve, reject) => {
    const data = JSON.stringify({
      api_key: apiKey,
      query: 'Bob Crants',
      search_depth: 'basic',
      max_results: 3
    });

    const options = {
      protocol: 'https:',
      hostname: 'api.tavily.com',
      path: '/search',
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Content-Length': Buffer.byteLength(data)
      },
      timeout: 10000
    };

    console.log('[TAVILY] Testing search API...');
    
    const req = https.request(options, (res) => {
      let body = '';
      res.on('data', chunk => body += chunk);
      res.on('end', () => {
        try {
          const result = JSON.parse(body);
          if (result.results && result.results.length > 0) {
            console.log('[TAVILY] ✅ Success - Found', result.results.length, 'results');
            resolve(true);
          } else {
            console.log('[TAVILY] ⚠️ No results but API working');
            resolve(true);
          }
        } catch (e) {
          console.log('[TAVILY] ❌ Error:', e.message);
          console.log('Response:', body.substring(0, 200));
          resolve(false);
        }
      });
    });

    req.on('error', (e) => {
      console.log('[TAVILY] ❌ Request error:', e.message);
      resolve(false);
    });
    
    req.on('timeout', () => {
      console.log('[TAVILY] ❌ Timeout');
      req.destroy();
      resolve(false);
    });

    req.write(data);
    req.end();
  });
}

async function runTests() {
  console.log('='.repeat(60));
  console.log('TESTING API CONNECTIVITY');
  console.log('='.repeat(60));
  
  const results = {
    firecrawl: await testFirecrawl(),
    perplexity: await testPerplexity(),
    tavily: await testTavily()
  };
  
  console.log('\n' + '='.repeat(60));
  console.log('SUMMARY');
  console.log('='.repeat(60));
  
  const working = Object.values(results).filter(r => r).length;
  const total = Object.keys(results).length;
  
  console.log(`APIs Working: ${working}/${total}`);
  
  if (working === total) {
    console.log('✅ All APIs functional');
  } else {
    console.log('❌ Some APIs are failing');
    Object.entries(results).forEach(([api, status]) => {
      if (!status) {
        console.log(`  - ${api}: FAILED`);
      }
    });
  }
}

runTests();