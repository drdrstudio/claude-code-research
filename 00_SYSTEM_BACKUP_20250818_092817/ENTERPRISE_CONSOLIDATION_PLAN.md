# Enterprise Consolidation Plan for MRP v7.0
## Transform Chaos into $5K Enterprise Intelligence System

### Executive Summary
The current system has solid capabilities but suffers from "multiple Claude syndrome" - each session added features without removing old ones. This plan consolidates 52 scripts into ~15 core components while adding enterprise features.

---

## 🎯 CONSOLIDATION STRATEGY

### Phase 1: PDF Generation Consolidation
**Current State:** 6 different PDF generators with overlapping functionality
**Target State:** 1 unified intelligent generator

#### Scripts to DELETE:
```bash
# Remove these redundant PDF generators
rm create-document.sh               # Basic, superseded
rm create-enterprise-document.sh    # Overlaps with premium
rm create-premium-enterprise-document.sh  # Redundant with premium
rm create-research-pdf-with-citations.sh  # Functionality merged
```

#### Scripts to KEEP & ENHANCE:
```bash
# Keep and rename to be THE pdf generator
mv create-premium-document.sh generate-pdf.sh
mv generate-research-pdf-automated.sh generate-pdf-backend.py
```

#### NEW Unified PDF Interface:
```bash
./generate-pdf.sh \
  --input "document.md" \
  --quality [standard|premium|enterprise] \
  --template [corporate|tufte|sakura|classic] \
  --branding [pharos|duarte|generic] \
  --citations [auto|manual|none]
```

---

### Phase 2: Entry Point Consolidation
**Current State:** Multiple launchers and dispatchers
**Target State:** Single smart router

#### Scripts to DELETE:
```bash
rm research-dispatcher.sh     # Redundant with mrp-launcher
rm test-reputational-scan.sh  # Test file in production
rm enhanced-research-demo.sh  # Demo in production
rm quick_research.sh          # Unclear purpose
```

#### Scripts to KEEP:
```bash
# Primary entry points
mrp-launcher.sh               # CLI interface
web-api-server.py            # Web interface
research-pdf-api.py          # Backend API

# Recipe-specific dispatchers (keep but standardize)
reputational-scan-dispatcher.sh
organizational-scan-dispatcher.sh
gtm-marketing-dispatcher.sh
```

---

### Phase 3: Directory Restructure

#### NEW Structure:
```
00_SYSTEM/
├── config/
│   ├── system.yaml           # Central configuration
│   ├── mcp-standards.json    # MCP tool configs
│   └── api-keys.env         # Secure key storage
│
├── core/
│   ├── mrp-launcher.sh      # Primary CLI entry
│   ├── generate-pdf.sh      # Unified PDF generator
│   ├── run-mega-analysis.sh # Gemini synthesis
│   └── build-knowledge-graph.sh
│
├── recipes/
│   ├── reputational/
│   │   ├── prompt-v5.md
│   │   ├── dispatcher.sh
│   │   └── config.json
│   ├── organizational/
│   │   ├── prompt.md
│   │   ├── dispatcher.sh
│   │   └── config.json
│   └── gtm/
│       ├── prompt.md
│       ├── dispatcher.sh
│       └── config.json
│
├── api/
│   ├── web-server.py        # Flask web interface
│   ├── backend-api.py       # Core API logic
│   └── wordpress-publisher.py
│
├── templates/
│   ├── pdf/
│   │   ├── corporate.tex
│   │   ├── tufte.tex
│   │   └── sakura.css
│   └── logos/
│       ├── pharos-logo.png
│       └── duarte-logo.png
│
├── utils/
│   ├── citation-extractor.sh
│   ├── citation-inserter.py
│   └── entity-extractor.sh
│
└── logs/
    ├── research.log
    ├── errors.log
    └── api-access.log
```

---

### Phase 4: Add Enterprise Features

#### 1. Central Configuration (config/system.yaml):
```yaml
system:
  version: "7.0"
  environment: "production"
  
research:
  default_depth: "comprehensive"
  min_sources: 50
  min_pages: 20
  
mcp_tools:
  priority:
    - firecrawl
    - perplexity
    - dataforseo
    - sequential_thinking
    - reddit
    - playwright
    - tavily  # last resort
    
pricing:
  target_value: 5000
  cost_tracking: true
  
logging:
  level: "INFO"
  rotation: "daily"
  retention_days: 30
```

#### 2. Error Handling Framework:
```python
# utils/error_handler.py
class ResearchError(Exception):
    def __init__(self, message, phase, recoverable=True):
        self.message = message
        self.phase = phase
        self.recoverable = recoverable
        self.timestamp = datetime.now()
        self.log_error()
```

#### 3. Job Queue System:
```python
# api/job_queue.py
from redis import Redis
from rq import Queue

class ResearchQueue:
    def __init__(self):
        self.redis = Redis()
        self.queue = Queue(connection=self.redis)
    
    def submit_research(self, params):
        job = self.queue.enqueue(
            'core.research_engine.execute',
            params,
            timeout='4h',
            result_ttl='7d'
        )
        return job.id
```

#### 4. Progress Tracking:
```python
# api/progress_tracker.py
class ProgressTracker:
    phases = [
        "initialization",
        "search_execution", 
        "content_extraction",
        "synthesis",
        "verification",
        "pdf_generation"
    ]
    
    def update(self, job_id, phase, progress):
        # Store in Redis for real-time updates
        self.redis.hset(f"job:{job_id}", {
            "phase": phase,
            "progress": progress,
            "timestamp": datetime.now()
        })
```

---

### Phase 5: Scripts to Create

#### 1. Migration Script (migrate-to-v7.sh):
```bash
#!/bin/bash
# Automated migration to v7.0 structure

echo "🚀 Migrating MRP to v7.0 Enterprise Structure..."

# Backup current system
cp -r 00_SYSTEM 00_SYSTEM_BACKUP_$(date +%Y%m%d)

# Create new directories
mkdir -p 00_SYSTEM/{config,core,recipes,api,templates,utils,logs}
mkdir -p 00_SYSTEM/recipes/{reputational,organizational,gtm}
mkdir -p 00_SYSTEM/templates/{pdf,logos}

# Move and consolidate files
# ... (migration logic)

echo "✅ Migration complete!"
```

#### 2. Health Check Script (health-check.sh):
```bash
#!/bin/bash
# System health verification

echo "🏥 MRP System Health Check v7.0"

# Check MCP tools
echo "Checking MCP connections..."
for tool in firecrawl perplexity dataforseo; do
    # Test each tool
done

# Check API keys
echo "Verifying API keys..."
# ... verification logic

# Check disk space
echo "Storage check..."
df -h | grep -E "^/|System"

# Generate report
echo "Generating health report..."
```

---

### Phase 6: Deprecation Schedule

#### Immediate Removal:
- All test/demo scripts
- Duplicate PDF generators
- Unused Python scripts in root

#### Phase Out (30 days):
- Old dispatcher names (after updating references)
- Legacy citation system
- Manual recipe selection

#### Archive (Keep for reference):
- Previous prompts versions
- Old templates
- Migration logs

---

## 🚀 IMPLEMENTATION TIMELINE

### Week 1: Foundation
- [ ] Backup entire system
- [ ] Create new directory structure
- [ ] Consolidate PDF generators
- [ ] Set up central config

### Week 2: Core Systems
- [ ] Implement error handling
- [ ] Add logging framework
- [ ] Create job queue
- [ ] Build progress tracker

### Week 3: Testing & Migration
- [ ] Test all recipes
- [ ] Migrate existing projects
- [ ] Update documentation
- [ ] Train team on new structure

### Week 4: Enterprise Features
- [ ] Add metrics dashboard
- [ ] Implement cost tracking
- [ ] Set up monitoring
- [ ] Create admin interface

---

## 📊 SUCCESS METRICS

1. **Reduction in Scripts:** 52 → 15 core components
2. **API Response Time:** < 2 seconds for job submission
3. **Error Recovery:** 95% of errors handled gracefully
4. **Cost Tracking:** 100% of MCP usage logged
5. **Documentation:** Every function documented
6. **Test Coverage:** 80% minimum

---

## 🎯 FINAL STATE VISION

A **single, elegant system** where:
- One command launches any research type
- Progress is trackable in real-time
- Errors are handled gracefully
- Costs are tracked automatically
- Output quality is consistent
- Enterprise clients get $5K+ value

**No more archaeological layers. Just clean, enterprise-grade intelligence generation.**