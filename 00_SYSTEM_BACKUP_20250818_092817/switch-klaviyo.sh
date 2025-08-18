#!/bin/bash

# Klaviyo Account Switcher for Claude Code

case "$1" in
  "waterloo")
    claude mcp remove klaviyo 2>/dev/null
    claude mcp add -s user klaviyo uvx klaviyo-mcp-server@latest \
      -e PRIVATE_API_KEY=pk_waterloo_key_here
    echo "✅ Switched to Waterloo Klaviyo"
    ;;
  "acme")
    claude mcp remove klaviyo 2>/dev/null
    claude mcp add -s user klaviyo uvx klaviyo-mcp-server@latest \
      -e PRIVATE_API_KEY=pk_acme_key_here
    echo "✅ Switched to Acme Klaviyo"
    ;;
  "retail")
    claude mcp remove klaviyo 2>/dev/null
    claude mcp add -s user klaviyo uvx klaviyo-mcp-server@latest \
      -e PRIVATE_API_KEY=pk_retail_key_here
    echo "✅ Switched to Retail Klaviyo"
    ;;
  *)
    echo "Usage: ./switch-klaviyo.sh [waterloo|acme|retail]"
    echo "Current setup:"
    claude mcp list | grep klaviyo
    ;;
esac