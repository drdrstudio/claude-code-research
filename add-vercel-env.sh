#!/bin/bash

# Add all environment variables to Vercel
echo "Adding environment variables to Vercel..."

# Read from .env file and add to Vercel
vercel env add PERPLEXITY_API_KEY production < <(echo "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")
vercel env add FIRECRAWL_API_KEY production < <(echo "fc-99ce2e081f9644c4aa9a669d86073f73")
vercel env add TAVILY_API_KEY production < <(echo "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")
vercel env add DATAFORSEO_LOGIN production < <(echo "accounts@waterloo.digital")
vercel env add DATAFORSEO_PASSWORD production < <(echo "ca55f5e604bc59b0")
vercel env add REDDIT_CLIENT_ID production < <(echo "D4jHShqeKpzpSR-OhB-oww")
vercel env add REDDIT_CLIENT_SECRET production < <(echo "n2AjAKBzIYw3otpP7INatjGe-WZFHQ")
vercel env add GEMINI_API_KEY production < <(echo "AIzaSyC-TfhncQKXf8lkIzRCQBchVW6oSjD5wyA")

echo "All environment variables added!"