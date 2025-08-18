#!/usr/bin/env python3
"""
MRP Intelligence System API - Vercel Deployment
"""
import os
import json
import subprocess
from flask import Flask, request, jsonify, send_from_directory
from flask_cors import CORS
from datetime import datetime
import threading
import uuid

app = Flask(__name__)
CORS(app)

# Store job status (in production, use Redis or database)
jobs = {}

@app.route('/')
def index():
    """Serve the main web interface"""
    return '''
    <!DOCTYPE html>
    <html>
    <head>
        <title>MRP Intelligence System</title>
        <meta http-equiv="refresh" content="0; url=/index.html">
    </head>
    <body>
        <p>Redirecting to MRP Intelligence System...</p>
    </body>
    </html>
    '''

@app.route('/api/health')
def health():
    """Health check endpoint"""
    return jsonify({
        'status': 'healthy',
        'version': '7.0',
        'timestamp': datetime.now().isoformat()
    })

@app.route('/api/research', methods=['POST'])
def start_research():
    """Start a new research job"""
    data = request.json
    job_id = str(uuid.uuid4())
    
    # Validate required fields
    if not data.get('target_name'):
        return jsonify({'success': False, 'error': 'Target name is required'}), 400
    
    # Create job entry
    jobs[job_id] = {
        'id': job_id,
        'state': 'pending',
        'phase': 'Initializing',
        'progress': 0,
        'started': datetime.now().isoformat(),
        'data': data
    }
    
    # In Vercel, we can't run long background tasks
    # Instead, return job ID and let client poll or use webhooks
    # For production, integrate with a queue service like AWS SQS or Vercel Functions
    
    return jsonify({
        'success': True,
        'job_id': job_id,
        'message': f'Research job created for {data["target_name"]}',
        'note': 'This is a demo deployment. For full functionality, run locally or deploy with background job support.'
    })

@app.route('/api/status/<job_id>')
def get_status(job_id):
    """Get status of a research job"""
    if job_id not in jobs:
        return jsonify({'error': 'Job not found'}), 404
    
    return jsonify(jobs[job_id])

@app.route('/api/config')
def get_config():
    """Get system configuration"""
    return jsonify({
        'version': '7.0',
        'research_types': [
            {
                'id': 'individual',
                'name': 'Individual Intelligence',
                'description': 'Executive vetting, personal brand analysis'
            },
            {
                'id': 'organization',
                'name': 'Organizational Intelligence',
                'description': 'Company analysis, competitive intelligence'
            },
            {
                'id': 'market',
                'name': 'Market/GTM Intelligence',
                'description': 'Go-to-market strategy, audience intelligence'
            }
        ],
        'templates': ['corporate', 'tufte', 'sakura', 'classic'],
        'depth_options': ['quick', 'standard', 'deep'],
        'deployment': 'vercel'
    })

# Vercel requires the app to be exposed as 'app'
# for the Python runtime
if __name__ != '__main__':
    # Running on Vercel
    pass
else:
    # Local development
    print("🚀 MRP API Server starting on http://localhost:5000")
    app.run(host='0.0.0.0', port=5000, debug=True)