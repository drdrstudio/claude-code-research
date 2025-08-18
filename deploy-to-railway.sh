#!/bin/bash

echo "🚀 Deploying MRP Intelligence System to Railway"
echo "============================================="
echo ""

# Check if logged in
if ! railway whoami > /dev/null 2>&1; then
    echo "❌ Not logged in to Railway"
    echo "Please run: railway login"
    exit 1
fi

echo "✅ Logged in to Railway"
echo ""

# Initialize new project
echo "📦 Creating new Railway project..."
railway init -n mrp-intelligence

# Link to the project
echo "🔗 Project created and linked"
echo ""

# Deploy
echo "🚀 Starting deployment..."
railway up --detach

echo ""
echo "✅ Deployment initiated!"
echo ""
echo "📝 Next steps:"
echo "1. Run: railway open"
echo "   (This opens your project in the browser)"
echo ""
echo "2. Go to Variables tab and add:"
echo "   GEMINI_API_KEY=your_key"
echo "   FIRECRAWL_API_KEY=your_key"
echo "   PERPLEXITY_API_KEY=your_key"
echo ""
echo "3. Railway will provide your URL in the Settings tab"
echo ""
echo "4. Your app will be live at:"
echo "   https://mrp-intelligence-production.up.railway.app"
echo "   (or similar URL)"