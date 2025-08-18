# MRP v7.0 Deployment Guide

## 🚀 Quick Start (Local)
The easiest way to use MRP is locally on your Mac:

1. **Double-click** `00_SYSTEM/START_MRP_RESEARCH.command`
2. Your browser opens automatically
3. Start researching!

---

## 📦 GitHub Repository
- **URL:** https://github.com/drdrstudio/claude-code-research
- **Status:** Successfully pushed v7.0
- **Branch:** main

---

## 🌐 Deployment Options

### Option 1: Local Usage (Current Setup) ✅
**Best for:** Personal use, maximum privacy, full control

**Pros:**
- No hosting costs
- Complete data privacy
- Full API key control
- Instant setup

**Cons:**
- Computer must be on
- Not accessible remotely
- Single user only

---

### Option 2: Deploy to Vercel (Free Tier)
**Best for:** Remote access, sharing with small team

```bash
# Install Vercel CLI
npm i -g vercel

# Deploy
cd 00_SYSTEM/web-interface
vercel

# Set environment variables in Vercel dashboard
GEMINI_API_KEY=your_key
FIRECRAWL_API_KEY=your_key
PERPLEXITY_API_KEY=your_key
```

**URL Pattern:** `https://mrp-research.vercel.app`

**Pros:**
- Free hosting (with limits)
- Accessible anywhere
- Automatic HTTPS
- Easy deployment

**Cons:**
- API keys in cloud
- Limited compute time
- Public URL (unless Pro)

---

### Option 3: Deploy to Render.com
**Best for:** Professional use, background jobs

```yaml
# render.yaml
services:
  - type: web
    name: mrp-frontend
    env: static
    buildCommand: npm install
    staticPublishPath: ./00_SYSTEM/web-interface
    
  - type: web
    name: mrp-backend
    env: python
    buildCommand: pip install -r requirements.txt
    startCommand: python api/web-server.py
    envVars:
      - key: GEMINI_API_KEY
        sync: false
```

**URL Pattern:** `https://mrp-research.onrender.com`

**Pros:**
- Background jobs support
- Better for long-running research
- PostgreSQL included
- Good free tier

**Cons:**
- Slower cold starts
- Limited free hours

---

### Option 4: Deploy to Railway
**Best for:** Production use, team collaboration

```bash
# Install Railway CLI
npm install -g @railway/cli

# Login and deploy
railway login
railway init
railway up

# Add environment variables
railway variables set GEMINI_API_KEY=your_key
```

**URL Pattern:** `https://mrp-research.railway.app`

**Pros:**
- Excellent developer experience
- Fast deployments
- Good monitoring
- Team collaboration

**Cons:**
- No free tier
- ~$5/month minimum

---

### Option 5: Deploy to AWS/GCP/Azure
**Best for:** Enterprise deployment, maximum control

**AWS Elastic Beanstalk Example:**
```bash
# Install EB CLI
pip install awsebcli

# Initialize and deploy
eb init -p python-3.9 mrp-research
eb create mrp-production
eb setenv GEMINI_API_KEY=your_key
eb deploy
```

**Pros:**
- Enterprise-grade
- Complete control
- Scalable
- Private networking options

**Cons:**
- Complex setup
- Higher costs
- Requires DevOps knowledge

---

## 🔐 Security Considerations

### API Key Management
**Never commit API keys to Git!**

**Local Development:**
```bash
# .env file (gitignored)
GEMINI_API_KEY=your_key_here
FIRECRAWL_API_KEY=your_key_here
PERPLEXITY_API_KEY=your_key_here
```

**Production:**
- Use platform environment variables
- Consider using AWS Secrets Manager
- Rotate keys regularly
- Use different keys for dev/prod

### Access Control
For production deployments, add authentication:

```python
# api/auth.py
from flask_httpauth import HTTPBasicAuth

auth = HTTPBasicAuth()

users = {
    "admin": "strong_password_here"
}

@auth.verify_password
def verify_password(username, password):
    if username in users and users[username] == password:
        return username
```

---

## 🔧 Environment Setup

### Required Environment Variables
```bash
# Core (Required)
GEMINI_API_KEY=        # For synthesis
FIRECRAWL_API_KEY=     # For deep extraction
PERPLEXITY_API_KEY=    # For AI search

# Optional
DATAFORSEO_LOGIN=      # For SEO data
DATAFORSEO_PASSWORD=   
REDDIT_CLIENT_ID=      # For Reddit sentiment
REDDIT_CLIENT_SECRET=
TAVILY_API_KEY=        # Backup search
```

### Python Requirements
```txt
# requirements.txt
flask==2.3.0
flask-cors==4.0.0
requests==2.31.0
python-dotenv==1.0.0
uuid==1.30
```

---

## 📊 Monitoring & Logs

### Local Monitoring
```bash
# View logs
tail -f 00_SYSTEM/logs/research.log

# Check system health
./health-check-v7.sh
```

### Production Monitoring
- **Vercel:** Built-in analytics dashboard
- **Render:** Logs in dashboard
- **Railway:** Integrated monitoring
- **AWS:** CloudWatch logs

---

## 🚨 Troubleshooting

### Common Issues

**Port 5000 already in use:**
```bash
lsof -ti:5000 | xargs kill -9
```

**Python dependencies missing:**
```bash
pip3 install -r requirements.txt
```

**API keys not working:**
- Check environment variables are set
- Verify keys are active
- Check API quotas/limits

**Research taking too long:**
- Reduce depth setting
- Check API rate limits
- Monitor system resources

---

## 📈 Scaling Considerations

### For Teams (5-10 users)
- Deploy to Vercel/Render
- Add basic authentication
- Use shared API keys with higher limits
- Monitor usage closely

### For Organizations (10+ users)
- Deploy to AWS/GCP
- Implement user authentication
- Use API key rotation
- Add queue system (Redis/RabbitMQ)
- Implement caching layer
- Set up monitoring/alerting

### For Enterprise
- Private cloud deployment
- SSO integration
- Audit logging
- Compliance controls
- SLA monitoring
- Dedicated support

---

## 💰 Cost Estimates

### Local Only
- **Infrastructure:** $0
- **API Costs:** ~$50-200/month depending on usage

### Cloud Deployment (Small Team)
- **Vercel/Render:** $0-20/month
- **API Costs:** ~$100-500/month
- **Total:** ~$100-520/month

### Enterprise Deployment
- **AWS/GCP:** $500-2000/month
- **API Costs:** $1000-5000/month
- **Support:** $500-2000/month
- **Total:** ~$2000-9000/month

---

## 📞 Support

### Community Support
- GitHub Issues: https://github.com/drdrstudio/claude-code-research/issues
- Documentation: This guide + README.md

### Professional Support
- Contact: [Your contact info]
- Custom deployment assistance available
- Training and onboarding services

---

## 🎯 Next Steps

1. **For Personal Use:** Just use the local setup
2. **For Teams:** Deploy to Vercel/Render
3. **For Enterprise:** Contact for professional deployment

The system is now ready for any deployment scenario!