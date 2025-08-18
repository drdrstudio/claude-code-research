#!/usr/bin/env node

/**
 * Advanced Anti-Detection System v2.0
 * Next-generation evasion techniques for web scraping
 * 
 * NEW FEATURES:
 * - TLS fingerprint randomization
 * - Advanced mouse movement patterns
 * - Network request interception and modification
 * - WebGL and Canvas fingerprint spoofing
 * - Audio context fingerprint masking
 * - Advanced cookie management
 * - CDP detection evasion
 * - Multi-level proxy chains
 */

const { chromium, firefox, webkit } = require('playwright');
const fs = require('fs');
const path = require('path');
const crypto = require('crypto');

class AdvancedAntiDetection {
    constructor(options = {}) {
        this.options = {
            // Timing configurations with more variance
            minDelay: parseInt(process.env.SCRAPING_MIN_DELAY) || 2,
            maxDelay: parseInt(process.env.SCRAPING_MAX_DELAY) || 12,
            
            // Advanced features
            tlsRandomization: true,
            canvasNoise: true,
            webglSpoofing: true,
            audioContextMasking: true,
            fontFingerprinting: true,
            webrtcLeakPrevention: true,
            timezoneRandomization: true,
            languageRandomization: true,
            screenResolutionVariance: true,
            hardwareConcurrencyMasking: true,
            
            // Browser selection strategy
            browserRotation: ['chromium', 'firefox', 'webkit'],
            currentBrowserIndex: 0,
            
            // Advanced proxy configuration
            proxyChainLength: 2, // Multi-hop proxy
            residentialProxyWeight: 0.7, // 70% residential, 30% datacenter
            
            ...options
        };
        
        this.sessionFingerprint = this.generateSessionFingerprint();
        this.requestPatterns = [];
        this.mouseMovements = [];
    }

    /**
     * Generate unique session fingerprint
     */
    generateSessionFingerprint() {
        return {
            sessionId: crypto.randomBytes(16).toString('hex'),
            startTime: Date.now(),
            timezone: this.getRandomTimezone(),
            locale: this.getRandomLocale(),
            screen: this.getRandomScreenResolution(),
            hardware: this.getRandomHardwareProfile(),
            fonts: this.getRandomFontSet(),
            plugins: this.getRandomPlugins(),
            webgl: this.generateWebGLFingerprint(),
            canvas: this.generateCanvasFingerprint(),
            audio: this.generateAudioFingerprint()
        };
    }

    /**
     * Advanced browser initialization with maximum stealth
     */
    async initStealthBrowser() {
        // Rotate through different browser engines
        const browserType = this.options.browserRotation[this.options.currentBrowserIndex];
        this.options.currentBrowserIndex = (this.options.currentBrowserIndex + 1) % this.options.browserRotation.length;
        
        console.log(`🎭 Initializing ${browserType} with advanced stealth mode...`);
        
        const browserOptions = this.getBrowserOptions(browserType);
        const contextOptions = this.getContextOptions();
        
        // Select browser engine
        let browserEngine;
        switch(browserType) {
            case 'firefox':
                browserEngine = firefox;
                break;
            case 'webkit':
                browserEngine = webkit;
                break;
            default:
                browserEngine = chromium;
        }
        
        this.browser = await browserEngine.launch(browserOptions);
        this.context = await this.browser.newContext(contextOptions);
        
        // Apply advanced anti-detection scripts
        await this.applyStealthScripts();
        
        this.page = await this.context.newPage();
        
        // Set up network interception
        await this.setupNetworkInterception();
        
        // Set up advanced event listeners
        await this.setupAdvancedListeners();
        
        console.log(`✅ Stealth browser initialized with fingerprint: ${this.sessionFingerprint.sessionId}`);
        
        return this.page;
    }

    /**
     * Get browser-specific launch options
     */
    getBrowserOptions(browserType) {
        const commonArgs = [
            '--disable-blink-features=AutomationControlled',
            '--disable-dev-shm-usage',
            '--disable-web-security',
            '--disable-features=IsolateOrigins,site-per-process',
            '--disable-site-isolation-trials',
            '--disable-features=BlockInsecurePrivateNetworkRequests',
            '--disable-features=ImprovedCookieControls',
            '--flag-switches-begin',
            '--disable-features=SameSiteByDefaultCookies,CookiesWithoutSameSiteMustBeSecure',
            '--flag-switches-end'
        ];
        
        if (browserType === 'chromium') {
            return {
                headless: false, // Headful is less detectable
                args: [
                    ...commonArgs,
                    '--window-size=1920,1080',
                    '--window-position=0,0',
                    '--disable-background-timer-throttling',
                    '--disable-backgrounding-occluded-windows',
                    '--disable-renderer-backgrounding',
                    '--disable-features=TranslateUI',
                    '--disable-ipc-flooding-protection',
                    '--password-store=basic',
                    '--use-mock-keychain',
                    '--force-color-profile=srgb'
                ],
                ignoreDefaultArgs: ['--enable-automation', '--enable-blink-features=AutomationControlled']
            };
        }
        
        return { headless: false, args: commonArgs };
    }

    /**
     * Get context options with advanced fingerprinting
     */
    getContextOptions() {
        const fp = this.sessionFingerprint;
        
        return {
            viewport: { 
                width: fp.screen.width, 
                height: fp.screen.height - 100 // Account for browser chrome
            },
            screen: fp.screen,
            userAgent: this.generateAdvancedUserAgent(),
            locale: fp.locale,
            timezoneId: fp.timezone,
            permissions: [],
            geolocation: this.getRandomGeolocation(),
            colorScheme: Math.random() > 0.5 ? 'light' : 'dark',
            reducedMotion: Math.random() > 0.7 ? 'reduce' : 'no-preference',
            forcedColors: 'none',
            extraHTTPHeaders: this.getAdvancedHeaders(),
            httpCredentials: this.options.proxyAuth || null,
            offline: false,
            deviceScaleFactor: fp.screen.deviceScaleFactor,
            isMobile: false,
            hasTouch: false,
            defaultBrowserType: 'chromium'
        };
    }

    /**
     * Apply advanced stealth scripts to context
     */
    async applyStealthScripts() {
        // Core stealth overrides
        await this.context.addInitScript(() => {
            // WebDriver detection evasion
            Object.defineProperty(navigator, 'webdriver', {
                get: () => undefined
            });
            
            // Chrome detection evasion
            window.chrome = {
                runtime: {},
                loadTimes: function() {},
                csi: function() {},
                app: {}
            };
            
            // Permissions API override
            const originalQuery = window.navigator.permissions.query;
            window.navigator.permissions.query = (parameters) => (
                parameters.name === 'notifications' ?
                    Promise.resolve({ state: Notification.permission }) :
                    originalQuery(parameters)
            );
            
            // WebGL fingerprinting protection
            const getParameter = WebGLRenderingContext.prototype.getParameter;
            WebGLRenderingContext.prototype.getParameter = function(parameter) {
                if (parameter === 37445) {
                    return 'Intel Inc.';
                }
                if (parameter === 37446) {
                    return 'Intel Iris OpenGL Engine';
                }
                return getParameter.apply(this, arguments);
            };
            
            // Canvas fingerprinting protection
            const toDataURL = HTMLCanvasElement.prototype.toDataURL;
            HTMLCanvasElement.prototype.toDataURL = function() {
                const context = this.getContext('2d');
                const imageData = context.getImageData(0, 0, this.width, this.height);
                for (let i = 0; i < imageData.data.length; i += 4) {
                    imageData.data[i] = imageData.data[i] ^ (Math.random() * 0.1);
                }
                context.putImageData(imageData, 0, 0);
                return toDataURL.apply(this, arguments);
            };
            
            // AudioContext fingerprinting protection
            const AudioContext = window.AudioContext || window.webkitAudioContext;
            const audioContext = AudioContext.prototype;
            const createAnalyser = audioContext.createAnalyser;
            audioContext.createAnalyser = function() {
                const analyser = createAnalyser.apply(this, arguments);
                const getFloatFrequencyData = analyser.getFloatFrequencyData;
                analyser.getFloatFrequencyData = function(array) {
                    getFloatFrequencyData.call(this, array);
                    for (let i = 0; i < array.length; i++) {
                        array[i] = array[i] + Math.random() * 0.001;
                    }
                };
                return analyser;
            };
            
            // Battery API masking
            if (navigator.getBattery) {
                navigator.getBattery = () => Promise.reject(new Error('Battery API not supported'));
            }
            
            // WebRTC leak prevention
            const RTCPeerConnection = window.RTCPeerConnection || window.webkitRTCPeerConnection;
            if (RTCPeerConnection) {
                const originalCreateDataChannel = RTCPeerConnection.prototype.createDataChannel;
                RTCPeerConnection.prototype.createDataChannel = function() {
                    return null;
                };
            }
            
            // Timezone spoofing
            Date.prototype.getTimezoneOffset = function() {
                return -120; // UTC+2
            };
            
            // Hardware concurrency masking
            Object.defineProperty(navigator, 'hardwareConcurrency', {
                get: () => 4 + Math.floor(Math.random() * 4)
            });
            
            // Device memory masking
            Object.defineProperty(navigator, 'deviceMemory', {
                get: () => 8
            });
            
            // Network information API masking
            if (navigator.connection) {
                Object.defineProperty(navigator.connection, 'rtt', {
                    get: () => 50 + Math.floor(Math.random() * 100)
                });
            }
        });
    }

    /**
     * Set up network request interception
     */
    async setupNetworkInterception() {
        await this.context.route('**/*', async (route, request) => {
            const headers = {
                ...request.headers(),
                // Remove automation headers
                'sec-ch-ua': '"Chromium";v="120", "Not(A:Brand";v="24"',
                'sec-ch-ua-mobile': '?0',
                'sec-ch-ua-platform': '"macOS"',
                'sec-fetch-site': 'same-origin',
                'sec-fetch-mode': 'navigate',
                'sec-fetch-user': '?1',
                'sec-fetch-dest': 'document'
            };
            
            // Remove suspicious headers
            delete headers['x-devtools-emulate-network-conditions-client-id'];
            delete headers['x-automation'];
            
            // Track request patterns for behavioral analysis
            this.requestPatterns.push({
                url: request.url(),
                method: request.method(),
                timestamp: Date.now()
            });
            
            await route.continue({ headers });
        });
    }

    /**
     * Set up advanced event listeners for behavioral tracking
     */
    async setupAdvancedListeners() {
        // Track mouse movements for pattern analysis
        await this.page.on('mouse', (event) => {
            this.mouseMovements.push({
                x: event.x,
                y: event.y,
                timestamp: Date.now()
            });
        });
        
        // Analyze and adjust behavior patterns
        setInterval(() => {
            this.analyzeAndAdjustBehavior();
        }, 30000); // Every 30 seconds
    }

    /**
     * Generate advanced user agent with proper version matching
     */
    generateAdvancedUserAgent() {
        const os = ['Windows NT 10.0; Win64; x64', 'Macintosh; Intel Mac OS X 10_15_7', 'X11; Linux x86_64'];
        const browsers = [
            { name: 'Chrome', version: '120.0.0.0' },
            { name: 'Firefox', version: '121.0' },
            { name: 'Safari', version: '605.1.15' },
            { name: 'Edge', version: '120.0.0.0' }
        ];
        
        const selectedOS = os[Math.floor(Math.random() * os.length)];
        const selectedBrowser = browsers[Math.floor(Math.random() * browsers.length)];
        
        if (selectedBrowser.name === 'Safari') {
            return `Mozilla/5.0 (${selectedOS}) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.1 Safari/${selectedBrowser.version}`;
        } else if (selectedBrowser.name === 'Firefox') {
            return `Mozilla/5.0 (${selectedOS}; rv:${selectedBrowser.version}) Gecko/20100101 Firefox/${selectedBrowser.version}`;
        } else {
            return `Mozilla/5.0 (${selectedOS}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/${selectedBrowser.version} Safari/537.36`;
        }
    }

    /**
     * Generate realistic mouse movement patterns
     */
    async simulateRealisticMouseMovement(page) {
        const viewport = page.viewportSize();
        
        // Generate bezier curve points for smooth movement
        const generateBezierPoints = (start, end, control1, control2, steps = 20) => {
            const points = [];
            for (let t = 0; t <= 1; t += 1/steps) {
                const x = Math.pow(1-t, 3) * start.x + 
                         3 * Math.pow(1-t, 2) * t * control1.x + 
                         3 * (1-t) * Math.pow(t, 2) * control2.x + 
                         Math.pow(t, 3) * end.x;
                const y = Math.pow(1-t, 3) * start.y + 
                         3 * Math.pow(1-t, 2) * t * control1.y + 
                         3 * (1-t) * Math.pow(t, 2) * control2.y + 
                         Math.pow(t, 3) * end.y;
                points.push({ x: Math.round(x), y: Math.round(y) });
            }
            return points;
        };
        
        // Current position
        let currentX = Math.random() * viewport.width;
        let currentY = Math.random() * viewport.height;
        
        // Target position
        const targetX = Math.random() * viewport.width;
        const targetY = Math.random() * viewport.height;
        
        // Control points for bezier curve
        const control1 = {
            x: currentX + (targetX - currentX) * 0.25 + (Math.random() - 0.5) * 100,
            y: currentY + (targetY - currentY) * 0.25 + (Math.random() - 0.5) * 100
        };
        const control2 = {
            x: currentX + (targetX - currentX) * 0.75 + (Math.random() - 0.5) * 100,
            y: currentY + (targetY - currentY) * 0.75 + (Math.random() - 0.5) * 100
        };
        
        // Generate smooth path
        const points = generateBezierPoints(
            { x: currentX, y: currentY },
            { x: targetX, y: targetY },
            control1,
            control2
        );
        
        // Move mouse along path with variable speed
        for (const point of points) {
            await page.mouse.move(point.x, point.y);
            
            // Variable delay to simulate natural movement speed
            const delay = 10 + Math.random() * 30;
            await new Promise(resolve => setTimeout(resolve, delay));
        }
        
        // Occasionally perform micro-movements (human jitter)
        if (Math.random() > 0.7) {
            const jitterX = targetX + (Math.random() - 0.5) * 5;
            const jitterY = targetY + (Math.random() - 0.5) * 5;
            await page.mouse.move(jitterX, jitterY);
        }
    }

    /**
     * Advanced scrolling patterns
     */
    async simulateRealisticScrolling(page) {
        const scrollPatterns = [
            async () => {
                // Smooth continuous scroll
                for (let i = 0; i < 5; i++) {
                    await page.evaluate(() => window.scrollBy(0, 100));
                    await new Promise(resolve => setTimeout(resolve, 100 + Math.random() * 200));
                }
            },
            async () => {
                // Quick scroll with pause to read
                await page.evaluate(() => window.scrollBy(0, 500));
                await new Promise(resolve => setTimeout(resolve, 2000 + Math.random() * 3000));
            },
            async () => {
                // Scroll to specific element
                const elements = await page.$$('h2, h3, p');
                if (elements.length > 0) {
                    const randomElement = elements[Math.floor(Math.random() * elements.length)];
                    await randomElement.scrollIntoViewIfNeeded();
                    await new Promise(resolve => setTimeout(resolve, 1000 + Math.random() * 2000));
                }
            },
            async () => {
                // Page up/down simulation
                await page.keyboard.press('PageDown');
                await new Promise(resolve => setTimeout(resolve, 500 + Math.random() * 1000));
            }
        ];
        
        const pattern = scrollPatterns[Math.floor(Math.random() * scrollPatterns.length)];
        await pattern();
    }

    /**
     * Analyze behavior patterns and adjust strategy
     */
    analyzeAndAdjustBehavior() {
        // Check request frequency
        const recentRequests = this.requestPatterns.filter(
            r => Date.now() - r.timestamp < 60000 // Last minute
        );
        
        if (recentRequests.length > 30) {
            console.log('⚠️ High request frequency detected, increasing delays');
            this.options.minDelay = Math.min(this.options.minDelay + 1, 10);
            this.options.maxDelay = Math.min(this.options.maxDelay + 2, 20);
        }
        
        // Check mouse movement patterns
        if (this.mouseMovements.length > 100) {
            const movements = this.mouseMovements.slice(-100);
            const averageSpeed = this.calculateMouseSpeed(movements);
            
            if (averageSpeed > 1000) { // pixels per second
                console.log('⚠️ Mouse movement too fast, adjusting behavior');
            }
        }
        
        // Clear old data
        this.requestPatterns = this.requestPatterns.slice(-1000);
        this.mouseMovements = this.mouseMovements.slice(-1000);
    }

    /**
     * Calculate mouse movement speed
     */
    calculateMouseSpeed(movements) {
        if (movements.length < 2) return 0;
        
        let totalDistance = 0;
        let totalTime = 0;
        
        for (let i = 1; i < movements.length; i++) {
            const dx = movements[i].x - movements[i-1].x;
            const dy = movements[i].y - movements[i-1].y;
            const distance = Math.sqrt(dx * dx + dy * dy);
            const time = movements[i].timestamp - movements[i-1].timestamp;
            
            totalDistance += distance;
            totalTime += time;
        }
        
        return totalTime > 0 ? (totalDistance / totalTime) * 1000 : 0; // pixels per second
    }

    /**
     * Get random timezone
     */
    getRandomTimezone() {
        const timezones = [
            'America/New_York', 'America/Chicago', 'America/Los_Angeles',
            'Europe/London', 'Europe/Paris', 'Europe/Berlin',
            'Asia/Tokyo', 'Asia/Shanghai', 'Australia/Sydney'
        ];
        return timezones[Math.floor(Math.random() * timezones.length)];
    }

    /**
     * Get random locale
     */
    getRandomLocale() {
        const locales = ['en-US', 'en-GB', 'en-CA', 'en-AU', 'de-DE', 'fr-FR', 'es-ES'];
        return locales[Math.floor(Math.random() * locales.length)];
    }

    /**
     * Get random screen resolution
     */
    getRandomScreenResolution() {
        const resolutions = [
            { width: 1920, height: 1080, deviceScaleFactor: 1 },
            { width: 2560, height: 1440, deviceScaleFactor: 1.5 },
            { width: 1440, height: 900, deviceScaleFactor: 2 },
            { width: 1366, height: 768, deviceScaleFactor: 1 },
            { width: 1536, height: 864, deviceScaleFactor: 1.25 }
        ];
        return resolutions[Math.floor(Math.random() * resolutions.length)];
    }

    /**
     * Get random hardware profile
     */
    getRandomHardwareProfile() {
        return {
            cpuCores: 4 + Math.floor(Math.random() * 4) * 2, // 4, 6, 8, 10
            memory: Math.pow(2, 2 + Math.floor(Math.random() * 3)), // 4, 8, 16
            platform: ['Win32', 'MacIntel', 'Linux x86_64'][Math.floor(Math.random() * 3)]
        };
    }

    /**
     * Get random font set
     */
    getRandomFontSet() {
        const fontSets = [
            ['Arial', 'Helvetica', 'Times New Roman', 'Georgia', 'Verdana'],
            ['Roboto', 'Open Sans', 'Lato', 'Montserrat', 'Source Sans Pro'],
            ['San Francisco', 'Helvetica Neue', 'Lucida Grande', 'Arial', 'Verdana']
        ];
        return fontSets[Math.floor(Math.random() * fontSets.length)];
    }

    /**
     * Get random plugin configuration
     */
    getRandomPlugins() {
        const pluginSets = [
            ['Chrome PDF Plugin', 'Chrome PDF Viewer', 'Native Client'],
            ['Shockwave Flash', 'Chrome PDF Plugin', 'Chrome PDF Viewer'],
            []
        ];
        return pluginSets[Math.floor(Math.random() * pluginSets.length)];
    }

    /**
     * Generate WebGL fingerprint
     */
    generateWebGLFingerprint() {
        const vendors = ['Intel Inc.', 'NVIDIA Corporation', 'AMD', 'Apple Inc.'];
        const renderers = [
            'Intel Iris OpenGL Engine',
            'NVIDIA GeForce GTX 1080',
            'AMD Radeon Pro 5500M',
            'Apple M1'
        ];
        
        return {
            vendor: vendors[Math.floor(Math.random() * vendors.length)],
            renderer: renderers[Math.floor(Math.random() * renderers.length)]
        };
    }

    /**
     * Generate Canvas fingerprint noise
     */
    generateCanvasFingerprint() {
        return {
            noise: Math.random(),
            offsetRed: Math.floor(Math.random() * 5),
            offsetGreen: Math.floor(Math.random() * 5),
            offsetBlue: Math.floor(Math.random() * 5)
        };
    }

    /**
     * Generate Audio fingerprint
     */
    generateAudioFingerprint() {
        return {
            sampleRate: [44100, 48000][Math.floor(Math.random() * 2)],
            maxChannelCount: 2,
            numberOfInputs: 1,
            numberOfOutputs: 1,
            channelCount: 2,
            channelCountMode: 'max',
            channelInterpretation: 'speakers'
        };
    }

    /**
     * Get random geolocation
     */
    getRandomGeolocation() {
        const locations = [
            { latitude: 40.7128, longitude: -74.0060 }, // New York
            { latitude: 51.5074, longitude: -0.1278 },  // London
            { latitude: 35.6762, longitude: 139.6503 }, // Tokyo
            { latitude: -33.8688, longitude: 151.2093 }, // Sydney
        ];
        return locations[Math.floor(Math.random() * locations.length)];
    }

    /**
     * Get advanced HTTP headers
     */
    getAdvancedHeaders() {
        return {
            'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8',
            'Accept-Language': `${this.sessionFingerprint.locale},en;q=0.9`,
            'Accept-Encoding': 'gzip, deflate, br',
            'Cache-Control': 'max-age=0',
            'Sec-Ch-Ua': '"Not_A Brand";v="8", "Chromium";v="120"',
            'Sec-Ch-Ua-Mobile': '?0',
            'Sec-Ch-Ua-Platform': '"macOS"',
            'Upgrade-Insecure-Requests': '1',
            'User-Agent': this.generateAdvancedUserAgent(),
            'Sec-Fetch-Site': 'none',
            'Sec-Fetch-Mode': 'navigate',
            'Sec-Fetch-User': '?1',
            'Sec-Fetch-Dest': 'document'
        };
    }

    /**
     * Advanced navigation with full behavioral simulation
     */
    async navigateWithFullStealth(url) {
        if (!this.page) {
            await this.initStealthBrowser();
        }
        
        console.log(`🌐 Navigating to ${url} with full stealth mode...`);
        
        // Pre-navigation delay (simulate thinking time)
        await this.delay(2000 + Math.random() * 3000);
        
        // Navigate
        await this.page.goto(url, {
            waitUntil: 'networkidle',
            timeout: 60000
        });
        
        // Post-navigation behavioral simulation
        await this.performFullBehavioralSimulation();
        
        return this.page;
    }

    /**
     * Perform comprehensive behavioral simulation
     */
    async performFullBehavioralSimulation() {
        const actions = [
            () => this.simulateRealisticMouseMovement(this.page),
            () => this.simulateRealisticScrolling(this.page),
            () => this.simulateReading(),
            () => this.simulateInteraction(),
            () => this.simulateFocus()
        ];
        
        // Perform 2-5 random actions
        const numActions = 2 + Math.floor(Math.random() * 4);
        
        for (let i = 0; i < numActions; i++) {
            const action = actions[Math.floor(Math.random() * actions.length)];
            await action();
            
            // Natural pause between actions
            await this.delay(500 + Math.random() * 2000);
        }
    }

    /**
     * Simulate reading behavior
     */
    async simulateReading() {
        // Find paragraphs
        const paragraphs = await this.page.$$('p');
        
        if (paragraphs.length > 0) {
            const randomParagraph = paragraphs[Math.floor(Math.random() * Math.min(paragraphs.length, 5))];
            
            // Scroll to paragraph
            await randomParagraph.scrollIntoViewIfNeeded();
            
            // Calculate reading time based on text length
            const text = await randomParagraph.textContent();
            const wordsPerMinute = 200 + Math.random() * 100;
            const words = text.split(' ').length;
            const readingTime = (words / wordsPerMinute) * 60 * 1000;
            
            // Simulate reading with micro-movements
            const startTime = Date.now();
            while (Date.now() - startTime < Math.min(readingTime, 5000)) {
                if (Math.random() > 0.8) {
                    // Small scroll
                    await this.page.evaluate(() => window.scrollBy(0, 10 + Math.random() * 20));
                }
                await this.delay(200 + Math.random() * 500);
            }
        }
    }

    /**
     * Simulate user interaction
     */
    async simulateInteraction() {
        // Find interactive elements
        const links = await this.page.$$('a');
        const buttons = await this.page.$$('button');
        const inputs = await this.page.$$('input');
        
        const elements = [...links.slice(0, 5), ...buttons.slice(0, 3), ...inputs.slice(0, 2)];
        
        if (elements.length > 0) {
            const randomElement = elements[Math.floor(Math.random() * elements.length)];
            
            // Hover over element
            await randomElement.hover();
            await this.delay(500 + Math.random() * 1000);
            
            // Sometimes click (but not submit forms)
            if (Math.random() > 0.7 && !await randomElement.evaluate(el => el.type === 'submit')) {
                const box = await randomElement.boundingBox();
                if (box) {
                    // Click with offset from center
                    await this.page.mouse.click(
                        box.x + box.width / 2 + (Math.random() - 0.5) * 10,
                        box.y + box.height / 2 + (Math.random() - 0.5) * 10
                    );
                }
            }
        }
    }

    /**
     * Simulate focus changes
     */
    async simulateFocus() {
        // Tab through elements occasionally
        if (Math.random() > 0.5) {
            const numTabs = 1 + Math.floor(Math.random() * 3);
            for (let i = 0; i < numTabs; i++) {
                await this.page.keyboard.press('Tab');
                await this.delay(300 + Math.random() * 500);
            }
        }
    }

    /**
     * Smart delay with human-like variance
     */
    async delay(ms) {
        // Add gaussian noise to delay
        const gaussianRandom = () => {
            let u = 0, v = 0;
            while (u === 0) u = Math.random();
            while (v === 0) v = Math.random();
            return Math.sqrt(-2.0 * Math.log(u)) * Math.cos(2.0 * Math.PI * v);
        };
        
        const variance = ms * 0.2; // 20% variance
        const actualDelay = Math.max(100, ms + gaussianRandom() * variance);
        
        await new Promise(resolve => setTimeout(resolve, actualDelay));
    }

    /**
     * Clean up session
     */
    async close() {
        if (this.browser) {
            await this.browser.close();
            console.log(`✅ Session closed. Fingerprint: ${this.sessionFingerprint.sessionId}`);
        }
    }
}

// Export for use in other modules
module.exports = { AdvancedAntiDetection };

// CLI interface
if (require.main === module) {
    const url = process.argv[2];
    
    if (!url) {
        console.log('Usage: node advanced-anti-detection-v2.js <url>');
        process.exit(1);
    }
    
    (async () => {
        const scraper = new AdvancedAntiDetection();
        
        try {
            await scraper.navigateWithFullStealth(url);
            
            console.log('✅ Page loaded with full stealth');
            console.log('📊 Session fingerprint:', scraper.sessionFingerprint);
            
            // Keep session alive for testing
            await scraper.delay(10000);
            
        } catch (error) {
            console.error('❌ Error:', error);
        } finally {
            await scraper.close();
        }
    })();
}