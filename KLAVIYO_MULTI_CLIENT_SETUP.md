# Klaviyo Multi-Client MCP Setup

## How to Add Multiple Klaviyo Accounts

You can add multiple Klaviyo MCP servers with different names for each client. Here's how:

### Option 1: Using Environment Variables (Recommended)

First, let's check how your current Klaviyo MCP handles API keys:

```bash
# Check the klaviyo-multi-client-server.js file
cat "/Users/skipmatheny/Library/Application Support/Claude/klaviyo-mcp/klaviyo-multi-client-server.js" | grep -i "api_key\|process.env" | head -10
```

Then add multiple instances:

```bash
# Client 1
claude mcp add -s user klaviyo-client1 node "/Users/skipmatheny/Library/Application Support/Claude/klaviyo-mcp/klaviyo-multi-client-server.js" \
  -e KLAVIYO_API_KEY=pk_client1_api_key_here \
  -e CLIENT_NAME=Client1

# Client 2  
claude mcp add -s user klaviyo-client2 node "/Users/skipmatheny/Library/Application Support/Claude/klaviyo-mcp/klaviyo-multi-client-server.js" \
  -e KLAVIYO_API_KEY=pk_client2_api_key_here \
  -e CLIENT_NAME=Client2

# Client 3
claude mcp add -s user klaviyo-acme node "/Users/skipmatheny/Library/Application Support/Claude/klaviyo-mcp/klaviyo-multi-client-server.js" \
  -e KLAVIYO_API_KEY=pk_acme_api_key_here \
  -e CLIENT_NAME=AcmeCorp
```

### Option 2: Create Separate Config Files

If the server reads from config files, you could create separate configs:

```bash
# Create config directory
mkdir -p ~/Documents/klaviyo-configs

# Create client-specific config files
echo '{"api_key": "pk_client1_key", "client": "Client1"}' > ~/Documents/klaviyo-configs/client1.json
echo '{"api_key": "pk_client2_key", "client": "Client2"}' > ~/Documents/klaviyo-configs/client2.json

# Then add with config paths
claude mcp add -s user klaviyo-client1 node "/Users/skipmatheny/Library/Application Support/Claude/klaviyo-mcp/klaviyo-multi-client-server.js" \
  -e CONFIG_PATH=~/Documents/klaviyo-configs/client1.json

claude mcp add -s user klaviyo-client2 node "/Users/skipmatheny/Library/Application Support/Claude/klaviyo-mcp/klaviyo-multi-client-server.js" \
  -e CONFIG_PATH=~/Documents/klaviyo-configs/client2.json
```

### Option 3: Using Different Server Scripts

You could also copy the server script for each client:

```bash
# Copy the server for each client
cp "/Users/skipmatheny/Library/Application Support/Claude/klaviyo-mcp/klaviyo-multi-client-server.js" \
   "/Users/skipmatheny/Library/Application Support/Claude/klaviyo-mcp/klaviyo-client1-server.js"

cp "/Users/skipmatheny/Library/Application Support/Claude/klaviyo-mcp/klaviyo-multi-client-server.js" \
   "/Users/skipmatheny/Library/Application Support/Claude/klaviyo-mcp/klaviyo-client2-server.js"

# Modify each copy to hardcode the API key (if needed)
# Then add each as a separate server
claude mcp add -s user klaviyo-client1 node "/Users/skipmatheny/Library/Application Support/Claude/klaviyo-mcp/klaviyo-client1-server.js"
claude mcp add -s user klaviyo-client2 node "/Users/skipmatheny/Library/Application Support/Claude/klaviyo-mcp/klaviyo-client2-server.js"
```

## Best Practices for Multi-Client Setup

### 1. Naming Convention
Use clear, identifiable names:
- `klaviyo-[client-name]`
- `klaviyo-[client-code]`
- `klaviyo-[industry]-[client]`

Examples:
- `klaviyo-acme`
- `klaviyo-retail-client1`
- `klaviyo-b2b-techcorp`

### 2. Environment Variables
Most MCP servers support environment variables. Common patterns:
- `KLAVIYO_API_KEY`
- `KLAVIYO_PRIVATE_KEY`
- `API_KEY`
- `CLIENT_ID`

### 3. Usage in Claude Code
Once added, you can reference each client specifically:
- `@klaviyo-client1` - Access Client 1's Klaviyo data
- `@klaviyo-client2` - Access Client 2's Klaviyo data
- `@klaviyo-acme` - Access Acme Corp's data

### 4. Managing Multiple Clients

List all Klaviyo instances:
```bash
claude mcp list | grep klaviyo
```

Remove a specific client:
```bash
claude mcp remove klaviyo-client1
```

Update a client (remove and re-add):
```bash
claude mcp remove klaviyo-client1
claude mcp add -s user klaviyo-client1 node "/path/to/server.js" -e KLAVIYO_API_KEY=new_key
```

## Example Multi-Client Workflow

```
You: @klaviyo-acme show me the performance of the last email campaign

You: @klaviyo-retail-client compare the open rates between @klaviyo-retail-client and @klaviyo-b2b-techcorp for Q4

You: @klaviyo-client1 export all subscribers who joined in the last 30 days
```

## Security Considerations

1. **API Key Storage**: Environment variables are stored in your Claude config
2. **Access Control**: Each MCP server runs in isolation
3. **Audit Trail**: Claude Code maintains logs of MCP usage
4. **Key Rotation**: Update keys by removing and re-adding servers

## Quick Start Commands

Here are the commands ready to use (just add your API keys):

```bash
# First, let's check your current setup
claude mcp list | grep klaviyo

# Remove the generic one if you want client-specific ones
claude mcp remove klaviyo

# Add your clients (replace with actual API keys)
claude mcp add -s user klaviyo-client1 node "/Users/skipmatheny/Library/Application Support/Claude/klaviyo-mcp/klaviyo-multi-client-server.js" -e KLAVIYO_API_KEY=pk_your_first_client_key

claude mcp add -s user klaviyo-client2 node "/Users/skipmatheny/Library/Application Support/Claude/klaviyo-mcp/klaviyo-multi-client-server.js" -e KLAVIYO_API_KEY=pk_your_second_client_key

claude mcp add -s user klaviyo-client3 node "/Users/skipmatheny/Library/Application Support/Claude/klaviyo-mcp/klaviyo-multi-client-server.js" -e KLAVIYO_API_KEY=pk_your_third_client_key
```

Would you like me to help you set up specific client instances?