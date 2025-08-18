#!/usr/bin/env python3

"""
Research PDF Generation API Backend
Handles all parameters for automated PDF generation from web interface
"""

import json
import subprocess
import sys
import os
from pathlib import Path
from datetime import datetime
from typing import Dict, Any, Optional
import argparse
import logging

# Setup logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

class ResearchPDFGenerator:
    def __init__(self, base_dir: str = None):
        self.base_dir = Path(base_dir) if base_dir else Path.cwd()
        self.script_dir = self.base_dir / "00_SYSTEM"
        self.projects_dir = self.base_dir / "03_PROJECTS"
        
    def validate_parameters(self, params: Dict[str, Any]) -> Dict[str, Any]:
        """Validate and normalize input parameters"""
        
        # Required fields
        required = ['research_type', 'target_name']
        for field in required:
            if field not in params:
                raise ValueError(f"Missing required field: {field}")
        
        # Validate research type
        valid_types = ['individual', 'organization', 'audience']
        if params['research_type'] not in valid_types:
            raise ValueError(f"Invalid research_type. Must be one of: {valid_types}")
        
        # Validate template
        valid_templates = ['tufte', 'sakura', 'corporate', 'classic']
        template = params.get('template', 'corporate')
        if template not in valid_templates:
            raise ValueError(f"Invalid template. Must be one of: {valid_templates}")
        params['template'] = template
        
        # Normalize target name for filesystem
        params['target_name_clean'] = params['target_name'].replace(' ', '_').replace('/', '_')
        
        # Set defaults
        params.setdefault('include_keywords', False)
        params.setdefault('keywords', [])
        params.setdefault('client_name', params['target_name'])
        params.setdefault('generate_new_research', False)
        
        return params
    
    def find_or_create_project(self, params: Dict[str, Any]) -> Path:
        """Find existing project or create new one"""
        
        target_clean = params['target_name_clean']
        research_type = params['research_type']
        
        # Look for existing project
        if params.get('project_path'):
            project_path = Path(params['project_path'])
            if project_path.exists():
                logger.info(f"Using specified project: {project_path}")
                return project_path
        
        # Search for existing projects
        client_dir = self.projects_dir / target_clean
        if client_dir.exists():
            # Find most recent research folder
            research_folders = list(client_dir.glob(f"Research_*_{target_clean}_*"))
            if research_folders:
                # Sort by modification time, get most recent
                project_path = max(research_folders, key=lambda p: p.stat().st_mtime)
                logger.info(f"Found existing project: {project_path}")
                return project_path
        
        # Create new project if requested
        if params.get('generate_new_research'):
            timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
            project_name = f"Research_{research_type.title()}_{target_clean}_{timestamp}"
            project_path = client_dir / project_name
            project_path.mkdir(parents=True, exist_ok=True)
            logger.info(f"Created new project: {project_path}")
            
            # Initialize project structure
            self._initialize_project_structure(project_path, params)
            
            # Trigger research if requested
            if params.get('trigger_research'):
                self._trigger_research(project_path, params)
            
            return project_path
        
        raise FileNotFoundError(f"No existing project found for {params['target_name']}")
    
    def _initialize_project_structure(self, project_path: Path, params: Dict[str, Any]):
        """Initialize standard project directory structure"""
        
        dirs = [
            '01_searches',
            '02_fetched_content', 
            '03_extracted_data',
            '04_analysis',
            '05_synthesis',
            'PDFs'
        ]
        
        for dir_name in dirs:
            (project_path / dir_name).mkdir(exist_ok=True)
        
        # Create project config
        config = {
            'research_type': params['research_type'],
            'target_name': params['target_name'],
            'client_name': params['client_name'],
            'template': params['template'],
            'created': datetime.now().isoformat(),
            'include_keywords': params['include_keywords'],
            'keywords': params.get('keywords', [])
        }
        
        with open(project_path / 'PROJECT_CONFIG.json', 'w') as f:
            json.dump(config, f, indent=2)
    
    def _trigger_research(self, project_path: Path, params: Dict[str, Any]):
        """Trigger automated research collection"""
        
        logger.info("Triggering automated research...")
        
        # This would integrate with your existing research scripts
        # For now, placeholder for the research trigger
        research_script = self.script_dir / "run-mega-analysis.sh"
        
        if research_script.exists():
            cmd = [str(research_script), str(project_path)]
            result = subprocess.run(cmd, capture_output=True, text=True)
            
            if result.returncode != 0:
                logger.error(f"Research failed: {result.stderr}")
            else:
                logger.info("Research completed successfully")
    
    def add_executive_summary(self, document_path: Path, params: Dict[str, Any]) -> Path:
        """Add executive summary to the beginning of document"""
        
        with open(document_path, 'r') as f:
            content = f.read()
        
        # Extract key points for executive summary
        summary = self._generate_executive_summary(content, params)
        
        # Prepend executive summary
        enhanced_content = f"""<div class="executive-summary">

# Executive Summary

## {params['target_name']} - {params['research_type'].title()} Assessment

### Key Findings

{summary['key_findings']}

### Risk Assessment

{summary['risk_assessment']}

### Recommendations

{summary['recommendations']}

### Methodology
- Research Type: {params['research_type'].title()}
- Analysis Date: {datetime.now().strftime('%B %d, %Y')}
- Template: {params['template'].title()}
- Citations: Comprehensive source documentation included

</div>

<div class="page-break"></div>

{content}"""
        
        output_path = document_path.with_suffix('.enhanced.md')
        with open(output_path, 'w') as f:
            f.write(enhanced_content)
        
        return output_path
    
    def _generate_executive_summary(self, content: str, params: Dict[str, Any]) -> Dict:
        """Generate executive summary from content"""
        
        # Extract first few substantial paragraphs for key findings
        lines = content.split('\n')
        key_points = []
        risk_points = []
        
        for line in lines[:100]:  # Scan first 100 lines
            if any(word in line.lower() for word in ['founded', 'established', 'revenue', 'employees']):
                key_points.append(f"- {line.strip()}")
            if any(word in line.lower() for word in ['risk', 'concern', 'issue', 'problem']):
                risk_points.append(f"- {line.strip()}")
        
        # Default summaries based on research type
        if params['research_type'] == 'individual':
            default_findings = """
- Professional background and career trajectory analyzed
- Public presence and reputational indicators assessed
- Network connections and affiliations documented
- Media coverage and public statements reviewed"""
            
            default_risks = """
- Reputational vulnerabilities identified and categorized
- Historical controversies or concerns documented
- Potential conflicts of interest noted
- Public perception risks evaluated"""
            
            default_recs = """
- Continue monitoring public presence and media coverage
- Maintain awareness of network changes and new affiliations
- Regular updates recommended quarterly
- Consider deeper investigation into flagged areas"""
            
        elif params['research_type'] == 'organization':
            default_findings = """
- Corporate structure and leadership team profiled
- Financial performance and market position analyzed
- Competitive landscape and market share assessed
- Stakeholder relationships and partnerships documented"""
            
            default_risks = """
- Business risks and market vulnerabilities identified
- Regulatory compliance status reviewed
- Competitive threats and market disruptions analyzed
- Operational and financial risk factors documented"""
            
            default_recs = """
- Implement continuous monitoring of market position
- Track competitor movements and industry trends
- Regular financial health assessments recommended
- Consider strategic risk mitigation strategies"""
            
        else:  # audience
            default_findings = """
- Target audience demographics and psychographics profiled
- Content preferences and engagement patterns analyzed
- Key influencers and thought leaders identified
- Communication channels and platforms mapped"""
            
            default_risks = """
- Audience fragmentation risks identified
- Content saturation and competition analyzed
- Platform dependencies and reach limitations noted
- Engagement decline indicators monitored"""
            
            default_recs = """
- Optimize content strategy based on audience insights
- Diversify communication channels to reduce risk
- Implement A/B testing for message optimization
- Regular audience sentiment analysis recommended"""
        
        return {
            'key_findings': '\n'.join(key_points[:4]) if key_points else default_findings,
            'risk_assessment': '\n'.join(risk_points[:4]) if risk_points else default_risks,
            'recommendations': default_recs
        }
    
    def generate_outputs(self, params: Dict[str, Any]) -> Dict[str, Any]:
        """Main entry point for output generation (PDF, WordPress, or both)"""
        
        try:
            # Validate parameters
            params = self.validate_parameters(params)
            
            # Determine output types
            output_types = params.get('output_types', ['pdf'])
            if isinstance(output_types, str):
                output_types = [output_types]
            
            logger.info(f"Generating outputs for {params['target_name']} ({params['research_type']})")
            logger.info(f"Output types: {output_types}")
            
            # Find or create project
            project_path = self.find_or_create_project(params)
            
            # Add keyword data if applicable
            if params['research_type'] == 'audience' and params['include_keywords']:
                # This would integrate with DataForSEO
                self._add_keyword_data(project_path, params)
            
            results = {
                'success': True,
                'project_path': str(project_path),
                'outputs': {},
                'message': f"Outputs generated successfully for {params['target_name']}"
            }
            
            # Generate PDF if requested
            if 'pdf' in output_types:
                logger.info("Generating PDF output...")
                
                script_path = self.script_dir / "generate-research-pdf-automated.sh"
                cmd = [
                    str(script_path),
                    str(project_path),
                    params['template'],
                    params['research_type']
                ]
                
                result = subprocess.run(cmd, capture_output=True, text=True)
                
                if result.returncode == 0:
                    pdf_dir = project_path / "PDFs"
                    pdf_files = list(pdf_dir.glob("*.pdf"))
                    
                    if pdf_files:
                        pdf_path = pdf_files[0]
                        results['outputs']['pdf'] = {
                            'success': True,
                            'path': str(pdf_path),
                            'size': pdf_path.stat().st_size
                        }
                    else:
                        results['outputs']['pdf'] = {
                            'success': False,
                            'error': 'PDF file not found after generation'
                        }
                else:
                    results['outputs']['pdf'] = {
                        'success': False,
                        'error': result.stderr
                    }
            
            # Publish to WordPress if requested
            if 'wordpress' in output_types:
                logger.info("Publishing to WordPress...")
                
                # Import WordPress publisher
                from publish_to_wordpress import WordPressPublisher
                
                try:
                    publisher = WordPressPublisher()
                    
                    wp_result = publisher.publish_research(
                        project_path=str(project_path),
                        research_type=params['research_type'],
                        target_name=params['target_name'],
                        status=params.get('wordpress_status', 'draft')
                    )
                    
                    results['outputs']['wordpress'] = wp_result
                    
                except Exception as e:
                    results['outputs']['wordpress'] = {
                        'success': False,
                        'error': str(e)
                    }
            
            # Check if any outputs succeeded
            any_success = any(
                output.get('success', False) 
                for output in results['outputs'].values()
            )
            
            if not any_success:
                results['success'] = False
                results['message'] = "All output generation failed"
            
            return results
            
        except Exception as e:
            logger.error(f"PDF generation failed: {str(e)}")
            return {
                'success': False,
                'error': str(e),
                'message': f"Failed to generate PDF: {str(e)}"
            }
    
    def _add_keyword_data(self, project_path: Path, params: Dict[str, Any]):
        """Add keyword research data for audience scans"""
        
        keywords = params.get('keywords', [])
        if not keywords:
            return
        
        logger.info(f"Adding keyword data for {len(keywords)} keywords")
        
        # This would integrate with DataForSEO MCP
        # For now, create placeholder
        keyword_data = {
            'keywords': keywords,
            'generated': datetime.now().isoformat(),
            'data': [
                {
                    'keyword': kw,
                    'search_volume': 'TBD',
                    'competition': 'TBD',
                    'cpc': 'TBD'
                }
                for kw in keywords
            ]
        }
        
        with open(project_path / '03_extracted_data' / 'keyword_data.json', 'w') as f:
            json.dump(keyword_data, f, indent=2)

def main():
    """CLI interface for testing"""
    
    parser = argparse.ArgumentParser(description='Research Output Generation API')
    parser.add_argument('--params', type=str, help='JSON parameters string or file path')
    parser.add_argument('--research-type', choices=['individual', 'organization', 'audience'])
    parser.add_argument('--target-name', type=str, help='Target name for research')
    parser.add_argument('--template', choices=['tufte', 'sakura', 'corporate', 'classic'])
    parser.add_argument('--output-types', nargs='+', choices=['pdf', 'wordpress'],
                       default=['pdf'], help='Output types to generate')
    parser.add_argument('--wordpress-status', choices=['draft', 'publish', 'private'],
                       default='draft', help='WordPress post status')
    parser.add_argument('--keywords', nargs='+', help='Keywords for audience scan')
    parser.add_argument('--project-path', type=str, help='Existing project path')
    
    args = parser.parse_args()
    
    # Build parameters
    if args.params:
        if args.params.startswith('{'):
            params = json.loads(args.params)
        else:
            with open(args.params, 'r') as f:
                params = json.load(f)
    else:
        params = {}
        if args.research_type:
            params['research_type'] = args.research_type
        if args.target_name:
            params['target_name'] = args.target_name
        if args.template:
            params['template'] = args.template
        if args.output_types:
            params['output_types'] = args.output_types
        if args.wordpress_status:
            params['wordpress_status'] = args.wordpress_status
        if args.keywords:
            params['keywords'] = args.keywords
            params['include_keywords'] = True
        if args.project_path:
            params['project_path'] = args.project_path
    
    # Generate outputs
    generator = ResearchPDFGenerator()
    result = generator.generate_outputs(params)
    
    # Output result
    print(json.dumps(result, indent=2))
    
    return 0 if result['success'] else 1

if __name__ == "__main__":
    sys.exit(main())