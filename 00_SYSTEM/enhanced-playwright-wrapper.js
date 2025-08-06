#!/usr/bin/env node

/**
 * Enhanced Playwright Wrapper with Anti-Detection Capabilities
 * Integrates with Claude Code Research MRP v6.0
 * 
 * Features:
 * - Random timing delays
 * - Browser fingerprint randomization
 * - Behavioral simulation
 * - Webshare proxy integration
 * - Session management
 */

const { chromium } = require('playwright');
const fs = require('fs');
const path = require('path');

class EnhancedBrowserSession {
    constructor(options = {}) {
        this.options = {
            minDelay: parseInt(process.env.SCRAPING_MIN_DELAY) || 3,
            maxDelay: parseInt(process.env.SCRAPING_MAX_DELAY) || 8,
            sessionWarmup: process.env.SCRAPING_SESSION_WARMUP === 'true',
            behavioralSim: process.env.SCRAPING_BEHAVIORAL_SIM === 'true',
            proxyRotation: process.env.PROXY_ROTATION_FREQUENCY || 25,
            webshareApiKey: process.env.WEBSHARE_API_KEY,
            ...options
        };
        this.requestCount = 0;
        this.sessionStart = Date.now();
        this.browser = null;
        this.context = null;
        this.page = null;
    }

    // Get random delay between min and max seconds
    getRandomDelay() {
        const delay = Math.floor(Math.random() * (this.options.maxDelay - this.options.minDelay + 1)) + this.options.minDelay;
        return delay * 1000; // Convert to milliseconds
    }

    // Get random user agent with matching viewport
    getRandomUserAgent() {
        const agents = [
            {
                userAgent: 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
                viewport: { width: 1440, height: 900 },
                platform: 'MacIntel'
            },
            {
                userAgent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
                viewport: { width: 1920, height: 1080 },
                platform: 'Win32'
            },
            {
                userAgent: 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.1 Safari/605.1.15',
                viewport: { width: 1440, height: 900 },
                platform: 'MacIntel'
            }
        ];
        return agents[Math.floor(Math.random() * agents.length)];
    }

    // Initialize browser with anti-detection settings
    async initBrowser() {
        const randomAgent = this.getRandomUserAgent();
        
        const browserOptions = {
            headless: true,
            args: [
                '--no-sandbox',
                '--disable-setuid-sandbox',
                '--disable-dev-shm-usage',
                '--disable-accelerated-2d-canvas',
                '--no-first-run',
                '--no-zygote',
                '--single-process',
                '--disable-gpu',
                '--disable-background-timer-throttling',
                '--disable-backgrounding-occluded-windows',
                '--disable-renderer-backgrounding',
                '--disable-web-security',
                '--disable-blink-features=AutomationControlled',
                `--user-agent=${randomAgent.userAgent}`
            ]
        };

        // Add proxy if webshare is configured
        if (this.options.webshareApiKey) {
            // Note: In production, you'd fetch a proxy from webshare API here
            console.log('🌐 Webshare proxy integration ready');
        }

        this.browser = await chromium.launch(browserOptions);
        
        this.context = await this.browser.newContext({
            userAgent: randomAgent.userAgent,
            viewport: randomAgent.viewport,
            locale: 'en-US',
            timezoneId: 'America/New_York',
            permissions: [],
            extraHTTPHeaders: {
                'Accept-Language': 'en-US,en;q=0.9',
                'Accept-Encoding': 'gzip, deflate, br',
                'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
                'Connection': 'keep-alive',
                'Upgrade-Insecure-Requests': '1'
            }
        });

        // Override navigator.webdriver
        await this.context.addInitScript(() => {
            Object.defineProperty(navigator, 'webdriver', {
                get: () => undefined,
            });
            
            // Override permissions API
            const originalQuery = window.navigator.permissions.query;
            window.navigator.permissions.query = (parameters) => (
                parameters.name === 'notifications' ?
                    Promise.resolve({ state: Notification.permission }) :
                    originalQuery(parameters)
            );
        });

        this.page = await this.context.newPage();
        
        console.log(`🎭 Browser initialized with ${randomAgent.userAgent.includes('Chrome') ? 'Chrome' : randomAgent.userAgent.includes('Safari') ? 'Safari' : 'Firefox'} profile`);
    }

    // Navigate with behavioral simulation
    async navigateWithBehavior(url) {
        if (!this.page) await this.initBrowser();

        console.log(`🌐 Navigating to: ${url}`);
        
        // Pre-navigation delay
        await this.delay(this.getRandomDelay());
        
        await this.page.goto(url, { 
            waitUntil: 'networkidle',
            timeout: parseInt(process.env.SCRAPING_PAGE_LOAD_TIMEOUT) || 30000
        });

        // Post-navigation behavioral simulation
        if (this.options.behavioralSim) {
            await this.simulateHumanBehavior();
        }

        this.requestCount++;
        
        // Check if we need proxy rotation
        if (this.requestCount % this.options.proxyRotation === 0) {
            console.log('🔄 Proxy rotation checkpoint reached');
        }

        return this.page;
    }

    // Simulate human-like behavior
    async simulateHumanBehavior() {
        const actions = [
            () => this.page.mouse.move(Math.random() * 800, Math.random() * 600),
            () => this.page.evaluate(() => window.scrollBy(0, Math.random() * 500)),
            () => this.delay(1000 + Math.random() * 2000)
        ];

        // Perform 1-3 random actions
        const numActions = Math.floor(Math.random() * 3) + 1;
        for (let i = 0; i < numActions; i++) {
            const action = actions[Math.floor(Math.random() * actions.length)];
            await action();
            await this.delay(500 + Math.random() * 1000);
        }
    }

    // Smart delay with jitter
    async delay(ms) {
        const jitter = Math.random() * 1000; // Add up to 1 second of jitter
        const totalDelay = ms + jitter;
        await new Promise(resolve => setTimeout(resolve, totalDelay));
    }

    // Enhanced screenshot with metadata
    async screenshot(options = {}) {
        const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
        const filename = options.filename || `screenshot-${timestamp}.png`;
        const fullPath = path.join(process.cwd(), 'screenshots', filename);
        
        // Ensure screenshots directory exists
        const screenshotDir = path.dirname(fullPath);
        if (!fs.existsSync(screenshotDir)) {
            fs.mkdirSync(screenshotDir, { recursive: true });
        }

        await this.page.screenshot({
            path: fullPath,
            fullPage: options.fullPage || false,
            ...options
        });

        console.log(`📸 Screenshot saved: ${fullPath}`);
        return fullPath;
    }

    // Get page content with metadata
    async getContent() {
        const content = await this.page.content();
        const title = await this.page.title();
        const url = this.page.url();
        
        return {
            content,
            title,
            url,
            timestamp: new Date().toISOString(),
            requestCount: this.requestCount,
            sessionDuration: Date.now() - this.sessionStart
        };
    }

    // Session cleanup
    async close() {
        if (this.browser) {
            await this.browser.close();
            console.log(`🔚 Session ended. Total requests: ${this.requestCount}`);
        }
    }

    // Session health check
    getSessionHealth() {
        const duration = Date.now() - this.sessionStart;
        const maxDuration = parseInt(process.env.SCRAPING_SESSION_DURATION) * 1000 || 1800000; // 30 minutes
        const maxRequests = parseInt(process.env.SCRAPING_REQUESTS_PER_SESSION) || 50;

        return {
            healthy: duration < maxDuration && this.requestCount < maxRequests,
            duration,
            maxDuration,
            requestCount: this.requestCount,
            maxRequests,
            remainingRequests: Math.max(0, maxRequests - this.requestCount),
            remainingTime: Math.max(0, maxDuration - duration)
        };
    }
}

// CLI interface
if (require.main === module) {
    const args = process.argv.slice(2);
    const url = args[0];
    
    if (!url) {
        console.log('Usage: node enhanced-playwright-wrapper.js <url>');
        console.log('Example: node enhanced-playwright-wrapper.js https://example.com');
        process.exit(1);
    }

    (async () => {
        const session = new EnhancedBrowserSession();
        
        try {
            await session.navigateWithBehavior(url);
            const content = await session.getContent();
            const health = session.getSessionHealth();
            
            console.log(`📊 Session Health:`, health);
            console.log(`📝 Page Title: ${content.title}`);
            console.log(`📏 Content Length: ${content.content.length} characters`);
            
            await session.screenshot({ filename: `capture-${Date.now()}.png` });
            
        } catch (error) {
            console.error('❌ Error:', error.message);
        } finally {
            await session.close();
        }
    })();
}

module.exports = { EnhancedBrowserSession };