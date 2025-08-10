#!/usr/bin/env node

const express = require('express');
const cors = require('cors');
const { exec } = require('child_process');
const fs = require('fs').promises;
const path = require('path');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.static(path.join(__dirname)));

// Base paths
const BASE_DIR = path.join(__dirname, '..');
const PROJECTS_DIR = path.join(BASE_DIR, '03_PROJECTS');
const SYSTEM_DIR = path.join(BASE_DIR, '00_SYSTEM');

// Research type configurations
const RESEARCH_CONFIGS = {
    'individual-oppo': {
        script: 'quick_research.sh',
        profile: 'Deep-Dive',
        projectType: 'INDIVIDUAL',
        framework: '6-Phase Strategic Intelligence',
        use_dataforseo_mcp: false,
        perform_mega_analysis: true,
        default_deliverable: 'document'
    },
    'company-deep': {
        script: 'quick_research.sh',
        profile: 'Company-Analysis',
        projectType: 'BUSINESS',
        framework: 'Business Strategic Intelligence',
        use_dataforseo_mcp: true,
        perform_mega_analysis: true,
        default_deliverable: 'both'
    },
    'seo-analysis': {
        script: 'quick_research.sh',
        profile: 'SEO-Analysis',
        projectType: 'BUSINESS',
        use_dataforseo_mcp: true,
        perform_mega_analysis: false,
        default_deliverable: 'document'
    },
    'market-research': {
        script: 'quick_research.sh',
        profile: 'Market-Research',
        projectType: 'BUSINESS',
        framework: 'GTM Intelligence',
        use_dataforseo_mcp: true,
        perform_mega_analysis: true,
        default_deliverable: 'document'
    },
    'technical-audit': {
        script: 'quick_research.sh',
        profile: 'Technical-Audit',
        projectType: 'BUSINESS',
        use_dataforseo_mcp: false,
        perform_mega_analysis: false,
        default_deliverable: 'document'
    },
    'custom': {
        script: 'quick_research.sh',
        profile: 'Custom',
        projectType: 'CUSTOM',
        use_dataforseo_mcp: false,
        perform_mega_analysis: true,
        default_deliverable: 'document'
    }
};

// Helper function to generate project folder name
function generateProjectFolder(targetName, researchType) {
    const timestamp = new Date().toISOString().replace(/[-:T]/g, '').slice(0, 14);
    const sanitizedName = targetName.replace(/[^a-zA-Z0-9]/g, '');
    const typePrefix = researchType.split('-')[0];
    return `Research_${typePrefix}_${sanitizedName}_${timestamp}`;
}

// Helper function to create PROJECT_CONFIG.json
async function createProjectConfig(projectPath, formData) {
    const researchConfig = RESEARCH_CONFIGS[formData.researchType];
    
    const config = {
        profile: researchConfig.profile,
        topic: formData.targetName,
        primary_objective: formData.researchPrompt,
        project_type: researchConfig.projectType,
        use_dataforseo_mcp: researchConfig.use_dataforseo_mcp || formData.seoAnalysis,
        perform_mega_analysis: formData.megaAnalysis,
        default_deliverable: formData.deliverable,
        research_depth: formData.researchDepth,
        features: {
            knowledge_graph: formData.knowledgeGraph,
            citations: formData.citations,
            risk_assessment: formData.riskAssessment,
            financial_analysis: formData.financialAnalysis,
            social_sentiment: formData.socialSentiment
        },
        custom_parameters: {
            geographic_scope: formData.geoScope || 'Global',
            timeframe: formData.timeframe || 'current',
            client_branding: formData.clientBranding
        },
        created_at: new Date().toISOString(),
        research_type: formData.researchType
    };
    
    const configPath = path.join(projectPath, 'PROJECT_CONFIG.json');
    await fs.writeFile(configPath, JSON.stringify(config, null, 2));
    
    return config;
}

// API endpoint to handle research requests
app.post('/api/research', async (req, res) => {
    try {
        const formData = req.body;
        
        // Validate required fields
        if (!formData.targetName || !formData.researchPrompt || !formData.researchType) {
            return res.status(400).json({
                success: false,
                error: 'Missing required fields'
            });
        }
        
        // Determine client folder
        let clientFolder = 'General';
        if (formData.clientBranding === 'pharos') {
            clientFolder = 'Pharos';
        } else if (formData.clientBranding === 'duarte') {
            clientFolder = 'Duarte';
        }
        
        // Create project folder
        const projectFolderName = generateProjectFolder(formData.targetName, formData.researchType);
        const projectPath = path.join(PROJECTS_DIR, clientFolder, projectFolderName);
        
        // Create directory structure
        await fs.mkdir(projectPath, { recursive: true });
        await fs.mkdir(path.join(projectPath, '01_searches'), { recursive: true });
        await fs.mkdir(path.join(projectPath, '02_fetched_content'), { recursive: true });
        await fs.mkdir(path.join(projectPath, '03_extracted_data'), { recursive: true });
        await fs.mkdir(path.join(projectPath, '04_analysis'), { recursive: true });
        await fs.mkdir(path.join(projectPath, '05_synthesis'), { recursive: true });
        await fs.mkdir(path.join(projectPath, '06_metadata'), { recursive: true });
        
        // Create PROJECT_CONFIG.json
        const config = await createProjectConfig(projectPath, formData);
        
        // Create RESEARCH_LOG.md
        const researchLog = `# Research Log
## Project: ${formData.targetName}
## Type: ${formData.researchType}
## Started: ${new Date().toISOString()}

### Configuration
- Research Type: ${formData.researchType}
- Depth: ${formData.researchDepth}
- Deliverable: ${formData.deliverable}
- Mega Analysis: ${formData.megaAnalysis}

### Research Prompt
${formData.researchPrompt}

### Status
- [${new Date().toISOString()}] Project initialized
- Awaiting research execution...
`;
        
        await fs.writeFile(path.join(projectPath, 'RESEARCH_LOG.md'), researchLog);
        
        // Create research execution script
        const executionScript = `#!/bin/bash
# Auto-generated research execution script
cd "${SYSTEM_DIR}"

echo "Starting research for: ${formData.targetName}"
echo "Research Type: ${formData.researchType}"
echo "Project Folder: ${projectPath}"

# Set environment variables
export RESEARCH_PROJECT_PATH="${projectPath}"
export RESEARCH_TYPE="${formData.researchType}"
export TARGET_NAME="${formData.targetName}"

# Execute research based on type
case "${formData.researchType}" in
    "individual-oppo")
        echo "Executing Individual Opposition Research..."
        # Call the research script with appropriate parameters
        ./quick_research.sh --individual "${formData.targetName}" "${formData.researchPrompt}"
        ;;
    "company-deep")
        echo "Executing Company Deep Analysis..."
        ./quick_research.sh --company "${formData.targetName}" "${formData.researchPrompt}"
        ;;
    "seo-analysis")
        echo "Executing SEO Analysis..."
        ./quick_research.sh --seo "${formData.targetName}" "${formData.researchPrompt}"
        ;;
    *)
        echo "Executing Custom Research..."
        ./quick_research.sh --custom "${formData.targetName}" "${formData.researchPrompt}"
        ;;
esac

# Run mega-analysis if enabled
if [ "${formData.megaAnalysis}" = "true" ]; then
    echo "Running Mega-Analysis..."
    ./run-mega-analysis.sh "${projectPath}"
fi

# Generate deliverables
echo "Generating deliverables..."
case "${formData.deliverable}" in
    "document")
        ./create-premium-document.sh "${projectPath}/05_synthesis/FINAL_RESEARCH_REPORT.md"
        ;;
    "presentation")
        ./create-presentation.sh "${projectPath}"
        ;;
    "both")
        ./create-premium-document.sh "${projectPath}/05_synthesis/FINAL_RESEARCH_REPORT.md"
        ./create-presentation.sh "${projectPath}"
        ;;
esac

echo "Research completed successfully!"
`;
        
        const scriptPath = path.join(projectPath, 'execute_research.sh');
        await fs.writeFile(scriptPath, executionScript);
        await fs.chmod(scriptPath, '755');
        
        // Return success response
        res.json({
            success: true,
            projectId: projectFolderName,
            projectPath: projectPath,
            config: config,
            message: 'Research project initialized successfully',
            executionScript: scriptPath,
            statusUrl: `/status/${projectFolderName}`
        });
        
    } catch (error) {
        console.error('Error creating research project:', error);
        res.status(500).json({
            success: false,
            error: error.message
        });
    }
});

// API endpoint to check research status
app.get('/api/status/:projectId', async (req, res) => {
    try {
        const projectId = req.params.projectId;
        
        // Search for project in all client folders
        const clients = ['General', 'Pharos', 'Duarte'];
        let projectPath = null;
        
        for (const client of clients) {
            const testPath = path.join(PROJECTS_DIR, client, projectId);
            try {
                await fs.access(testPath);
                projectPath = testPath;
                break;
            } catch (e) {
                // Continue searching
            }
        }
        
        if (!projectPath) {
            return res.status(404).json({
                success: false,
                error: 'Project not found'
            });
        }
        
        // Read project config and log
        const config = JSON.parse(await fs.readFile(path.join(projectPath, 'PROJECT_CONFIG.json'), 'utf8'));
        const log = await fs.readFile(path.join(projectPath, 'RESEARCH_LOG.md'), 'utf8');
        
        // Check for completed files
        const files = await fs.readdir(path.join(projectPath, '05_synthesis')).catch(() => []);
        
        res.json({
            success: true,
            projectId: projectId,
            config: config,
            log: log,
            synthesisFiles: files,
            status: files.length > 0 ? 'completed' : 'in_progress'
        });
        
    } catch (error) {
        res.status(500).json({
            success: false,
            error: error.message
        });
    }
});

// Serve the frontend
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'index.html'));
});

// Start server
app.listen(PORT, () => {
    console.log(`
    ========================================
    MRP Research System Server
    ========================================
    Server running at: http://localhost:${PORT}
    Frontend: http://localhost:${PORT}
    API Endpoint: http://localhost:${PORT}/api/research
    ========================================
    `);
});