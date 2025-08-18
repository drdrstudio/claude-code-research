#!/bin/bash

# Enhanced Scraping Configuration for Claude Code Research
# Implements timing controls, behavioral simulation, and session management

echo "🔧 Setting up Enhanced Anti-Detection Scraping Configuration..."

# Create enhanced environment variables for timing and behavior
export SCRAPING_MIN_DELAY=3
export SCRAPING_MAX_DELAY=8  
export SCRAPING_SESSION_WARMUP=true
export SCRAPING_ROTATE_USER_AGENTS=true
export SCRAPING_BEHAVIORAL_SIM=true

# Set up user agent rotation
export USER_AGENTS=(
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.1 Safari/605.1.15"
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:121.0) Gecko/20100101 Firefox/121.0"
    "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
)

# Browser timing settings
export SCRAPING_PAGE_LOAD_TIMEOUT=30000
export SCRAPING_SCROLL_DELAY=2000
export SCRAPING_CLICK_DELAY=1500

# Session management
export SCRAPING_SESSION_DURATION=1800  # 30 minutes
export SCRAPING_REQUESTS_PER_SESSION=50
export SCRAPING_COOLDOWN_PERIOD=300    # 5 minutes

# Proxy rotation settings (works with existing webshare setup)
export PROXY_ROTATION_FREQUENCY=25     # Change proxy every 25 requests
export PROXY_GEOGRAPHIC_DIVERSITY=true

echo "✅ Enhanced scraping configuration loaded"
echo "📊 Current settings:"
echo "  - Request delays: ${SCRAPING_MIN_DELAY}-${SCRAPING_MAX_DELAY} seconds"
echo "  - Session warmup: ${SCRAPING_SESSION_WARMUP}"
echo "  - User agent rotation: ${SCRAPING_ROTATE_USER_AGENTS}"
echo "  - Proxy rotation: Every ${PROXY_ROTATION_FREQUENCY} requests"
echo "  - Behavioral simulation: ${SCRAPING_BEHAVIORAL_SIM}"

# Function to get random delay
get_random_delay() {
    local min_delay=${SCRAPING_MIN_DELAY:-3}
    local max_delay=${SCRAPING_MAX_DELAY:-8}
    echo $(( RANDOM % (max_delay - min_delay + 1) + min_delay ))
}

# Function to get random user agent
get_random_user_agent() {
    local agents=(
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.1 Safari/605.1.15"
    )
    local random_index=$(( RANDOM % ${#agents[@]} ))
    echo "${agents[$random_index]}"
}

echo "🚀 Enhanced scraping functions available: get_random_delay, get_random_user_agent"