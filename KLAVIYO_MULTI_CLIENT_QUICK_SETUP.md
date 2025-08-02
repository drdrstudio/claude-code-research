# Klaviyo Multi-Client Quick Setup

Your Klaviyo MCP server already supports multiple clients! Here are 3 ways to set it up:

## Method 1: Single Server, Multiple Keys (RECOMMENDED)

Add one Klaviyo server that can access ALL your clients:

```bash
# Remove existing if needed
claude mcp remove klaviyo

# Add with multiple API keys using comma-separated format
claude mcp add -s user klaviyo node "/Users/skipmatheny/Library/Application Support/Claude/klaviyo-mcp/klaviyo-multi-client-server.js" \
  -e KLAVIYO_API_KEYS="client1:pk_client1_key_here,client2:pk_client2_key_here,acme:pk_acme_key_here"
```

## Method 2: Single Server with Named Keys

```bash
claude mcp add -s user klaviyo node "/Users/skipmatheny/Library/Application Support/Claude/klaviyo-mcp/klaviyo-multi-client-server.js" \
  -e KLAVIYO_API_KEY_ACME="pk_acme_key_here" \
  -e KLAVIYO_API_KEY_RETAILCO="pk_retailco_key_here" \
  -e KLAVIYO_API_KEY_TECHSTARTUP="pk_techstartup_key_here"
```

## Method 3: Single Server with Numbered Keys

```bash
claude mcp add -s user klaviyo node "/Users/skipmatheny/Library/Application Support/Claude/klaviyo-mcp/klaviyo-multi-client-server.js" \
  -e KLAVIYO_API_KEY_1="pk_first_client_key" \
  -e KLAVIYO_CLIENT_NAME_1="AcmeCorp" \
  -e KLAVIYO_API_KEY_2="pk_second_client_key" \
  -e KLAVIYO_CLIENT_NAME_2="RetailBrand" \
  -e KLAVIYO_API_KEY_3="pk_third_client_key" \
  -e KLAVIYO_CLIENT_NAME_3="TechStartup"
```

## How to Use in Claude Code

Once set up with any method above, the server will let you choose which client to work with:

```
@klaviyo "List all campaigns for client: acme"
@klaviyo "Show metrics for RetailBrand's last email"
@klaviyo "Compare open rates across all clients"
```

The server should provide a client selector or accept client names in your queries.

## Complete Example Setup

Here's a full example with 3 clients:

```bash
# Remove existing
claude mcp remove klaviyo

# Add with all your clients (replace with your actual API keys)
claude mcp add -s user klaviyo node "/Users/skipmatheny/Library/Application Support/Claude/klaviyo-mcp/klaviyo-multi-client-server.js" \
  -e KLAVIYO_API_KEYS="waterloo:pk_waterloo_key,clientA:pk_clientA_key,clientB:pk_clientB_key"

# Verify it's added
claude mcp list | grep klaviyo
```

## Alternative: Separate Instances

If you prefer completely separate instances:

```bash
# Client 1: Waterloo
claude mcp add -s user klaviyo-waterloo node "/Users/skipmatheny/Library/Application Support/Claude/klaviyo-mcp/klaviyo-multi-client-server.js" \
  -e KLAVIYO_API_KEY="pk_waterloo_key" \
  -e KLAVIYO_CLIENT_NAME="Waterloo"

# Client 2: Acme Corp
claude mcp add -s user klaviyo-acme node "/Users/skipmatheny/Library/Application Support/Claude/klaviyo-mcp/klaviyo-multi-client-server.js" \
  -e KLAVIYO_API_KEY="pk_acme_key" \
  -e KLAVIYO_CLIENT_NAME="AcmeCorp"

# Client 3: Retail Brand
claude mcp add -s user klaviyo-retail node "/Users/skipmatheny/Library/Application Support/Claude/klaviyo-mcp/klaviyo-multi-client-server.js" \
  -e KLAVIYO_API_KEY="pk_retail_key" \
  -e KLAVIYO_CLIENT_NAME="RetailBrand"
```

Then use them separately:
- `@klaviyo-waterloo "show recent campaigns"`
- `@klaviyo-acme "list all segments"`
- `@klaviyo-retail "export subscriber growth"`

Which method would you prefer? I can help you set it up with your actual client names!