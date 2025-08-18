// API Configuration
const API_CONFIG = {
  // Auto-detect if running locally or on Railway
  baseUrl: window.location.hostname === 'localhost' 
    ? 'http://localhost:5001' 
    : `https://${window.location.hostname}`,
  
  endpoints: {
    research: '/api/research',
    status: '/api/status',
    health: '/api/health',
    pdf: '/api/pdf'
  }
};

// Export for use in HTML
window.API_CONFIG = API_CONFIG;