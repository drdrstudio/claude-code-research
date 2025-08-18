#!/bin/bash

# Test version of reputational scan
echo "Individual Reputational Scan Recipe v4.0"
echo "========================================="

TARGET_NAME="$1"

if [ -z "$TARGET_NAME" ]; then
    echo "Error: No target name provided"
    echo "Usage: $0 \"Person Name\" [options]"
    exit 1
fi

echo "Target: $TARGET_NAME"
echo "Quality Gates: ON (default)"

# Create test project directory
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
PROJECT_NAME="Research_ReputationalScan_TestUser_${TIMESTAMP}"
PROJECT_DIR="03_PROJECTS/ReputationalScans/${PROJECT_NAME}"

echo "Creating project at: $PROJECT_DIR"
mkdir -p "${PROJECT_DIR}"/{01_planning,02_raw_intelligence,03_verified_sources,04_network_analysis,05_synthesis,06_output}

echo "✓ Project structure created"

# Create simple config
cat > "${PROJECT_DIR}/PROJECT_CONFIG.json" << EOF
{
  "project_id": "${PROJECT_NAME}",
  "target": "${TARGET_NAME}",
  "quality_gates": true,
  "created_at": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
}
EOF

echo "✓ Configuration saved"
echo ""
echo "Project ready at: ${PROJECT_DIR}"