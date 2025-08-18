#!/usr/bin/env python3

"""
Web API Server for Research Generation System
Simple Flask API for internal use to trigger research and output generation
"""

from flask import Flask, request, jsonify, render_template_string
from flask_cors import CORS
import json
import os
import sys
from pathlib import Path
from datetime import datetime
import logging

# Add parent directory to path for imports
sys.path.append(str(Path(__file__).parent))
from backend_api import ResearchPDFGenerator

# Initialize Flask app
app = Flask(__name__)
CORS(app)  # Enable CORS for all routes

# Setup logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# HTML template for simple web interface
HTML_TEMPLATE = """
<!DOCTYPE html>
<html>
<head>
    <title>Waterloo Research Generator - Internal</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        .container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            padding: 40px;
            max-width: 600px;
            width: 100%;
        }
        h1 {
            color: #1B365D;
            margin-bottom: 10px;
            font-size: 28px;
        }
        .subtitle {
            color: #666;
            margin-bottom: 30px;
            font-size: 14px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            color: #333;
            font-weight: 500;
        }
        input, select {
            width: 100%;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.3s;
        }
        input:focus, select:focus {
            outline: none;
            border-color: #667eea;
        }
        .radio-group {
            display: flex;
            gap: 20px;
            margin-top: 5px;
        }
        .radio-item {
            display: flex;
            align-items: center;
            gap: 5px;
        }
        .checkbox-group {
            display: flex;
            gap: 20px;
            margin-top: 10px;
        }
        .checkbox-item {
            display: flex;
            align-items: center;
            gap: 5px;
        }
        .toggle-section {
            background: #f5f5f5;
            padding: 15px;
            border-radius: 8px;
            margin-top: 10px;
        }
        button {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 15px 30px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            width: 100%;
            transition: transform 0.2s;
        }
        button:hover {
            transform: translateY(-2px);
        }
        button:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }
        .status {
            margin-top: 20px;
            padding: 15px;
            border-radius: 8px;
            display: none;
        }
        .status.success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .status.error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .status.loading {
            background: #d1ecf1;
            color: #0c5460;
            border: 1px solid #bee5eb;
            display: block;
        }
        .spinner {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 3px solid rgba(0,0,0,.1);
            border-radius: 50%;
            border-top-color: #0c5460;
            animation: spin 1s ease-in-out infinite;
        }
        @keyframes spin {
            to { transform: rotate(360deg); }
        }
        .output-links {
            margin-top: 15px;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 8px;
        }
        .output-links a {
            color: #667eea;
            text-decoration: none;
            display: block;
            margin: 5px 0;
        }
        .output-links a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🔍 Waterloo Research Generator</h1>
        <p class="subtitle">Internal Research & Intelligence System</p>
        
        <form id="researchForm">
            <div class="form-group">
                <label>Research Type *</label>
                <div class="radio-group">
                    <div class="radio-item">
                        <input type="radio" id="individual" name="research_type" value="individual" required>
                        <label for="individual">Individual</label>
                    </div>
                    <div class="radio-item">
                        <input type="radio" id="organization" name="research_type" value="organization" checked>
                        <label for="organization">Organization</label>
                    </div>
                    <div class="radio-item">
                        <input type="radio" id="audience" name="research_type" value="audience">
                        <label for="audience">Audience</label>
                    </div>
                </div>
            </div>
            
            <div class="form-group">
                <label for="target_name">Target Name *</label>
                <input type="text" id="target_name" name="target_name" required 
                       placeholder="e.g., John Smith, Apple Inc., Millennials">
            </div>
            
            <div class="form-group">
                <label for="template">Document Template</label>
                <select id="template" name="template">
                    <option value="corporate">Corporate Professional</option>
                    <option value="tufte">Tufte Academic</option>
                    <option value="sakura">Sakura Minimal</option>
                    <option value="classic">Classic Academic</option>
                </select>
            </div>
            
            <div class="form-group">
                <label>Output Options</label>
                <div class="checkbox-group">
                    <div class="checkbox-item">
                        <input type="checkbox" id="output_pdf" name="output_pdf" checked>
                        <label for="output_pdf">Generate PDF</label>
                    </div>
                    <div class="checkbox-item">
                        <input type="checkbox" id="output_wordpress" name="output_wordpress">
                        <label for="output_wordpress">Publish to WordPress</label>
                    </div>
                </div>
            </div>
            
            <div class="form-group" id="audienceOptions" style="display:none;">
                <label>
                    <input type="checkbox" id="include_keywords" name="include_keywords">
                    Enable DataForSEO Keyword Analysis (+$)
                </label>
                <div class="toggle-section" id="keywordSection" style="display:none;">
                    <label for="keywords">Keywords (comma-separated)</label>
                    <input type="text" id="keywords" name="keywords" 
                           placeholder="keyword1, keyword2, keyword3">
                </div>
            </div>
            
            <div class="form-group">
                <label for="project_path">Existing Project Path (optional)</label>
                <input type="text" id="project_path" name="project_path" 
                       placeholder="Leave blank to search automatically">
            </div>
            
            <button type="submit">Generate Research</button>
        </form>
        
        <div id="status" class="status"></div>
        <div id="outputLinks" class="output-links" style="display:none;"></div>
    </div>
    
    <script>
        // Show/hide audience options
        document.querySelectorAll('input[name="research_type"]').forEach(radio => {
            radio.addEventListener('change', (e) => {
                const audienceOptions = document.getElementById('audienceOptions');
                audienceOptions.style.display = e.target.value === 'audience' ? 'block' : 'none';
            });
        });
        
        // Show/hide keyword section
        document.getElementById('include_keywords').addEventListener('change', (e) => {
            const keywordSection = document.getElementById('keywordSection');
            keywordSection.style.display = e.target.checked ? 'block' : 'none';
        });
        
        // Form submission
        document.getElementById('researchForm').addEventListener('submit', async (e) => {
            e.preventDefault();
            
            const statusDiv = document.getElementById('status');
            const outputDiv = document.getElementById('outputLinks');
            const submitBtn = e.target.querySelector('button');
            
            // Show loading state
            statusDiv.className = 'status loading';
            statusDiv.innerHTML = '<span class="spinner"></span> Generating research outputs...';
            statusDiv.style.display = 'block';
            outputDiv.style.display = 'none';
            submitBtn.disabled = true;
            
            // Collect form data
            const formData = new FormData(e.target);
            const data = {
                research_type: formData.get('research_type'),
                target_name: formData.get('target_name'),
                template: formData.get('template'),
                output_types: [],
                project_path: formData.get('project_path') || null
            };
            
            // Determine output types
            if (formData.get('output_pdf')) data.output_types.push('pdf');
            if (formData.get('output_wordpress')) data.output_types.push('wordpress');
            
            // Handle audience-specific options
            if (data.research_type === 'audience' && formData.get('include_keywords')) {
                data.include_keywords = true;
                const keywords = formData.get('keywords');
                if (keywords) {
                    data.keywords = keywords.split(',').map(k => k.trim());
                }
            }
            
            try {
                const response = await fetch('/api/generate', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(data)
                });
                
                const result = await response.json();
                
                if (result.success) {
                    statusDiv.className = 'status success';
                    statusDiv.innerHTML = '✅ ' + result.message;
                    
                    // Show output links
                    let linksHTML = '<strong>Generated Outputs:</strong><br>';
                    
                    if (result.outputs?.pdf?.success) {
                        linksHTML += `📄 PDF: ${result.outputs.pdf.path}<br>`;
                    }
                    
                    if (result.outputs?.wordpress?.success) {
                        linksHTML += `🌐 WordPress: <a href="${result.outputs.wordpress.post_url}" target="_blank">View Post</a><br>`;
                        linksHTML += `✏️ Edit: <a href="${result.outputs.wordpress.edit_url}" target="_blank">Edit in WordPress</a><br>`;
                    }
                    
                    outputDiv.innerHTML = linksHTML;
                    outputDiv.style.display = 'block';
                } else {
                    statusDiv.className = 'status error';
                    statusDiv.innerHTML = '❌ ' + (result.error || 'Generation failed');
                }
            } catch (error) {
                statusDiv.className = 'status error';
                statusDiv.innerHTML = '❌ Error: ' + error.message;
            } finally {
                submitBtn.disabled = false;
            }
        });
    </script>
</body>
</html>
"""

@app.route('/')
def index():
    """Serve the web interface"""
    return render_template_string(HTML_TEMPLATE)

@app.route('/api/generate', methods=['POST'])
def generate():
    """API endpoint to generate research outputs"""
    
    try:
        # Get request data
        data = request.json
        logger.info(f"Received request: {data}")
        
        # Initialize generator
        generator = ResearchPDFGenerator()
        
        # Generate outputs
        result = generator.generate_outputs(data)
        
        return jsonify(result)
        
    except Exception as e:
        logger.error(f"Generation failed: {str(e)}")
        return jsonify({
            'success': False,
            'error': str(e)
        }), 500

@app.route('/api/status', methods=['GET'])
def status():
    """Health check endpoint"""
    return jsonify({
        'status': 'healthy',
        'service': 'Waterloo Research Generator',
        'version': '1.0.0',
        'timestamp': datetime.now().isoformat()
    })

@app.route('/api/projects', methods=['GET'])
def list_projects():
    """List existing research projects"""
    
    try:
        projects_dir = Path.cwd() / "03_PROJECTS"
        projects = []
        
        if projects_dir.exists():
            for client_dir in projects_dir.iterdir():
                if client_dir.is_dir():
                    for project_dir in client_dir.glob("Research_*"):
                        if project_dir.is_dir():
                            # Read project config if exists
                            config_file = project_dir / "PROJECT_CONFIG.json"
                            config = {}
                            if config_file.exists():
                                with open(config_file, 'r') as f:
                                    config = json.load(f)
                            
                            projects.append({
                                'path': str(project_dir),
                                'name': project_dir.name,
                                'client': client_dir.name,
                                'config': config,
                                'modified': datetime.fromtimestamp(
                                    project_dir.stat().st_mtime
                                ).isoformat()
                            })
        
        # Sort by modification time (newest first)
        projects.sort(key=lambda x: x['modified'], reverse=True)
        
        return jsonify({
            'success': True,
            'projects': projects,
            'count': len(projects)
        })
        
    except Exception as e:
        return jsonify({
            'success': False,
            'error': str(e)
        }), 500

if __name__ == '__main__':
    # Check for WordPress credentials
    if not os.getenv('WP_USERNAME') or not os.getenv('WP_PASSWORD'):
        print("⚠️ Warning: WordPress credentials not set")
        print("Set WP_USERNAME and WP_PASSWORD environment variables for WordPress publishing")
    
    # Run the development server
    print("🚀 Starting Waterloo Research Generator API")
    print("📍 Access the web interface at: http://localhost:5000")
    print("📍 API endpoint: http://localhost:5000/api/generate")
    print("")
    
    app.run(host='0.0.0.0', port=5000, debug=True)