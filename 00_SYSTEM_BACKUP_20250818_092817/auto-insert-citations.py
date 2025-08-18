#!/usr/bin/env python3

"""
Automatic Citation Insertion System
Intelligently inserts citations into documents based on content matching
"""

import json
import re
import sys
import os
from pathlib import Path
from typing import Dict, List, Tuple

class CitationInserter:
    def __init__(self, project_dir: str):
        self.project_dir = Path(project_dir)
        self.citations = {}
        self.file_content_map = {}
        self.citation_index = {}
        
    def load_citations(self, citation_file: str = "citations.json"):
        """Load citation index from JSON file"""
        with open(citation_file, 'r') as f:
            data = json.load(f)
            
        # Build citation lookup
        for citation in data['citations']:
            self.citations[citation['number']] = citation
            
        # Load file mappings
        self.file_mappings = data.get('file_mappings', {})
        
        return data
    
    def load_research_content(self):
        """Load content from research files for matching"""
        fetched_dir = self.project_dir / "02_fetched_content"
        
        if fetched_dir.exists():
            for file_path in fetched_dir.glob("*.md"):
                with open(file_path, 'r', encoding='utf-8') as f:
                    content = f.read()
                    
                # Store content with its citation number
                filename = file_path.name
                if filename in self.file_mappings:
                    citation_marker = self.file_mappings[filename]['citation']
                    citation_num = int(citation_marker.strip('[^]'))
                    
                    # Extract key phrases for matching
                    self.file_content_map[citation_num] = {
                        'file': filename,
                        'content': content,
                        'key_phrases': self.extract_key_phrases(content)
                    }
    
    def extract_key_phrases(self, content: str) -> List[str]:
        """Extract significant phrases for citation matching"""
        phrases = []
        
        # Extract quotes (most reliable for matching)
        quotes = re.findall(r'"([^"]{20,200})"', content)
        phrases.extend(quotes[:10])
        
        # Extract statistics and numbers
        stats = re.findall(r'\d+[,\d]*\.?\d*\s*(?:million|billion|percent|%|\$|dollars)', content)
        phrases.extend(stats[:10])
        
        # Extract dates
        dates = re.findall(r'(?:January|February|March|April|May|June|July|August|September|October|November|December)\s+\d{1,2},?\s+\d{4}', content)
        phrases.extend(dates[:10])
        
        # Extract proper names (consecutive capitalized words)
        names = re.findall(r'\b[A-Z][a-z]+(?:\s+[A-Z][a-z]+)+\b', content)
        # Filter out common phrases
        names = [n for n in names if len(n.split()) <= 4 and n not in ['United States', 'New York']]
        phrases.extend(list(set(names))[:15])
        
        return phrases
    
    def find_citation_for_text(self, text: str, context: str = "") -> int:
        """Find the appropriate citation number for a piece of text"""
        text_lower = text.lower()
        
        # Check each source's key phrases
        best_match = None
        best_score = 0
        
        for citation_num, source_data in self.file_content_map.items():
            score = 0
            
            # Check for exact phrase matches
            for phrase in source_data['key_phrases']:
                if phrase.lower() in text_lower or phrase.lower() in context.lower():
                    score += 10
                    
            # Check for partial matches
            content_lower = source_data['content'].lower()
            if text_lower in content_lower:
                score += 5
                
            # Fuzzy match for statistics
            numbers_in_text = re.findall(r'\d+[,\d]*\.?\d*', text)
            for num in numbers_in_text:
                if num in source_data['content']:
                    score += 3
                    
            if score > best_score:
                best_score = score
                best_match = citation_num
                
        return best_match
    
    def insert_citations_in_document(self, document_path: str, output_path: str = None):
        """Insert citations into a document"""
        if output_path is None:
            output_path = document_path.replace('.md', '_cited.md')
            
        with open(document_path, 'r', encoding='utf-8') as f:
            content = f.read()
            
        # Split into lines for processing
        lines = content.split('\n')
        cited_lines = []
        
        for i, line in enumerate(lines):
            # Skip headers and empty lines
            if line.startswith('#') or not line.strip():
                cited_lines.append(line)
                continue
                
            # Skip lines that already have citations
            if re.search(r'\[\^\d+\]', line):
                cited_lines.append(line)
                continue
                
            # Get context (surrounding lines)
            context = '\n'.join(lines[max(0, i-2):min(len(lines), i+3)])
            
            # Process sentences in the line
            sentences = re.split(r'(?<=[.!?])\s+', line)
            cited_sentences = []
            
            for sentence in sentences:
                # Check if sentence needs citation
                needs_citation = False
                citation_num = None
                
                # Check for factual claims that need citations
                if any(pattern in sentence for pattern in [
                    '$', '%', 'million', 'billion', 'founded', 'established',
                    'acquired', 'revenue', 'employees', 'headquarters',
                    'announced', 'reported', 'according', 'study', 'research'
                ]):
                    needs_citation = True
                    
                # Check for quotes
                if '"' in sentence:
                    needs_citation = True
                    
                # Check for dates
                if re.search(r'\b\d{4}\b', sentence):
                    needs_citation = True
                    
                # Check for statistics
                if re.search(r'\d+[,\d]*\.?\d*\s*(?:million|billion|percent|%)', sentence):
                    needs_citation = True
                    
                if needs_citation:
                    citation_num = self.find_citation_for_text(sentence, context)
                    
                if citation_num:
                    # Add citation at end of sentence
                    if sentence.rstrip().endswith('.'):
                        sentence = sentence.rstrip('.') + f'.[^{citation_num}]'
                    elif sentence.rstrip().endswith('?') or sentence.rstrip().endswith('!'):
                        sentence = sentence.rstrip() + f'[^{citation_num}]'
                    else:
                        sentence = sentence + f'[^{citation_num}]'
                        
                cited_sentences.append(sentence)
                
            cited_lines.append(' '.join(cited_sentences))
            
        # Add bibliography at the end
        cited_content = '\n'.join(cited_lines)
        
        # Only add bibliography if it's not already there
        if '## Bibliography' not in cited_content and '## References' not in cited_content:
            cited_content += '\n\n## Bibliography\n\n'
            for num in sorted(self.citations.keys()):
                citation = self.citations[num]
                cited_content += f"[^{num}]: {citation['url']} (Accessed: {citation['accessed']})\n"
                
        # Write output
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(cited_content)
            
        return output_path

def main():
    if len(sys.argv) < 3:
        print("Usage: python auto-insert-citations.py <project_directory> <document_to_cite>")
        print("\nThis script automatically inserts citations into documents")
        print("based on content matching with research sources.")
        sys.exit(1)
        
    project_dir = sys.argv[1]
    document_path = sys.argv[2]
    
    print("🔍 Automatic Citation Insertion")
    print("=" * 40)
    
    # Initialize inserter
    inserter = CitationInserter(project_dir)
    
    # Load citations
    citation_file = "citations.json"
    if len(sys.argv) > 3:
        citation_file = sys.argv[3]
        
    print(f"📚 Loading citations from {citation_file}...")
    inserter.load_citations(citation_file)
    
    # Load research content
    print("📂 Loading research content...")
    inserter.load_research_content()
    
    # Insert citations
    print(f"✍️ Inserting citations into {document_path}...")
    output_path = inserter.insert_citations_in_document(document_path)
    
    print(f"✅ Citations inserted successfully!")
    print(f"📄 Output: {output_path}")
    
    # Count citations in output
    with open(output_path, 'r') as f:
        content = f.read()
        citation_count = len(re.findall(r'\[\^\d+\]', content))
        
    print(f"📊 Total citations added: {citation_count}")

if __name__ == "__main__":
    main()