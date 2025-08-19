#!/bin/bash

echo "🚨 CRITICAL: Setting missing API keys in Railway production environment"
echo ""
echo "Service: mrp-intelligence-real (d021d994-c477-435d-b1ab-b77898c7e6be)"
echo "Environment: production"
echo ""

# Note: These are placeholder values - user needs to provide real API keys
echo "Setting placeholder API keys (USER MUST UPDATE WITH REAL VALUES):"
echo ""

echo "1. Setting Firecrawl API key..."
railway variables set FIRECRAWL_API_KEY="fc-placeholder-key-needs-real-value"

echo "2. Setting Perplexity API key..."
railway variables set PERPLEXITY_API_KEY="pplx-placeholder-key-needs-real-value"

echo "3. Setting Tavily API key..."
railway variables set TAVILY_API_KEY="tvly-placeholder-key-needs-real-value"

echo "4. Setting DataForSEO credentials..."
railway variables set DATAFORSEO_LOGIN="placeholder-login-needs-real-value"
railway variables set DATAFORSEO_PASSWORD="placeholder-password-needs-real-value"

echo "5. Setting Reddit API credentials..."
railway variables set REDDIT_CLIENT_ID="placeholder-reddit-id-needs-real-value"
railway variables set REDDIT_CLIENT_SECRET="placeholder-reddit-secret-needs-real-value"

echo "6. Setting Gemini API key..."
railway variables set GEMINI_API_KEY="placeholder-gemini-key-needs-real-value"

echo ""
echo "✅ Placeholder API keys set. USER MUST UPDATE WITH REAL VALUES!"
echo ""
echo "To update with real values, run:"
echo "railway variables set FIRECRAWL_API_KEY='real-key-here'"
echo "railway variables set PERPLEXITY_API_KEY='real-key-here'"
echo "# etc..."
echo ""
echo "Then redeploy: railway up --service mrp-intelligence-real --detach"