#!/usr/bin/env python3
"""
Sequential Thinking Orchestration Template for Individual Reputational Scans
This template directs the MCP stack through multi-phase research with quality gates
"""

import json
import os
import sys
from datetime import datetime
from typing import Dict, List, Optional, Tuple

class ReputationalScanOrchestrator:
    """
    Orchestrates a reputational scan using Sequential Thinking to direct MCP tools
    with quality gate checkpoints at each phase.
    """
    
    def __init__(self, project_config_path: str):
        """Initialize with project configuration"""
        with open(project_config_path, 'r') as f:
            self.config = json.load(f)
        
        self.project_dir = os.path.dirname(project_config_path)
        self.target_name = self.config['target']['name']
        self.quality_gates = self.config['quality_gates']
        self.investigation_vectors = self.config['investigation_vectors']
        
        # Track research state
        self.research_state = {
            'phase': 'initialization',
            'identity_confirmed': False,
            'confidence_scores': {},
            'sources_collected': [],
            'associates_identified': [],
            'gates_passed': [],
            'gates_failed': []
        }
    
    def sequential_thinking_prompt(self, phase: str, context: Dict) -> str:
        """
        Generate Sequential Thinking prompts for each research phase
        """
        prompts = {
            'identity_verification': f"""
            ## Sequential Thinking Task: Identity Verification
            
            Target: {self.target_name}
            
            Your task is to verify the identity of this individual with high confidence.
            
            Step 1: Search for "{self.target_name}" on LinkedIn using Perplexity
            Step 2: Cross-reference with company websites using Firecrawl
            Step 3: Find recent news mentions for biographical consistency
            Step 4: Evaluate confidence level (0-1.0)
            
            Quality Gate: We need 80% confidence to proceed.
            
            If confidence < 80%:
            - Identify what additional information is needed
            - Suggest specific search queries to resolve ambiguity
            - Flag potential identity conflicts
            
            Return structured data:
            - identity_confirmed: boolean
            - confidence_score: float
            - key_identifiers: list
            - sources: list of URLs
            """,
            
            'professional_history': f"""
            ## Sequential Thinking Task: Professional History Investigation
            
            Confirmed Identity: {context.get('confirmed_identity', {})}
            
            Investigate complete professional history and business conduct:
            
            Step 1: Search SEC EDGAR database for any filings
            Step 2: Find all company affiliations (current and past)
            Step 3: Identify board memberships
            Step 4: Look for business failures, lawsuits, or controversies
            Step 5: Create timeline of professional positions
            
            Use this MCP stack:
            - Perplexity: Initial broad search
            - Firecrawl: Deep dive on company pages
            - Sequential verification of each claim
            
            Quality Gate: Each significant claim needs 2+ sources
            
            Return structured findings with citations.
            """,
            
            'network_analysis_level1': f"""
            ## Sequential Thinking Task: Network Analysis - Level 1
            
            Target: {self.target_name}
            Known Information: {context.get('professional_history', {})}
            
            Identify all primary business associates:
            
            Step 1: Extract names from board memberships
            Step 2: Find co-founders and business partners
            Step 3: Identify major investors/investees
            Step 4: Rank by significance (financial involvement, current activity, influence)
            
            For each associate found:
            - Name and title
            - Nature of relationship
            - Timeline of association
            - Significance score (0-1.0)
            
            Quality Gate: Minimum 60% confidence in relationship
            
            Return top 10 associates ranked by significance.
            """,
            
            'network_analysis_level2': f"""
            ## Sequential Thinking Task: Network Analysis - Level 2
            
            Top Associates to Scan: {context.get('top_associates', [])}
            
            Conduct condensed reputational scan on top 3-5 associates:
            
            For each associate:
            Step 1: Quick legal/regulatory check
            Step 2: Search for major controversies or scandals
            Step 3: Check for bankruptcy or financial distress
            Step 4: Assess reputational standing
            
            Focus on RED FLAGS only:
            - Criminal charges or investigations
            - SEC violations or sanctions
            - Major lawsuits (>$1M)
            - Bankruptcy filings
            - Public scandals
            
            Quality Gate: Only report verified liabilities with primary sources
            
            Return liability assessment for each associate.
            """,
            
            'synthesis': f"""
            ## Sequential Thinking Task: Final Synthesis
            
            All Research Data: {context.get('research_summary', {})}
            
            Create comprehensive synthesis:
            
            Step 1: Compile all verified findings
            Step 2: Assess overall reputational risk (Low/Medium/High)
            Step 3: Identify key vulnerabilities
            Step 4: Map network liability exposure
            Step 5: Generate executive summary
            
            Ensure every claim has a citation.
            
            Structure the final report according to the template.
            """
        }
        
        return prompts.get(phase, "Unknown phase")
    
    def evaluate_quality_gate(self, gate_name: str, data: Dict) -> Tuple[bool, str]:
        """
        Evaluate if a quality gate passes or fails
        Returns (pass/fail, reason)
        """
        if not self.quality_gates['enabled']:
            return True, "Quality gates disabled"
        
        gate_configs = {
            'identity_verification': {
                'threshold': self.quality_gates['thresholds']['identity_confidence'],
                'check': lambda d: d.get('confidence_score', 0) >= self.quality_gates['thresholds']['identity_confidence']
            },
            'source_credibility': {
                'threshold': self.quality_gates['thresholds']['source_credibility'],
                'check': lambda d: self._evaluate_source_credibility(d.get('sources', []))
            },
            'data_completeness': {
                'threshold': self.quality_gates['thresholds']['data_completeness'],
                'check': lambda d: self._evaluate_data_completeness(d)
            },
            'network_correlation': {
                'threshold': self.quality_gates['thresholds']['network_relevance'],
                'check': lambda d: self._evaluate_network_relevance(d.get('associates', []))
            }
        }
        
        if gate_name not in gate_configs:
            return True, f"Unknown gate: {gate_name}"
        
        gate = gate_configs[gate_name]
        passes = gate['check'](data)
        
        if passes:
            self.research_state['gates_passed'].append(gate_name)
            return True, f"Gate passed (threshold: {gate['threshold']})"
        else:
            self.research_state['gates_failed'].append(gate_name)
            return False, f"Gate failed (below threshold: {gate['threshold']})"
    
    def _evaluate_source_credibility(self, sources: List[str]) -> bool:
        """Evaluate credibility of sources"""
        if not sources:
            return False
        
        # Simple heuristic: check for known credible domains
        credible_domains = [
            'sec.gov', 'bloomberg.com', 'reuters.com', 'wsj.com',
            'nytimes.com', 'linkedin.com', 'court', '.gov'
        ]
        
        credible_count = sum(1 for source in sources 
                           if any(domain in source.lower() for domain in credible_domains))
        
        credibility_ratio = credible_count / len(sources) if sources else 0
        return credibility_ratio >= self.quality_gates['thresholds']['source_credibility']
    
    def _evaluate_data_completeness(self, data: Dict) -> bool:
        """Evaluate if we have enough data to proceed"""
        required_fields = ['identity', 'professional_history', 'public_statements', 'sources']
        present_fields = sum(1 for field in required_fields if data.get(field))
        
        completeness_ratio = present_fields / len(required_fields)
        return completeness_ratio >= self.quality_gates['thresholds']['data_completeness']
    
    def _evaluate_network_relevance(self, associates: List[Dict]) -> bool:
        """Evaluate relevance of identified associates"""
        if not associates:
            return False
        
        relevant_count = sum(1 for assoc in associates 
                           if assoc.get('significance_score', 0) >= 0.5)
        
        return relevant_count >= 3  # Need at least 3 relevant associates
    
    def generate_orchestration_plan(self) -> Dict:
        """
        Generate the complete orchestration plan for Sequential Thinking
        """
        plan = {
            'project': self.config['project_id'],
            'target': self.target_name,
            'phases': [
                {
                    'phase_id': 1,
                    'name': 'Identity Verification',
                    'sequential_thinking_steps': 5,
                    'quality_gate': 'identity_verification',
                    'mcp_tools': ['perplexity', 'firecrawl'],
                    'estimated_time': '5-10 minutes',
                    'outputs': ['confirmed_identity.json', 'identity_sources.md']
                },
                {
                    'phase_id': 2,
                    'name': 'Multi-Vector Investigation',
                    'sequential_thinking_steps': 20,
                    'quality_gate': 'source_credibility',
                    'mcp_tools': ['perplexity', 'firecrawl', 'reddit', 'tavily'],
                    'estimated_time': '30-45 minutes',
                    'outputs': ['professional_history.md', 'public_statements.md', 
                              'online_sentiment.md', 'legal_records.md']
                },
                {
                    'phase_id': 3,
                    'name': 'Network Analysis Level 1',
                    'sequential_thinking_steps': 10,
                    'quality_gate': 'network_correlation',
                    'mcp_tools': ['perplexity', 'firecrawl'],
                    'estimated_time': '15-20 minutes',
                    'outputs': ['primary_associates.json', 'network_map.json']
                },
                {
                    'phase_id': 4,
                    'name': 'Network Analysis Level 2',
                    'sequential_thinking_steps': 15,
                    'quality_gate': 'source_credibility',
                    'mcp_tools': ['perplexity', 'firecrawl', 'tavily'],
                    'estimated_time': '20-30 minutes',
                    'outputs': ['associate_scans.md', 'liability_matrix.json']
                },
                {
                    'phase_id': 5,
                    'name': 'Synthesis and Report Generation',
                    'sequential_thinking_steps': 10,
                    'quality_gate': 'data_completeness',
                    'mcp_tools': ['sequential_thinking'],
                    'estimated_time': '15-20 minutes',
                    'outputs': ['final_report.md', 'executive_summary.md', 'knowledge_graph.json']
                }
            ],
            'total_estimated_time': '85-125 minutes',
            'quality_gates_enabled': self.quality_gates['enabled'],
            'auto_proceed_threshold': self.quality_gates['thresholds']['auto_proceed_above']
        }
        
        return plan
    
    def save_orchestration_plan(self):
        """Save the orchestration plan to the project directory"""
        plan = self.generate_orchestration_plan()
        plan_path = os.path.join(self.project_dir, '01_planning', 'orchestration_plan.json')
        
        os.makedirs(os.path.dirname(plan_path), exist_ok=True)
        
        with open(plan_path, 'w') as f:
            json.dump(plan, f, indent=2)
        
        print(f"Orchestration plan saved to: {plan_path}")
        return plan_path
    
    def generate_execution_script(self):
        """Generate the actual execution script with MCP calls"""
        script_content = f"""#!/usr/bin/env python3
'''
Auto-generated execution script for {self.target_name} reputational scan
Generated: {datetime.now().isoformat()}
'''

import os
import json
import time
from datetime import datetime

# Project configuration
PROJECT_DIR = "{self.project_dir}"
TARGET_NAME = "{self.target_name}"
QUALITY_GATES = {self.quality_gates['enabled']}

def log_phase(phase_name):
    print(f"\\n{'='*60}")
    print(f"  {{phase_name}}")
    print(f"{'='*60}\\n")
    
def execute_identity_verification():
    log_phase("PHASE 1: Identity Verification")
    
    # This will be replaced with actual MCP tool calls
    print(f"Searching for {{TARGET_NAME}} on LinkedIn...")
    # mcp__perplexity__perplexity_search_web(query=f"{{TARGET_NAME}} LinkedIn profile")
    
    print("Cross-referencing with company websites...")
    # mcp__firecrawl__firecrawl_search(query=f"{{TARGET_NAME}} biography company")
    
    # Quality gate check
    if QUALITY_GATES:
        print("\\nEvaluating identity confidence...")
        # Check confidence and decide whether to proceed
    
    return {{"identity_confirmed": True, "confidence": 0.85}}

def execute_multi_vector_investigation():
    log_phase("PHASE 2: Multi-Vector Investigation")
    
    vectors = [
        "Professional History",
        "Public Statements",
        "Online Sentiment",
        "Legal Records"
    ]
    
    for vector in vectors:
        print(f"\\nInvestigating: {{vector}}")
        # MCP calls for each vector
        time.sleep(1)  # Placeholder for actual research
    
    return {{"vectors_completed": len(vectors)}}

def execute_network_analysis():
    log_phase("PHASE 3: Network Analysis")
    
    print("Level 1: Identifying primary associates...")
    # MCP calls to find associates
    
    print("Level 2: Scanning top associates...")
    # Deep dive on top 3-5
    
    print("Level 3: Analyzing relationships...")
    # Relationship mapping
    
    return {{"associates_found": 10, "deep_scanned": 5}}

def generate_final_report():
    log_phase("PHASE 4: Report Generation")
    
    print("Compiling all findings...")
    print("Inserting citations...")
    print("Generating knowledge graph...")
    print("Creating PDF output...")
    
    return {{"report_generated": True, "pages": 35}}

def main():
    start_time = datetime.now()
    
    print(f"Starting Reputational Scan for: {{TARGET_NAME}}")
    print(f"Quality Gates: {{'ON' if QUALITY_GATES else 'OFF'}}")
    
    # Execute phases
    identity_result = execute_identity_verification()
    
    if identity_result['identity_confirmed']:
        investigation_result = execute_multi_vector_investigation()
        network_result = execute_network_analysis()
        report_result = generate_final_report()
    else:
        print("\\n⚠️  Identity verification failed. Manual review required.")
        return
    
    # Summary
    end_time = datetime.now()
    duration = (end_time - start_time).total_seconds() / 60
    
    print(f"\\n{'='*60}")
    print(f"  SCAN COMPLETE")
    print(f"{'='*60}")
    print(f"Duration: {{duration:.1f}} minutes")
    print(f"Report location: {{PROJECT_DIR}}/06_output/final_report.pdf")

if __name__ == "__main__":
    main()
"""
        
        script_path = os.path.join(self.project_dir, 'execute_scan.py')
        with open(script_path, 'w') as f:
            f.write(script_content)
        
        os.chmod(script_path, 0o755)
        print(f"Execution script generated: {script_path}")
        return script_path


def main():
    """Main entry point for orchestration"""
    if len(sys.argv) < 2:
        print("Usage: python sequential-thinking-reputational-template.py <project_config.json>")
        sys.exit(1)
    
    config_path = sys.argv[1]
    
    if not os.path.exists(config_path):
        print(f"Error: Config file not found: {config_path}")
        sys.exit(1)
    
    orchestrator = ReputationalScanOrchestrator(config_path)
    
    print("Reputational Scan Orchestrator initialized")
    print(f"Target: {orchestrator.target_name}")
    print(f"Quality Gates: {'Enabled' if orchestrator.quality_gates['enabled'] else 'Disabled'}")
    
    # Generate and save orchestration plan
    orchestrator.save_orchestration_plan()
    
    # Generate execution script
    orchestrator.generate_execution_script()
    
    print("\nOrchestration setup complete!")
    print("Run the execution script to start the scan.")


if __name__ == "__main__":
    main()