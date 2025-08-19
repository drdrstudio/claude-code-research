#!/bin/bash

# Add all required API keys to Railway environment
# Based on user's screenshot, these should already be set but aren't loading

echo "Adding environment variables to Railway..."

# Note: User needs to run these commands manually or we need Railway CLI properly linked
echo "Run these commands to add missing environment variables:"
echo ""
echo "railway variables set FIRECRAWL_API_KEY=<your_key>"
echo "railway variables set PERPLEXITY_API_KEY=<your_key>"  
echo "railway variables set TAVILY_API_KEY=<your_key>"
echo "railway variables set DATAFORSEO_LOGIN=<your_login>"
echo "railway variables set DATAFORSEO_PASSWORD=<your_password>"
echo "railway variables set REDDIT_CLIENT_ID=<your_id>"
echo "railway variables set REDDIT_CLIENT_SECRET=<your_secret>"
echo "railway variables set GEMINI_API_KEY=<your_key>"
echo ""
echo "OR check Railway dashboard at:"
echo "https://railway.app/project/08cea438-8d53-471a-8c54-d7c372963bfb/service/d021d994-c477-435d-b1ab-b77898c7e6be/variables"