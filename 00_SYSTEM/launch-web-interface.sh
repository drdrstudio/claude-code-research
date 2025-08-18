#!/bin/bash

# MRP v7.0 Web Interface Launcher
# One-click start for the research system

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'
BOLD='\033[1m'

SYSTEM_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${CYAN}${BOLD}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}${BOLD}║         MRP INTELLIGENCE SYSTEM v7.0                        ║${NC}"
echo -e "${CYAN}${BOLD}║         Starting Web Interface...                           ║${NC}"
echo -e "${CYAN}${BOLD}╚══════════════════════════════════════════════════════════════╝${NC}"

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo -e "${YELLOW}⚠️  Python3 not found. Installing dependencies...${NC}"
    
    # Check OS and install Python
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        if command -v brew &> /dev/null; then
            brew install python3
        else
            echo "Please install Homebrew first: https://brew.sh"
            exit 1
        fi
    else
        echo "Please install Python 3 manually"
        exit 1
    fi
fi

# Install required Python packages if needed
echo -e "\n${BLUE}Checking Python dependencies...${NC}"
pip3 install flask requests python-dotenv --quiet 2>/dev/null || true

# Check if backend API exists
if [ ! -f "$SYSTEM_DIR/api/web-server.py" ]; then
    echo -e "${YELLOW}Creating backend API server...${NC}"
    
    # Create a simple backend API
    cat > "$SYSTEM_DIR/api/web-server.py" << 'EOF'
#!/usr/bin/env python3
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

# Store job status
jobs = {}

@app.route('/')
def index():
    """Serve the main web interface"""
    return send_from_directory('../web-interface', 'index.html')

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
    
    # Start research in background thread
    thread = threading.Thread(target=run_research, args=(job_id, data))
    thread.start()
    
    return jsonify({
        'success': True,
        'job_id': job_id,
        'message': f'Research started for {data["target_name"]}'
    })

@app.route('/api/status/<job_id>')
def get_status(job_id):
    """Get status of a research job"""
    if job_id not in jobs:
        return jsonify({'error': 'Job not found'}), 404
    
    return jsonify(jobs[job_id])

def run_research(job_id, data):
    """Execute the research in background"""
    try:
        # Update status
        jobs[job_id]['state'] = 'running'
        jobs[job_id]['phase'] = 'Starting research'
        jobs[job_id]['progress'] = 10
        
        # Determine which dispatcher to use
        research_type = data.get('research_type', 'individual')
        target_name = data.get('target_name', 'Unknown')
        
        # Map research type to dispatcher
        dispatcher_map = {
            'individual': 'recipes/reputational/dispatcher.sh',
            'organization': 'recipes/organizational/dispatcher.sh',
            'market': 'recipes/gtm/dispatcher.sh'
        }
        
        dispatcher = dispatcher_map.get(research_type)
        dispatcher_path = os.path.join(os.path.dirname(__file__), '..', dispatcher)
        
        if not os.path.exists(dispatcher_path):
            raise Exception(f"Dispatcher not found: {dispatcher}")
        
        # Create project folder
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        project_name = f"Research_{research_type.title()}_{target_name.replace(' ', '')}_{timestamp}"
        project_path = os.path.join(os.path.dirname(__file__), '../../03_PROJECTS', project_name)
        
        # Update progress
        jobs[job_id]['phase'] = 'Running intelligence gathering'
        jobs[job_id]['progress'] = 30
        jobs[job_id]['project_path'] = project_path
        
        # Execute the dispatcher
        result = subprocess.run(
            [dispatcher_path, project_path, target_name],
            capture_output=True,
            text=True,
            timeout=14400  # 4 hour timeout
        )
        
        if result.returncode == 0:
            jobs[job_id]['state'] = 'completed'
            jobs[job_id]['phase'] = 'Research complete'
            jobs[job_id]['progress'] = 100
            jobs[job_id]['message'] = f'Research completed successfully. Files saved to {project_name}'
        else:
            raise Exception(f"Research failed: {result.stderr}")
            
    except Exception as e:
        jobs[job_id]['state'] = 'failed'
        jobs[job_id]['error'] = str(e)
        jobs[job_id]['progress'] = 0

if __name__ == '__main__':
    print("🚀 MRP Web Server starting on http://localhost:5000")
    print("📊 Access the interface at: http://localhost:5000")
    print("Press Ctrl+C to stop the server")
    app.run(host='0.0.0.0', port=5000, debug=False)
EOF
fi

# Make sure Flask CORS is installed
pip3 install flask-cors --quiet 2>/dev/null || true

# Kill any existing server on port 5000
echo -e "\n${BLUE}Checking for existing servers...${NC}"
lsof -ti:5000 | xargs kill -9 2>/dev/null || true

# Start the backend server
echo -e "\n${GREEN}Starting backend API server...${NC}"
cd "$SYSTEM_DIR"
python3 api/web-server.py &
SERVER_PID=$!

# Wait for server to start
sleep 3

# Open the web interface
echo -e "\n${GREEN}Opening web interface...${NC}"
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    open "http://localhost:5000"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    xdg-open "http://localhost:5000"
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
    # Windows
    start "http://localhost:5000"
fi

echo -e "\n${CYAN}${BOLD}╔══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}${BOLD}║                  SYSTEM READY                               ║${NC}"
echo -e "${CYAN}${BOLD}╚══════════════════════════════════════════════════════════════╝${NC}"
echo -e "\n${GREEN}✅ Web interface is running at: ${BOLD}http://localhost:5000${NC}"
echo -e "${YELLOW}📝 To stop the server, press Ctrl+C${NC}\n"

# Keep the script running and handle shutdown
trap "echo -e '\n${YELLOW}Shutting down server...${NC}'; kill $SERVER_PID 2>/dev/null; exit" INT TERM

# Wait for the server process
wait $SERVER_PID