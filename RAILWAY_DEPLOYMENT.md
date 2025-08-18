# Railway Deployment Instructions

Since CLI is in non-interactive mode, please follow these steps:

## 1. Create Project on Railway Dashboard

1. Go to: https://railway.app/dashboard
2. Click "New Project"
3. Select "Deploy from GitHub repo"
4. Choose: `drdrstudio/claude-code-research`
5. Name it: `mrp-intelligence`

## 2. Set Environment Variables

In Railway dashboard, go to your project → Variables tab and add:

```bash
# Required API Keys
GEMINI_API_KEY=your_key_here
FIRECRAWL_API_KEY=your_key_here
PERPLEXITY_API_KEY=your_key_here

# Optional but Recommended
DATAFORSEO_LOGIN=your_login
DATAFORSEO_PASSWORD=your_password
REDDIT_CLIENT_ID=your_client_id
REDDIT_CLIENT_SECRET=your_secret
TAVILY_API_KEY=your_key

# System Settings
NODE_ENV=production
PORT=3000
```

## 3. Deploy Settings

Railway should auto-detect from our `package.json` and `railway.json`, but verify:

- **Start Command:** `node 00_SYSTEM/api/enhanced-research-server.js`
- **Build Command:** None needed (pure Node.js)
- **Root Directory:** `/` (project root)

## 4. Get Your URL

After deployment, Railway will provide a URL like:
```
https://mrp-intelligence.up.railway.app
```

## 5. Manual CLI Link (Alternative)

If you want to link via CLI after creating on dashboard:

```bash
# Get project ID from Railway dashboard
railway link <project-id>

# Then deploy
railway up
```

## What Railway Provides vs Vercel:

### Railway Advantages ✅
- **No timeout limits** (research can run 30+ minutes)
- **Persistent file system** (can save PDFs)
- **Background workers** supported
- **Real bash script execution**
- **WebSocket support** for real-time updates
- **Cron jobs** available
- **Better for long-running processes**

### Railway Pricing
- **Free tier:** 500 hours/month ($5 credit)
- **Hobby:** $5/month flat
- **Pro:** Usage-based

## Test Your Deployment

Once deployed, visit your Railway URL and you should see the MRP Intelligence System interface with:
- Real-time progress tracking
- PDF generation and viewing
- Full research pipeline execution

## Troubleshooting

If the deployment fails, check:
1. All files are committed to Git
2. Node.js version is compatible (>=18)
3. Environment variables are set
4. GitHub integration is authorized

## Local Testing First

Before deploying, test locally:
```bash
node 00_SYSTEM/api/enhanced-research-server.js
```

Then visit http://localhost:5001