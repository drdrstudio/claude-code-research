#!/bin/bash

# Create Corporate Template CSS
# Professional business-focused styling

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CSS_FILE="$SCRIPT_DIR/themes/corporate-style.css"

cat > "$CSS_FILE" << 'EOF'
/* Corporate Professional Template */
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&family=Merriweather:wght@300;400&display=swap');

:root {
  --primary-color: #1B365D;
  --secondary-color: #2C5282;
  --accent-color: #3182CE;
  --text-primary: #2D3748;
  --text-secondary: #4A5568;
  --background: #FFFFFF;
  --background-alt: #F7FAFC;
  --border-color: #E2E8F0;
}

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
  line-height: 1.6;
  color: var(--text-primary);
  background: var(--background);
  max-width: 8.5in;
  margin: 0 auto;
  padding: 1in;
}

/* Executive Summary - Always at top */
.executive-summary {
  background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
  color: white;
  padding: 2rem;
  margin: -1in -1in 2rem -1in;
  page-break-after: always;
}

.executive-summary h1 {
  font-size: 2.5rem;
  margin-bottom: 1rem;
  font-weight: 700;
}

.executive-summary h2 {
  font-size: 1.5rem;
  margin-top: 1.5rem;
  margin-bottom: 0.75rem;
  border-bottom: 2px solid rgba(255,255,255,0.3);
  padding-bottom: 0.5rem;
}

.executive-summary ul {
  list-style: none;
  padding-left: 0;
}

.executive-summary li:before {
  content: "▸ ";
  color: rgba(255,255,255,0.8);
  font-weight: bold;
}

/* Headers */
h1 {
  font-family: 'Merriweather', serif;
  font-size: 2.25rem;
  color: var(--primary-color);
  margin: 2rem 0 1rem;
  padding-bottom: 0.5rem;
  border-bottom: 3px solid var(--primary-color);
  page-break-after: avoid;
}

h2 {
  font-size: 1.75rem;
  color: var(--secondary-color);
  margin: 1.5rem 0 0.75rem;
  padding-bottom: 0.25rem;
  border-bottom: 1px solid var(--border-color);
  page-break-after: avoid;
}

h3 {
  font-size: 1.25rem;
  color: var(--text-primary);
  margin: 1.25rem 0 0.5rem;
  font-weight: 600;
}

/* Paragraphs and Text */
p {
  margin-bottom: 1rem;
  text-align: justify;
  hyphens: auto;
}

/* Lists */
ul, ol {
  margin: 1rem 0;
  padding-left: 2rem;
}

li {
  margin-bottom: 0.5rem;
}

/* Blockquotes */
blockquote {
  border-left: 4px solid var(--accent-color);
  padding-left: 1.5rem;
  margin: 1.5rem 0;
  font-style: italic;
  color: var(--text-secondary);
  background: var(--background-alt);
  padding: 1rem 1.5rem;
}

/* Tables */
table {
  width: 100%;
  border-collapse: collapse;
  margin: 1.5rem 0;
  font-size: 0.9rem;
}

th {
  background: var(--primary-color);
  color: white;
  padding: 0.75rem;
  text-align: left;
  font-weight: 600;
}

td {
  padding: 0.75rem;
  border-bottom: 1px solid var(--border-color);
}

tr:nth-child(even) {
  background: var(--background-alt);
}

/* Code blocks */
pre {
  background: #2D3748;
  color: #E2E8F0;
  padding: 1rem;
  border-radius: 0.25rem;
  overflow-x: auto;
  margin: 1rem 0;
}

code {
  background: var(--background-alt);
  padding: 0.125rem 0.25rem;
  border-radius: 0.125rem;
  font-size: 0.875rem;
}

/* Links */
a {
  color: var(--accent-color);
  text-decoration: none;
  border-bottom: 1px solid transparent;
  transition: border-color 0.3s;
}

a:hover {
  border-bottom-color: var(--accent-color);
}

/* Citations */
sup {
  font-size: 0.75rem;
  color: var(--accent-color);
}

/* Page breaks */
.page-break {
  page-break-after: always;
}

/* Logo placement */
.logo-header {
  position: fixed;
  top: 0.5in;
  right: 0.5in;
  width: 2in;
  height: auto;
}

/* Bibliography */
.bibliography {
  margin-top: 3rem;
  padding-top: 2rem;
  border-top: 3px solid var(--primary-color);
}

.bibliography h2 {
  color: var(--primary-color);
  margin-bottom: 1rem;
}

.bibliography p {
  font-size: 0.9rem;
  margin-bottom: 0.5rem;
  text-align: left;
  padding-left: 2rem;
  text-indent: -2rem;
}

/* Print optimizations */
@media print {
  body {
    max-width: 100%;
    margin: 0;
    padding: 0.5in;
  }
  
  .executive-summary {
    margin: -0.5in -0.5in 1in -0.5in;
  }
  
  h1, h2, h3 {
    page-break-after: avoid;
  }
  
  table, figure {
    page-break-inside: avoid;
  }
}

/* Metadata box */
.metadata {
  background: var(--background-alt);
  border: 1px solid var(--border-color);
  padding: 1rem;
  margin: 1rem 0;
  border-radius: 0.25rem;
}

.metadata dt {
  font-weight: 600;
  color: var(--text-secondary);
  display: inline-block;
  width: 120px;
}

.metadata dd {
  display: inline;
  margin-left: 0;
}
EOF

echo "✅ Corporate template created: $CSS_FILE"