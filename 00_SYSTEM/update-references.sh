#!/bin/bash
# Update all script references to new structure

echo "Updating script references to v7.0 structure..."

# Update mrp-launcher.sh references
if [ -f "core/mrp-launcher.sh" ]; then
    sed -i.bak 's|reputational-scan-dispatcher\.sh|recipes/reputational/dispatcher.sh|g' core/mrp-launcher.sh
    sed -i.bak 's|organizational-scan-dispatcher\.sh|recipes/organizational/dispatcher.sh|g' core/mrp-launcher.sh
    sed -i.bak 's|gtm-marketing-dispatcher\.sh|recipes/gtm/dispatcher.sh|g' core/mrp-launcher.sh
fi

# Update API references
if [ -f "api/web-server.py" ]; then
    sed -i.bak "s|from research_pdf_api|from backend_api|g" api/web-server.py
fi

echo "✓ References updated"
