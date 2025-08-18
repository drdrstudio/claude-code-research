#!/usr/bin/env python3

"""
WordPress Publishing System for Research Reports
Publishes research content to waterloo.digital (Flywheel hosted)
"""

import json
import requests
import sys
import os
from pathlib import Path
from datetime import datetime
from typing import Dict, Any, Optional
import base64
import re
import logging

# Setup logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

class WordPressPublisher:
    def __init__(self, site_url: str = "https://waterloo.digital", 
                 username: str = None, 
                 password: str = None):
        """
        Initialize WordPress publisher
        
        Args:
            site_url: WordPress site URL
            username: WordPress username (or use env var WP_USERNAME)
            password: WordPress application password (or use env var WP_PASSWORD)
        """
        self.site_url = site_url.rstrip('/')
        self.api_url = f"{self.site_url}/wp-json/wp/v2"
        
        # Get credentials from env vars if not provided
        self.username = username or os.getenv('WP_USERNAME')
        self.password = password or os.getenv('WP_PASSWORD')
        
        if not self.username or not self.password:
            raise ValueError("WordPress credentials required. Set WP_USERNAME and WP_PASSWORD env vars")
        
        # Create auth header
        credentials = f"{self.username}:{self.password}"
        encoded = base64.b64encode(credentials.encode()).decode('utf-8')
        self.headers = {
            'Authorization': f'Basic {encoded}',
            'Content-Type': 'application/json'
        }
    
    def test_connection(self) -> bool:
        """Test WordPress API connection"""
        try:
            response = requests.get(f"{self.api_url}/posts", headers=self.headers)
            return response.status_code == 200
        except Exception as e:
            logger.error(f"Connection test failed: {e}")
            return False
    
    def create_or_get_category(self, name: str, description: str = "") -> int:
        """Create category if it doesn't exist, return category ID"""
        
        # Check if category exists
        response = requests.get(
            f"{self.api_url}/categories",
            params={'search': name},
            headers=self.headers
        )
        
        if response.status_code == 200:
            categories = response.json()
            if categories:
                return categories[0]['id']
        
        # Create new category
        data = {
            'name': name,
            'description': description,
            'slug': name.lower().replace(' ', '-')
        }
        
        response = requests.post(
            f"{self.api_url}/categories",
            json=data,
            headers=self.headers
        )
        
        if response.status_code == 201:
            return response.json()['id']
        else:
            logger.error(f"Failed to create category: {response.text}")
            return 1  # Default to uncategorized
    
    def upload_media(self, file_path: str, alt_text: str = "") -> Dict:
        """Upload media file to WordPress"""
        
        file_path = Path(file_path)
        if not file_path.exists():
            logger.error(f"File not found: {file_path}")
            return {}
        
        # Prepare file upload
        with open(file_path, 'rb') as f:
            file_data = f.read()
        
        headers = {
            'Authorization': self.headers['Authorization'],
            'Content-Disposition': f'attachment; filename="{file_path.name}"',
            'Content-Type': 'image/png' if file_path.suffix == '.png' else 'image/jpeg'
        }
        
        response = requests.post(
            f"{self.api_url}/media",
            data=file_data,
            headers=headers
        )
        
        if response.status_code == 201:
            media = response.json()
            
            # Update alt text if provided
            if alt_text:
                update_data = {'alt_text': alt_text}
                requests.post(
                    f"{self.api_url}/media/{media['id']}",
                    json=update_data,
                    headers=self.headers
                )
            
            return media
        else:
            logger.error(f"Failed to upload media: {response.text}")
            return {}
    
    def convert_markdown_to_html(self, markdown_content: str) -> str:
        """Convert markdown to WordPress-compatible HTML"""
        
        # Basic markdown to HTML conversion
        html = markdown_content
        
        # Convert headers
        html = re.sub(r'^### (.*?)$', r'<h3>\1</h3>', html, flags=re.MULTILINE)
        html = re.sub(r'^## (.*?)$', r'<h2>\1</h2>', html, flags=re.MULTILINE)
        html = re.sub(r'^# (.*?)$', r'<h1>\1</h1>', html, flags=re.MULTILINE)
        
        # Convert bold and italic
        html = re.sub(r'\*\*\*(.*?)\*\*\*', r'<strong><em>\1</em></strong>', html)
        html = re.sub(r'\*\*(.*?)\*\*', r'<strong>\1</strong>', html)
        html = re.sub(r'\*(.*?)\*', r'<em>\1</em>', html)
        
        # Convert links
        html = re.sub(r'\[([^\]]+)\]\(([^)]+)\)', r'<a href="\2">\1</a>', html)
        
        # Convert lists
        html = re.sub(r'^\* (.*)$', r'<li>\1</li>', html, flags=re.MULTILINE)
        html = re.sub(r'^\- (.*)$', r'<li>\1</li>', html, flags=re.MULTILINE)
        html = re.sub(r'^\d+\. (.*)$', r'<li>\1</li>', html, flags=re.MULTILINE)
        
        # Wrap consecutive list items
        html = re.sub(r'(<li>.*?</li>\n)+', lambda m: f'<ul>\n{m.group()}</ul>\n', html)
        
        # Convert blockquotes
        html = re.sub(r'^> (.*)$', r'<blockquote>\1</blockquote>', html, flags=re.MULTILINE)
        
        # Convert code blocks
        html = re.sub(r'```(.*?)```', r'<pre><code>\1</code></pre>', html, flags=re.DOTALL)
        html = re.sub(r'`([^`]+)`', r'<code>\1</code>', html)
        
        # Convert paragraphs
        paragraphs = html.split('\n\n')
        html = '\n\n'.join([f'<p>{p}</p>' if not p.startswith('<') else p for p in paragraphs])
        
        # Add WordPress styling classes
        html = html.replace('<h1>', '<h1 class="wp-block-heading">')
        html = html.replace('<h2>', '<h2 class="wp-block-heading">')
        html = html.replace('<h3>', '<h3 class="wp-block-heading">')
        html = html.replace('<ul>', '<ul class="wp-block-list">')
        html = html.replace('<blockquote>', '<blockquote class="wp-block-quote">')
        
        return html
    
    def create_post(self, 
                   title: str,
                   content: str,
                   research_type: str,
                   target_name: str,
                   status: str = 'draft',
                   featured_image_path: str = None) -> Dict:
        """
        Create WordPress post from research content
        
        Args:
            title: Post title
            content: Markdown content to publish
            research_type: Type of research (individual/organization/audience)
            target_name: Name of research target
            status: Post status (draft/publish/private)
            featured_image_path: Path to featured image
        
        Returns:
            Dict with post details including URL
        """
        
        # Convert markdown to HTML
        html_content = self.convert_markdown_to_html(content)
        
        # Add research metadata box at top
        metadata_html = f"""
        <div class="research-metadata" style="background: #f5f5f5; padding: 20px; margin-bottom: 30px; border-left: 4px solid #1B365D;">
            <h4>Research Intelligence Report</h4>
            <ul style="list-style: none; padding: 0;">
                <li><strong>Type:</strong> {research_type.title()} Analysis</li>
                <li><strong>Subject:</strong> {target_name}</li>
                <li><strong>Generated:</strong> {datetime.now().strftime('%B %d, %Y')}</li>
                <li><strong>Source:</strong> Waterloo Strategic Intelligence</li>
            </ul>
        </div>
        """
        
        # Combine metadata and content
        full_content = metadata_html + html_content
        
        # Create or get category based on research type
        category_map = {
            'individual': 'Individual Profiles',
            'organization': 'Company Intelligence',
            'audience': 'Audience Analysis'
        }
        category_id = self.create_or_get_category(
            category_map.get(research_type, 'Research Reports')
        )
        
        # Upload featured image if provided
        featured_media_id = None
        if featured_image_path and Path(featured_image_path).exists():
            media = self.upload_media(featured_image_path, f"{target_name} Research")
            if media:
                featured_media_id = media.get('id')
        
        # Prepare post data
        post_data = {
            'title': title,
            'content': full_content,
            'status': status,
            'categories': [category_id],
            'tags': [],
            'format': 'standard',
            'meta': {
                'research_type': research_type,
                'target_name': target_name,
                'generation_date': datetime.now().isoformat()
            }
        }
        
        # Add featured image if available
        if featured_media_id:
            post_data['featured_media'] = featured_media_id
        
        # Add tags based on research type
        if research_type == 'individual':
            post_data['tags'] = ['executive-profile', 'reputational-assessment', 'due-diligence']
        elif research_type == 'organization':
            post_data['tags'] = ['company-analysis', 'competitive-intelligence', 'market-research']
        elif research_type == 'audience':
            post_data['tags'] = ['audience-insights', 'market-segmentation', 'keyword-research']
        
        # Create the post
        response = requests.post(
            f"{self.api_url}/posts",
            json=post_data,
            headers=self.headers
        )
        
        if response.status_code == 201:
            post = response.json()
            logger.info(f"Post created successfully: {post['link']}")
            
            return {
                'success': True,
                'post_id': post['id'],
                'post_url': post['link'],
                'edit_url': f"{self.site_url}/wp-admin/post.php?post={post['id']}&action=edit",
                'status': post['status'],
                'title': post['title']['rendered']
            }
        else:
            logger.error(f"Failed to create post: {response.text}")
            return {
                'success': False,
                'error': response.text
            }
    
    def update_post(self, post_id: int, updates: Dict) -> Dict:
        """Update existing WordPress post"""
        
        response = requests.post(
            f"{self.api_url}/posts/{post_id}",
            json=updates,
            headers=self.headers
        )
        
        if response.status_code == 200:
            post = response.json()
            return {
                'success': True,
                'post_url': post['link']
            }
        else:
            return {
                'success': False,
                'error': response.text
            }
    
    def publish_research(self, 
                        project_path: str,
                        research_type: str,
                        target_name: str,
                        status: str = 'draft') -> Dict:
        """
        Main method to publish research to WordPress
        
        Args:
            project_path: Path to research project
            research_type: Type of research
            target_name: Name of research target
            status: Publication status (draft/publish/private)
        """
        
        project_path = Path(project_path)
        
        # Find main document
        main_doc = None
        search_paths = [
            project_path / 'FINAL_REPORTS' / 'Comprehensive_Dossier.md',
            project_path / '05_synthesis' / 'FINAL_COMPREHENSIVE_ANALYSIS.md',
            project_path / '05_synthesis' / 'comprehensive_analysis.md'
        ]
        
        for path in search_paths:
            if path.exists():
                main_doc = path
                break
        
        if not main_doc:
            return {
                'success': False,
                'error': 'No main document found in project'
            }
        
        # Read content
        with open(main_doc, 'r') as f:
            content = f.read()
        
        # Extract title from first header or use target name
        title_match = re.search(r'^# (.+)$', content, re.MULTILINE)
        if title_match:
            title = title_match.group(1)
        else:
            title = f"{target_name} - {research_type.title()} Intelligence Report"
        
        # Look for logo/image
        logo_path = None
        for pattern in ['*logo*.png', '*logo*.jpg', 'featured*.png']:
            logos = list(project_path.glob(f"**/{pattern}"))
            if logos:
                logo_path = str(logos[0])
                break
        
        # Publish to WordPress
        result = self.create_post(
            title=title,
            content=content,
            research_type=research_type,
            target_name=target_name,
            status=status,
            featured_image_path=logo_path
        )
        
        return result

def main():
    """CLI interface for WordPress publishing"""
    
    import argparse
    
    parser = argparse.ArgumentParser(description='Publish research to WordPress')
    parser.add_argument('project_path', help='Path to research project')
    parser.add_argument('--research-type', required=True, 
                       choices=['individual', 'organization', 'audience'])
    parser.add_argument('--target-name', required=True, help='Name of research target')
    parser.add_argument('--status', default='draft',
                       choices=['draft', 'publish', 'private'],
                       help='Publication status')
    parser.add_argument('--site-url', default='https://waterloo.digital',
                       help='WordPress site URL')
    
    args = parser.parse_args()
    
    # Initialize publisher
    try:
        publisher = WordPressPublisher(site_url=args.site_url)
        
        # Test connection
        if not publisher.test_connection():
            print("❌ Failed to connect to WordPress API")
            print("Please check credentials in WP_USERNAME and WP_PASSWORD env vars")
            return 1
        
        print(f"✅ Connected to {args.site_url}")
        
        # Publish research
        result = publisher.publish_research(
            project_path=args.project_path,
            research_type=args.research_type,
            target_name=args.target_name,
            status=args.status
        )
        
        if result['success']:
            print(f"✅ Published successfully!")
            print(f"📄 View post: {result['post_url']}")
            print(f"✏️ Edit post: {result['edit_url']}")
        else:
            print(f"❌ Publishing failed: {result.get('error', 'Unknown error')}")
            return 1
            
    except Exception as e:
        print(f"❌ Error: {e}")
        return 1
    
    return 0

if __name__ == "__main__":
    sys.exit(main())