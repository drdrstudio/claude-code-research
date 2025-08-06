#!/bin/bash

# create-premium-enterprise-document.sh - Generate $100K+ quality enterprise documents 
# Hybrid formal-conversational style with expanded explanations suitable for premium consulting reports

set -e

if [ $# -ne 3 ]; then
    echo "Usage: ./create-premium-enterprise-document.sh <project_folder> <document_type> <output_name>"
    echo ""
    echo "Document Types:"
    echo "  strategic_analysis   - $100K+ strategic analysis with expanded insights"
    echo "  executive_briefing   - C-level briefing with conversational authority"
    echo "  market_intelligence  - Deep market analysis with expanded context"
    echo "  implementation_guide - Premium implementation roadmap"
    echo ""
    echo "Example:"
    echo "  ./create-premium-enterprise-document.sh 'Research_Project_123' 'strategic_analysis' 'Premium_Strategic_Analysis'"
    exit 1
fi

PROJECT_FOLDER="$1"
DOCUMENT_TYPE="$2"
OUTPUT_NAME="$3"

# Verify project folder exists
if [ ! -d "$PROJECT_FOLDER" ]; then
    echo "❌ Error: Project folder '$PROJECT_FOLDER' not found."
    exit 1
fi

echo "🚀 Creating Premium Enterprise Document: $OUTPUT_NAME"
echo "📁 Project: $PROJECT_FOLDER"
echo "📋 Type: $DOCUMENT_TYPE"
echo "💎 Quality Level: $100K+ Premium Consulting Report"
echo "------------------------------------------------------------"

# Generate premium enterprise document prompt based on type
generate_premium_enterprise_prompt() {
    local doc_type="$1"
    local project_data="$2"
    
    case "$doc_type" in
        "strategic_analysis")
            cat << 'EOF'
Create a $100K+ premium strategic analysis document with hybrid formal-conversational tone. Write as if you're a senior partner at McKinsey/BCG explaining complex strategic insights to intelligent executives. Use this EXACT structure with expanded, well-explained content:

# Strategic Analysis: [Extract specific topic from research]
*A Comprehensive Strategic Intelligence Report*

---

## Executive Summary

*The strategic landscape has shifted, and the implications for your organization are profound. Here's what you need to know—and more importantly, what you need to do about it.*

### The Strategic Imperative
[Write 2-3 conversational but authoritative sentences that capture the core strategic challenge and opportunity. Start with impact, then explain context.]

### What We Discovered
Our analysis reveals three critical insights that will fundamentally alter how you approach this market:

1. **[Insight Name]** - [Explain the finding in plain language, then dive into why it matters strategically. Include specific data points but explain their significance.]

2. **[Insight Name]** - [Same format - clear finding, strategic implications, supporting evidence with context about what it means for decision-making.]

3. **[Insight Name]** - [Same format - focus on actionable insights that will drive real business decisions.]

### The Bottom Line
[One paragraph that synthesizes everything into a clear strategic direction. Write as if you're sitting across from the CEO explaining what they need to understand before making any major decisions.]

---

## Understanding the Strategic Context

*Before diving into our findings, let's establish why this analysis matters now—and why the timing couldn't be more critical.*

### The Market Reality
[Explain the current market situation in conversational language that demonstrates deep understanding. Don't just state facts—explain why these market conditions create specific strategic pressures and opportunities.]

### Why This Analysis Was Essential
We conducted this strategic assessment because three factors converged to create an inflection point:

- **[Factor 1]:** [Explain the specific business driver that made this analysis necessary]
- **[Factor 2]:** [Same approach - specific driver with business context]  
- **[Factor 3]:** [Same approach - completing the strategic rationale]

### Our Analytical Approach
[Explain methodology in accessible terms. Focus on why you chose this approach rather than just what you did. Make it clear this was rigorous analysis, not just opinion.]

---

## Strategic Intelligence: What the Data Reveals

*Here's where the analysis gets interesting. The data tells a story that most organizations are missing—but the implications are too important to ignore.*

### Critical Finding #1: [Descriptive Title]

**What We Found:** [Present the core finding clearly and directly]

**Why This Matters:** [This is the crucial section - explain the strategic implications in detail. Why should executives care? What are the second and third-order effects? How does this change the strategic equation?]

**The Supporting Evidence:** 
- [Statistic/Data Point]: [Don't just present the number - explain what it reveals about market dynamics, customer behavior, or competitive positioning]
- [Statistic/Data Point]: [Same approach - data with strategic interpretation]
- [Statistic/Data Point]: [Focus on evidence that supports strategic decision-making]

**Strategic Implications:**
[Write a conversational but authoritative paragraph explaining how this finding should influence strategic thinking. What assumptions need to change? What new possibilities does this create? What risks does it reveal?]

### Critical Finding #2: [Descriptive Title]

[Follow the same structure as Finding #1 - be thorough and explanatory]

### Critical Finding #3: [Descriptive Title]

[Follow the same structure - this section should be substantial and insightful]

### The Competitive Landscape Reality

*Your competitors aren't standing still—but they're not necessarily moving in the right direction either.*

[Provide a strategic assessment of competitive dynamics that goes beyond basic analysis. Explain what competitors are doing, why they're doing it, whether it's working, and what it means for strategic positioning.]

### Customer Intelligence That Changes Everything

*Understanding what customers actually want—versus what they say they want—is where real strategic advantage lives.*

[Provide deep customer insights that reveal strategic opportunities. Focus on behavioral patterns, unmet needs, and evolving expectations that create strategic openings.]

---

## Strategic Recommendations: Your Path Forward

*Strategy without execution is just planning. Here's your roadmap to competitive advantage.*

### The Strategic Framework
[Explain the overarching strategic approach in clear, conversational terms. Why this framework? Why now? How does it address the specific challenges and opportunities identified?]

### Immediate Strategic Actions (Next 90 Days)

**1. [Action Title]**
**What to Do:** [Clear, specific action with measurable outcomes]
**Why This Matters:** [Explain the strategic rationale - why this action, why now, why this approach]
**Expected Impact:** [Quantify the business impact where possible, explain strategic benefits]
**Implementation Notes:** [Practical guidance on execution - what could go wrong, what to watch for]

**2. [Action Title]**
[Follow same detailed format for each recommendation]

### Long-Term Strategic Initiatives (6-18 Months)

**1. [Initiative Title]**
**Strategic Objective:** [What you're trying to achieve strategically]
**Why This Approach:** [Explain the strategic logic - why this initiative will create sustainable advantage]
**Implementation Framework:** [High-level approach with key milestones]
**Success Metrics:** [How you'll know it's working - both operational and strategic measures]
**Resource Requirements:** [What it will take to succeed - be realistic about investment needed]

**2. [Initiative Title]**
[Same detailed treatment for each major initiative]

---

## Implementation: Making Strategy Real

*The best strategy in the world is worthless without flawless execution. Here's how to make it happen.*

### The Implementation Reality
[Acknowledge the challenges of strategic implementation while providing a realistic path forward. Address organizational readiness, resource constraints, and change management needs.]

### Phase 1: Foundation Building (Months 1-6)
**Strategic Focus:** [What you're building and why]
**Key Activities:** [Major workstreams with clear outcomes]
**Success Milestones:** [How you'll track progress]
**Potential Challenges:** [What could go wrong and how to address it]

### Phase 2: Strategic Execution (Months 7-12)
[Same detailed format - focus on how each phase builds strategic capability]

### Phase 3: Optimization & Scale (Months 13-18)
[Same format - emphasis on sustainable competitive advantage]

---

## Risk Management: Protecting Strategic Value

*Every strategy faces risks. The key is managing them proactively rather than reactively.*

### Strategic Risk Assessment

**High-Impact Risks**
1. **[Risk Name]:** [Describe the risk, its potential impact, and early warning indicators]
   **Mitigation Strategy:** [Specific steps to prevent or minimize impact]
   **Contingency Plan:** [What to do if the risk materializes]

2. **[Risk Name]:** [Same detailed treatment]

### Market Disruption Scenarios
[Analyze potential market disruptions and how the strategy would adapt. Show strategic resilience and flexibility.]

---

## Financial Impact: The Business Case

*Strategy must deliver measurable business value. Here's the financial reality of our recommendations.*

### Investment Requirements
[Present investment needs in context of strategic value creation. Explain why each investment is necessary for strategic success.]

### Expected Returns
[Quantify expected benefits where possible, but also explain strategic value that's harder to measure. Be realistic about timelines and probability of success.]

### ROI Analysis
[Provide detailed financial analysis that helps executives understand the business case for strategic investment.]

---

## Strategic Implications: The Bigger Picture

*This analysis reveals implications that extend beyond the immediate strategic challenge. Here's what else you should be thinking about.*

### Industry Evolution
[Explain how the findings reveal broader industry trends and what they mean for long-term strategic positioning.]

### Organizational Capabilities
[Assess what capabilities the organization needs to develop to execute the strategy successfully.]

### Future Strategic Options
[Identify how current strategic moves create or constrain future strategic flexibility.]

---

## Conclusion: Your Strategic Advantage

*The analysis is complete. The strategic path is clear. Now it's time to act.*

### The Strategic Opportunity
[Synthesize the analysis into a compelling case for action. Explain the window of opportunity and why acting now creates sustainable advantage.]

### What Success Looks Like
[Paint a clear picture of strategic success - what the organization will achieve, how it will be positioned, what competitive advantages it will enjoy.]

### The Path Forward
[Provide clear next steps that translate strategic analysis into organizational action.]

---

## Appendices

### A. Methodology and Data Sources
[Detailed explanation of analytical approach, data sources, and validation methods]

### B. Supporting Analysis
[Additional data and analysis that supports key findings]

### C. Implementation Tools
[Frameworks, templates, and tools for strategic execution]

---

*Strategic Analysis prepared by: Strategic Intelligence Team*  
*Analysis Date: [Current Date]*  
*Strategic Review Cycle: Quarterly*  
*Classification: Strategic Planning - Executive Distribution*  
*Investment Level: Premium Strategic Assessment ($100K+ Consulting Grade)*

---

**CRITICAL INSTRUCTIONS FOR PREMIUM QUALITY:**

1. **Conversational Authority**: Write like a senior partner explaining complex insights to intelligent executives. Use "you" and "your organization" naturally.

2. **Strategic Depth**: Don't just present findings—explain their strategic significance, second-order effects, and implications for competitive positioning.

3. **Evidence-Based**: Every major point must be supported by data from the research, but explain what the data means strategically, not just what it says.

4. **Actionable Insights**: Each section should advance strategic understanding and provide clear direction for decision-making.

5. **Executive Perspective**: Write for executives who need to understand complex strategic dynamics quickly but thoroughly.

6. **Implementation Focus**: Balance strategic thinking with practical execution guidance—strategy without execution is worthless.

7. **Risk Awareness**: Address strategic risks and challenges honestly while providing clear mitigation approaches.

8. **Premium Polish**: This is $100K+ quality—every sentence should demonstrate deep strategic thinking and professional excellence.

9. **Expanded Explanations**: Don't assume prior knowledge. Explain the "why" behind every recommendation and the "so what" of every finding.

10. **Strategic Synthesis**: Connect findings to broader strategic themes and long-term competitive advantage.
EOF
            ;;
        "executive_briefing")
            cat << 'EOF'
Create a $100K+ premium executive briefing with hybrid formal-conversational tone. Write as if you're briefing the CEO directly—authoritative but accessible. Use this EXACT structure:

# Executive Briefing: [Extract specific topic from research]
*Strategic Intelligence for Leadership Decision-Making*

---

## The Strategic Picture: What You Need to Know

*Let's cut straight to what matters most for your next board meeting.*

### The Bottom Line Up Front
[Write a compelling opening that captures the strategic opportunity or challenge in one powerful paragraph. Make it impossible to ignore.]

### Strategic Impact Summary
- **Market Opportunity:** [Quantified opportunity with context about strategic significance]
- **Investment Requirement:** [Resource needs with ROI context]  
- **Timeline for Action:** [When decisions need to be made and why timing matters]
- **Competitive Advantage:** [How this creates sustainable differentiation]

### The Three Things That Will Keep You Ahead of Competition

1. **[Strategic Insight #1]** - [Explain the insight and why it gives you competitive advantage]

2. **[Strategic Insight #2]** - [Same format—insight plus strategic value]

3. **[Strategic Insight #3]** - [Focus on actionable strategic intelligence]

---

## Strategic Context: Why This Matters Now

*The market has shifted, and the window for strategic advantage is open—but it won't stay that way.*

### The Strategic Inflection Point
[Explain the market dynamics that create urgency. Why now? What happens if you wait? What's the cost of inaction?]

### Your Competitive Position
[Frank assessment of current strategic position relative to competitors. Where do you win? Where are you vulnerable? What's changing?]

### The Strategic Stakes
[Explain what's at risk and what's possible. Make the strategic consequences of action vs. inaction crystal clear.]

---

## Strategic Intelligence: The Insights That Matter

*Here's what the analysis reveals about your strategic options—and why conventional wisdom is wrong.*

### Game-Changing Insight #1: [Descriptive Title]

**What This Means for Your Business:**
[Explain the finding in terms of business impact. How does this change your strategic equation? What new possibilities does it create?]

**The Strategic Implication:**
[Dive deeper into why this matters for competitive positioning. What should change about how you think about the market, customers, or competition?]

**Supporting Evidence:**
[Present key data points with strategic context. Don't just show numbers—explain what they reveal about strategic opportunities.]

### Game-Changing Insight #2: [Descriptive Title]
[Same detailed format]

### Game-Changing Insight #3: [Descriptive Title]  
[Same detailed format]

### What Your Competitors Are Missing
[Explain strategic blindspots in the competitive landscape. Where are competitors making mistakes? What opportunities are they overlooking?]

---

## Strategic Recommendations: Your Move

*Strategy is about choices. Here are the choices that will define your competitive future.*

### The Strategic Framework
[Explain your recommended strategic approach in clear terms. Why this strategy? How does it create sustainable advantage? What makes it different from what competitors are doing?]

### Immediate Strategic Decisions (Next 60 Days)

**Decision #1: [Clear Decision Title]**
- **Recommended Action:** [Specific decision with clear rationale]
- **Strategic Rationale:** [Why this decision creates competitive advantage]
- **Implementation:** [Who needs to do what by when]
- **Success Metrics:** [How you'll know it's working]

**Decision #2: [Clear Decision Title]**
[Same format for each critical decision]

### Strategic Initiatives (6-12 Months)

**Initiative #1: [Initiative Title]**
- **Strategic Objective:** [What you're trying to achieve]
- **Why This Approach:** [Strategic logic and competitive advantage]
- **Resource Requirements:** [Investment needed and expected returns]
- **Key Milestones:** [How to track strategic progress]

**Initiative #2: [Initiative Title]**
[Same detailed format]

---

## Resource Requirements and Returns

*Strategic advantage requires strategic investment. Here's what it takes—and what you get.*

### Strategic Investment Summary

| Investment Category | Amount | Strategic Purpose | Expected Return |
|-------------------|---------|-------------------|-----------------|
| [Category 1] | [Amount] | [Strategic objective] | [Quantified benefit] |
| [Category 2] | [Amount] | [Strategic objective] | [Quantified benefit] |
| **Total Strategic Investment** | **[Total]** | **Competitive Advantage** | **[Total ROI]** |

### The Business Case
[Explain the financial and strategic logic for investment. Why is this the right strategic bet? What happens if you don't invest? How does this compare to other strategic options?]

### Strategic Payback Timeline
- **Short-term (6 months):** [What strategic value you'll see quickly]
- **Medium-term (12 months):** [How strategic advantage builds over time]  
- **Long-term (24+ months):** [Sustainable competitive positioning achieved]

---

## Strategic Risk Management

*Every strategy faces risks. Here's how to manage them while capturing strategic advantage.*

### Strategic Risk Assessment

**High-Impact Strategic Risks:**

1. **[Risk Name]:** [Impact on strategic objectives and probability]
   - **Mitigation:** [How to prevent or minimize strategic impact]
   - **Early Warning Indicators:** [What to watch for]

2. **[Risk Name]:** [Same format]

### Competitive Response Scenarios
[How competitors might respond to your strategic moves and how to maintain advantage despite competitive reactions.]

### Strategic Contingencies
[Alternative strategic approaches if primary strategy faces unexpected challenges.]

---

## Implementation: Making Strategy Happen

*The best strategy in the world is worthless without flawless execution.*

### Strategic Implementation Approach
[Explain how to translate strategic decisions into organizational action. What capabilities are needed? How do you ensure execution excellence?]

### Critical Success Factors
- **[Factor 1]:** [Why this is essential for strategic success]
- **[Factor 2]:** [Same format—critical elements for execution]
- **[Factor 3]:** [Focus on things that could make or break strategy]

### Strategic Milestones and Reviews
- **30-Day Strategic Review:** [What strategic progress to assess]
- **90-Day Strategic Review:** [Key strategic metrics and adjustments]
- **Annual Strategic Assessment:** [How to evaluate long-term strategic success]

---

## Next Steps: Strategic Action Plan

*Strategy requires decisiveness. Here's your roadmap to competitive advantage.*

### Immediate Actions (This Week)
1. **[Action]** - [Owner and strategic impact]
2. **[Action]** - [Owner and strategic impact]

### Strategic Priorities (Next 30 Days)  
1. **[Priority]** - [Resource requirements and expected outcomes]
2. **[Priority]** - [Same format]

### Strategic Review Schedule
[When and how to assess strategic progress and make necessary adjustments]

---

## The Strategic Opportunity

*This analysis reveals a window of strategic opportunity that won't stay open forever.*

### Why You Should Act Now
[Compelling case for immediate strategic action. What's the cost of delay? Why is timing critical for competitive advantage?]

### What Strategic Success Looks Like
[Paint a clear picture of strategic achievement. How will your competitive position change? What advantages will you enjoy?]

### The Competitive Reality
[Final reminder of competitive dynamics and why strategic action creates sustainable advantage.]

---

*Executive Briefing prepared for: Chief Executive Officer*  
*Prepared by: Strategic Intelligence Team*  
*Briefing Date: [Current Date]*  
*Strategic Review: Monthly*  
*Action Required: Strategic Decision Authorization*  
*Investment Level: Premium Executive Assessment ($100K+ Consulting Grade)*

---

**CRITICAL INSTRUCTIONS FOR PREMIUM EXECUTIVE QUALITY:**

1. **CEO-Level Perspective**: Write for the highest level of strategic decision-making. Focus on competitive advantage, market positioning, and sustainable differentiation.

2. **Action-Oriented**: Every section should drive toward strategic decisions and actions. Executives need clear direction, not just analysis.

3. **Conversational Authority**: Use direct language that demonstrates deep strategic insight while remaining accessible. Write like you're sitting across from the CEO.

4. **Strategic Context**: Always explain why insights matter for competitive positioning. Connect findings to broader strategic themes.

5. **Decision Support**: Structure everything to support high-level strategic decision-making. What does the CEO need to decide? When? Based on what strategic logic?

6. **Risk Awareness**: Address strategic risks honestly while providing clear paths to manage them.

7. **Implementation Reality**: Balance strategic thinking with practical execution considerations.

8. **Premium Polish**: This is briefing the CEO—every word should demonstrate strategic expertise and professional excellence.

9. **Competitive Intelligence**: Always consider competitive implications of strategic recommendations.

10. **Strategic Synthesis**: Connect all analysis to sustainable competitive advantage and long-term value creation.
EOF
            ;;
        "market_intelligence")
            cat << 'EOF'
Create a $100K+ premium market intelligence report with hybrid formal-conversational tone. Write like a senior strategy consultant providing deep market insights to executives who need to make billion-dollar decisions. Use this EXACT structure:

# Market Intelligence Report: [Extract specific topic from research]
*Strategic Market Analysis for Competitive Advantage*

---

## Executive Market Intelligence Summary

*The market is telling a story that most companies are missing. Here's what you need to know to get ahead.*

### The Market Reality Check
[Open with a compelling market insight that challenges conventional thinking. What's really happening in this market that others don't see?]

### Strategic Market Opportunity
- **Total Market Value:** [Size with context about growth trajectory]
- **Your Addressable Opportunity:** [Realistic market you can capture]
- **Strategic Window:** [How long this opportunity will remain available]
- **Competitive Dynamics:** [Key competitive forces shaping opportunity]

### Three Market Intelligence Insights That Change Everything

1. **[Market Insight #1]** - [Explain the insight and its strategic implications for market entry or expansion]

2. **[Market Insight #2]** - [Same format—insight plus strategic market implications]

3. **[Market Insight #3]** - [Focus on actionable market intelligence that drives strategy]

---

## Market Landscape: The Strategic Reality

*Understanding the market isn't just about size and growth—it's about where sustainable competitive advantage lives.*

### Market Evolution Analysis
[Explain how the market has evolved and where it's heading. What forces are driving change? Which trends are sustainable vs. temporary? How does this create strategic opportunities?]

### Market Structure Intelligence
[Analyze market structure in strategic terms. Where is value created? How is it distributed? What are the key success factors? Where are the leverage points for new entrants?]

### Market Maturity Assessment
[Evaluate market maturity and what it means for competitive strategy. Early stage markets require different strategies than mature markets. What stage is this market in, and what are the strategic implications?]

---

## Competitive Intelligence: Know Your Competition

*Your competitors aren't just the companies you compete with today—they're the companies that could disrupt your future.*

### Current Competitive Landscape

**Market Leaders Analysis**

**[Leading Company 1]**
- **Market Position:** [Share, revenue, strategic focus]
- **Strategic Approach:** [How they compete and why it works]
- **Competitive Strengths:** [What makes them difficult to displace]
- **Strategic Vulnerabilities:** [Where they're exposed to competitive attack]
- **Future Strategy:** [Where they're heading and what it means for competition]

**[Leading Company 2]**
[Same detailed analysis format]

### Competitive Dynamics Intelligence
[Analyze how companies compete in this market. Is it primarily on price? Innovation? Customer relationships? Distribution? Understanding competitive dynamics reveals where new entrants can succeed.]

### Emerging Competitive Threats
[Identify companies or technologies that could disrupt current market leaders. Where might new competition come from? What would make current strategies obsolete?]

### Competitive Gaps and Opportunities
[Analyze where current competitors aren't serving the market well. What customer needs are unmet? What market segments are underserved? Where are the strategic openings?]

---

## Customer Intelligence: Understanding the Real Buyers

*Customers don't always buy what you think they're buying. Understanding the real purchase drivers is where competitive advantage lives.*

### Customer Segmentation Intelligence

**Primary Customer Segment: [Segment Name]**
- **Segment Size and Value:** [How big and how valuable]
- **Customer Profile:** [Demographics, firmographics, behavioral characteristics]
- **Core Needs Analysis:** [What they really need vs. what they say they need]
- **Purchase Behavior:** [How they buy, when they buy, what influences their decisions]
- **Value Drivers:** [What creates value for this segment]
- **Unmet Needs:** [Where current solutions fall short]
- **Strategic Opportunity:** [How to win with this segment]

**Secondary Customer Segment: [Segment Name]**
[Same detailed analysis format]

### Customer Decision-Making Intelligence
[Deep analysis of how customers actually make purchase decisions. Who's involved? What's the process? What are the real decision criteria? How long does it take? What accelerates or delays decisions?]

### Customer Evolution Trends
[How customer needs and behaviors are changing. What will customers want in the future that they don't want today? How should this influence strategic planning?]

---

## Market Opportunity Analysis: Where to Play and How to Win

*Not all market opportunities are created equal. Here's where the real strategic value lives.*

### Market Sizing Intelligence

**Total Addressable Market (TAM)**
- **Market Size:** [Current size with supporting methodology]
- **Growth Trajectory:** [Historical and projected growth with drivers]
- **Market Drivers:** [What's driving market expansion or contraction]

**Serviceable Addressable Market (SAM)**  
- **Realistic Market:** [Portion you could realistically address]
- **Market Access:** [How to reach this market effectively]
- **Competitive Intensity:** [How competitive this segment is]

**Serviceable Obtainable Market (SOM)**
- **Achievable Share:** [What market share is realistically obtainable]
- **Path to Market:** [How to capture this share]
- **Resource Requirements:** [What it takes to win]

### Strategic Market Opportunities

**High-Value Opportunity #1: [Opportunity Name]**
- **Market Value:** [Size and growth potential]
- **Strategic Rationale:** [Why this opportunity aligns with strategic objectives]
- **Competitive Advantage:** [How to win against competition]
- **Success Requirements:** [What capabilities and resources are needed]
- **Risk Assessment:** [What could go wrong and how to mitigate]

**High-Value Opportunity #2: [Opportunity Name]**
[Same detailed format]

---

## Market Entry Strategy Intelligence

*Entering a market successfully requires more than just having a good product. Here's what really drives market entry success.*

### Market Entry Barriers Analysis
[Analyze what makes it difficult for new players to enter this market. Regulatory barriers? Capital requirements? Customer relationships? Network effects? Understanding barriers helps identify the best entry strategies.]

### Successful Entry Models
[Study how other companies have successfully entered this market. What strategies worked? What failed? What can we learn from both success and failure patterns?]

### Go-to-Market Strategy Options

**Strategy Option #1: [Strategy Name]**
- **Approach:** [How this strategy works]
- **Strategic Advantages:** [Why this approach could succeed]
- **Resource Requirements:** [What it takes to execute]
- **Success Probability:** [Realistic assessment of likelihood]
- **Risk Factors:** [What could make this strategy fail]

**Strategy Option #2: [Strategy Name]**
[Same analysis format]

### Distribution Channel Intelligence
[Analyze how products/services reach customers in this market. What channels work? How are channels changing? Where are the channel opportunities?]

---

## Technology and Innovation Intelligence

*Technology doesn't just enable business—it reshapes entire markets. Here's what's coming and what it means.*

### Current Technology Landscape
[Analyze the role of technology in this market. What technologies are critical for success? How is technology changing customer expectations? Where are the technology-driven opportunities?]

### Emerging Technology Impact
[Identify technologies that could reshape this market. AI? Blockchain? IoT? New manufacturing approaches? How might these technologies change competitive dynamics?]

### Innovation Opportunities
[Where can innovation create competitive advantage? Product innovation? Process innovation? Business model innovation? Which types of innovation matter most in this market?]

---

## Regulatory and Economic Intelligence

*Markets don't exist in a vacuum. Regulatory and economic forces can create opportunities or destroy them.*

### Regulatory Environment Analysis
[How does regulation shape this market? What regulatory changes are coming? How might regulation create opportunities or threats?]

### Economic Impact Assessment
[How do economic conditions affect this market? Is it recession-proof? How do interest rates, inflation, or economic growth affect demand?]

### Policy and Political Considerations
[What policy changes could affect this market? How might political dynamics influence market development?]

---

## Strategic Market Recommendations

*Market intelligence is only valuable if it drives better strategic decisions. Here's what the intelligence tells us to do.*

### Strategic Market Position Recommendation
[Based on the intelligence, what market position should you pursue? Why is this the best strategic choice given market dynamics, competition, and your capabilities?]

### Market Entry Strategy
[Specific recommendations for how to enter or expand in this market. What approach maximizes competitive advantage while minimizing risk?]

### Investment Priorities
**High Priority Investments:**
- **[Investment Area]:** [Why this investment is critical for market success]
- **[Investment Area]:** [Same format—strategic rationale for investment]

**Medium Priority Investments:**
[Same format for secondary priorities]

### Strategic Partnerships and Alliances
[What partnerships could accelerate market success? Which companies should you partner with? What should these partnerships accomplish?]

---

## Market Risk Assessment

*Every market opportunity comes with risks. Here's how to manage market risk while capturing market opportunity.*

### Market Risk Analysis

**High-Impact Market Risks:**

1. **[Risk Name]:** [Description and potential impact on market opportunity]
   - **Risk Mitigation:** [How to prevent or minimize impact]
   - **Contingency Plan:** [What to do if risk materializes]

2. **[Risk Name]:** [Same detailed format]

### Competitive Response Scenarios
[How might competitors respond to your market entry? How can you maintain advantage despite competitive reactions?]

### Market Evolution Scenarios
[How might the market evolve differently than expected? What alternative futures should you plan for?]

---

## Implementation: Turning Intelligence into Action

*Market intelligence without action is just expensive research. Here's how to turn insights into competitive advantage.*

### Market Entry Implementation Plan

**Phase 1: Market Preparation (Months 1-6)**
- **Strategic Objectives:** [What to accomplish in market preparation]
- **Key Activities:** [Critical steps for market readiness]
- **Success Metrics:** [How to measure preparation progress]

**Phase 2: Market Entry (Months 7-12)**
- **Strategic Objectives:** [What market entry should achieve]
- **Key Activities:** [Critical steps for successful entry]
- **Success Metrics:** [How to measure entry success]

**Phase 3: Market Expansion (Months 13-24)**
- **Strategic Objectives:** [How to build market position]
- **Key Activities:** [Steps for sustainable market growth]
- **Success Metrics:** [How to measure market success]

### Resource Requirements for Market Success
[Detailed analysis of what it takes to succeed in this market. People, technology, partnerships, capital—what are the real requirements?]

---

## Market Intelligence Sources and Methodology

*The quality of market intelligence depends on the quality of sources and methodology.*

### Intelligence Sources
- **Primary Research:** [Interviews, surveys, direct market research]
- **Secondary Analysis:** [Industry reports, competitor analysis, market databases]
- **Expert Networks:** [Industry experts, former executives, technical specialists]
- **Competitive Intelligence:** [Public filings, patent analysis, job postings]

### Methodology and Validation
[How the intelligence was gathered, analyzed, and validated. What gives you confidence in the findings?]

### Intelligence Confidence Levels
- **High Confidence:** [Findings supported by multiple sources]
- **Medium Confidence:** [Good supporting evidence]
- **Low Confidence:** [Preliminary findings requiring validation]

---

## Strategic Market Conclusions

*Market intelligence is about seeing opportunities that others miss and understanding risks that others ignore.*

### The Strategic Market Opportunity
[Synthesize the intelligence into a compelling strategic opportunity. Why should you pursue this market? What makes it strategically attractive?]

### Competitive Advantage Potential
[How can you create sustainable competitive advantage in this market? What capabilities would make you difficult to displace?]

### The Path to Market Leadership
[What would it take to become a market leader? Is market leadership a realistic goal? What strategies would get you there?]

---

*Market Intelligence Report prepared by: Strategic Market Analysis Team*  
*Intelligence Date: [Current Date]*  
*Intelligence Update Cycle: Quarterly*  
*Classification: Strategic Planning - Executive Distribution*  
*Investment Level: Premium Market Intelligence ($100K+ Consulting Grade)*

---

**CRITICAL INSTRUCTIONS FOR PREMIUM MARKET INTELLIGENCE:**

1. **Strategic Market Focus**: Don't just analyze the market—analyze how to win in the market. Every insight should connect to competitive advantage.

2. **Intelligence Depth**: Go beyond surface-level market analysis. Understand market dynamics, competitive forces, and customer behavior at a strategic level.

3. **Actionable Intelligence**: Each section should provide intelligence that drives better strategic decisions about market entry, positioning, or expansion.

4. **Competitive Perspective**: Always consider competitive implications. How might competitors respond? Where are competitive advantages and vulnerabilities?

5. **Customer-Centric**: Understand customers as strategic assets. What do they really need? How do they make decisions? How can you create superior customer value?

6. **Forward-Looking**: Analyze not just current market conditions but how the market is evolving. Where are the future opportunities?

7. **Risk-Aware**: Identify and analyze market risks while providing strategies to manage them.

8. **Implementation-Focused**: Connect market intelligence to strategic action. How do you turn insights into competitive advantage?

9. **Premium Quality**: This is $100K+ market intelligence—demonstrate sophisticated market understanding and strategic thinking.

10. **Executive Perspective**: Write for executives who need to make major strategic and investment decisions based on market intelligence.
EOF
            ;;
        "implementation_guide")
            cat << 'EOF'
Create a $100K+ premium implementation guide with hybrid formal-conversational tone. Write like a senior implementation partner who has successfully executed hundreds of strategic initiatives. Use this EXACT structure:

# Implementation Guide: [Extract specific topic from research]
*Strategic Implementation Playbook for Sustainable Success*

---

## Implementation Overview: Making Strategy Real

*The best strategy in the world is worthless without flawless execution. Here's how to turn strategic vision into operational reality.*

### The Implementation Challenge
[Explain why implementation is often harder than strategy development. What makes this particular implementation challenging? Why do most strategic initiatives fail during execution?]

### Strategic Implementation Objectives
- **Primary Goal:** [What successful implementation will accomplish strategically]
- **Success Definition:** [How you'll know implementation has succeeded]
- **Timeline:** [Realistic timeframe for full implementation]
- **Resource Commitment:** [What this implementation requires to succeed]

### Implementation Success Principles
[Explain the core principles that will guide successful implementation. These should be based on proven implementation methodologies and address common failure points.]

---

## Implementation Strategy: The Execution Approach

*Implementation isn't just project management—it's strategic change management. Here's how to approach it.*

### Strategic Implementation Framework
[Explain the overall approach to implementation. Why this framework? How does it address the specific challenges of this initiative? What makes this approach more likely to succeed than alternatives?]

### Implementation Philosophy
[Articulate the mindset and approach that will drive successful execution. Focus on change management, stakeholder engagement, and sustainable adoption.]

### Critical Success Factors
1. **[Success Factor #1]:** [Why this is essential and how to ensure it happens]
2. **[Success Factor #2]:** [Same format—critical elements for success]
3. **[Success Factor #3]:** [Focus on factors that make or break implementation]

---

## Implementation Roadmap: Your Path to Success

*Implementation success requires a clear roadmap with realistic timelines and achievable milestones.*

### Implementation Phase Overview
[Provide a high-level view of implementation phases and how they build toward strategic success.]

### Phase 1: Foundation and Preparation (Months 1-4)

**Strategic Phase Objectives**
[What this phase accomplishes strategically and why it's essential for later success]

**Phase 1 Implementation Activities**

| Activity | Owner | Duration | Dependencies | Success Criteria | Risk Mitigation |
|----------|-------|----------|--------------|------------------|-----------------|
| [Activity 1] | [Role] | [Time] | [Prerequisites] | [Completion standard] | [Risk prevention] |
| [Activity 2] | [Role] | [Time] | [Prerequisites] | [Completion standard] | [Risk prevention] |

**Phase 1 Key Deliverables**
- **[Deliverable 1]:** [What it accomplishes and quality standards]
- **[Deliverable 2]:** [Same format—deliverable with success criteria]

**Phase 1 Success Metrics**
[How you'll measure phase success. Include both completion metrics and quality indicators.]

**Phase 1 Budget and Resources**
- **Personnel Investment:** [Allocation and roles]
- **Technology Investment:** [Systems and tools needed]
- **External Services:** [Consultants, vendors, specialists]
- **Total Phase 1 Investment:** [Amount with ROI context]

**Phase 1 Risk Management**
[Key risks in this phase and specific mitigation strategies]

### Phase 2: Core Implementation (Months 5-10)

**Strategic Phase Objectives**
[What this phase accomplishes and how it builds on Phase 1 success]

**Phase 2 Implementation Activities**

| Activity | Owner | Duration | Dependencies | Success Criteria | Risk Mitigation |
|----------|-------|----------|--------------|------------------|-----------------|
| [Activity 1] | [Role] | [Time] | [Prerequisites] | [Completion standard] | [Risk prevention] |
| [Activity 2] | [Role] | [Time] | [Prerequisites] | [Completion standard] | [Risk prevention] |

**Phase 2 Key Deliverables**
[Same detailed format as Phase 1]

**Phase 2 Success Metrics**
[How to measure implementation progress and quality]

**Phase 2 Budget and Resources**
[Detailed resource requirements and investment levels]

**Phase 2 Risk Management**
[Phase-specific risks and mitigation approaches]

### Phase 3: Optimization and Scaling (Months 11-15)

**Strategic Phase Objectives**
[How this phase ensures sustainable success and scalability]

[Follow same detailed format as previous phases]

---

## Organizational Implementation Requirements

*Implementation success depends on having the right people, skills, and organizational support.*

### Implementation Team Structure

**Core Implementation Team**

**Implementation Leader**
- **Role Requirements:** [Experience, skills, authority needed]
- **Key Responsibilities:** [What this role must accomplish]
- **Success Metrics:** [How to measure leadership effectiveness]
- **Organizational Level:** [Where this role fits in hierarchy]

**Technical Implementation Lead**
- **Role Requirements:** [Technical skills and experience needed]
- **Key Responsibilities:** [Technical deliverables and standards]
- **Success Metrics:** [Technical quality and delivery measures]

**Business Change Manager**
- **Role Requirements:** [Change management expertise needed]
- **Key Responsibilities:** [Organizational adoption and engagement]
- **Success Metrics:** [User adoption and change success measures]

**Subject Matter Experts**
- **Role Requirements:** [Domain expertise needed]
- **Key Responsibilities:** [Knowledge transfer and validation]
- **Success Metrics:** [Knowledge quality and application measures]

### Stakeholder Engagement Strategy

**Executive Stakeholders**
- **Engagement Level:** [How much involvement needed]
- **Communication Approach:** [How to keep executives engaged]
- **Decision Points:** [When executive decisions are needed]
- **Success Metrics:** [How to measure executive support]

**Department Leaders**
- **Engagement Level:** [Department head involvement requirements]
- **Communication Approach:** [How to maintain department support]
- **Resource Commitments:** [What departments need to provide]
- **Success Metrics:** [How to measure department engagement]

**End Users**
- **Engagement Strategy:** [How to ensure user adoption]
- **Training Approach:** [How users will learn new approaches]
- **Feedback Mechanisms:** [How to gather and respond to user input]
- **Success Metrics:** [User adoption and satisfaction measures]

### Skills Development and Training

**New Skills Requirements**
[Detailed analysis of what skills the organization needs to develop for successful implementation]

**Training Strategy**
- **Training Approach:** [How skills will be developed]
- **Training Timeline:** [When training must be completed]
- **Training Delivery:** [In-person, online, blended approaches]
- **Training Validation:** [How to ensure training effectiveness]

**Knowledge Management**
[How to capture, transfer, and maintain critical knowledge throughout implementation]

---

## Technology and Infrastructure Implementation

*Most strategic implementations require technology and infrastructure changes. Here's how to handle them successfully.*

### Technology Requirements Analysis
[Detailed assessment of technology needs for successful implementation]

### System Implementation Strategy

**New System Implementations**
- **System Requirements:** [What the new systems must accomplish]
- **Selection Criteria:** [How to choose the right technology solutions]
- **Implementation Approach:** [Phased rollout vs. big bang vs. pilot approaches]
- **Integration Requirements:** [How new systems connect to existing infrastructure]

**System Integration Projects**
- **Integration Scope:** [What systems need to be connected]
- **Integration Complexity:** [Technical challenges and solutions]
- **Data Migration:** [How to move data safely and completely]
- **Testing Strategy:** [How to ensure integrations work properly]

### Infrastructure Requirements
- **Hardware Needs:** [Servers, network, equipment requirements]
- **Software Licensing:** [Application licenses and maintenance]
- **Security Requirements:** [Security standards and compliance needs]
- **Performance Standards:** [System performance and reliability requirements]

---

## Risk Management and Contingency Planning

*Implementation always involves risk. The key is managing risk proactively rather than reactively.*

### Implementation Risk Assessment

**Strategic Implementation Risks**

| Risk Category | Risk Description | Probability | Impact | Risk Score | Mitigation Strategy | Contingency Plan |
|---------------|------------------|-------------|---------|------------|-------------------|------------------|
| [Risk 1] | [Detailed description] | [H/M/L] | [H/M/L] | [Score] | [Prevention approach] | [Response plan] |
| [Risk 2] | [Same format] | [H/M/L] | [H/M/L] | [Score] | [Prevention approach] | [Response plan] |

### Risk Mitigation Strategies

**High-Priority Risk Mitigation**
[Detailed strategies for preventing or minimizing the impact of highest-priority risks]

**Risk Monitoring and Early Warning**
[How to identify risks before they become problems. What indicators to watch for.]

### Contingency Planning

**Schedule Contingencies**
- **Delay Scenarios:** [What happens if implementation falls behind schedule]
- **Acceleration Options:** [How to speed up implementation if needed]
- **Alternative Approaches:** [Backup implementation strategies]

**Resource Contingencies**
- **Budget Overruns:** [How to handle cost increases]
- **Resource Shortages:** [Alternative sources of critical resources]
- **Skill Gaps:** [How to address unexpected skill needs]

**Technical Contingencies**
- **Technology Failures:** [Backup plans for technology problems]
- **Integration Issues:** [Alternative approaches if integrations fail]
- **Performance Problems:** [Solutions for system performance issues]

---

## Success Measurement and Quality Assurance

*You can't manage what you don't measure. Here's how to track implementation success and ensure quality outcomes.*

### Implementation Success Metrics

**Strategic Success Indicators**
| Metric | Baseline | Target | Measurement Method | Frequency | Owner |
|--------|----------|--------|-------------------|-----------|-------|
| [Strategic KPI 1] | [Current] | [Goal] | [How measured] | [When] | [Role] |
| [Strategic KPI 2] | [Current] | [Goal] | [How measured] | [When] | [Role] |

**Operational Success Indicators**
[Metrics that track implementation progress and operational effectiveness]

**Quality Assurance Measures**
[How to ensure implementation deliverables meet quality standards]

### Implementation Monitoring and Review

**Daily Implementation Monitoring**
[What to track daily to ensure implementation stays on track]

**Weekly Progress Reviews**
- **Review Focus:** [What gets assessed weekly]
- **Participants:** [Who participates in weekly reviews]
- **Decision Authority:** [Who can make course corrections]

**Monthly Strategic Reviews**
- **Strategic Assessment:** [How to evaluate strategic progress]
- **Stakeholder Communication:** [How to update key stakeholders]
- **Course Correction Process:** [How to adjust implementation approach]

**Quarterly Implementation Assessments**
[Comprehensive review of implementation progress and strategic alignment]

### Quality Gates and Approval Processes

**Phase Gate Reviews**
[How each phase is evaluated before moving to the next phase]

**Quality Standards**
[Specific quality criteria that must be met throughout implementation]

**Approval Processes**
[Who approves what and when during implementation]

---

## Budget Management and Financial Control

*Implementation success requires disciplined financial management and clear ROI tracking.*

### Total Implementation Investment

**Implementation Budget Breakdown**

| Category | Phase 1 | Phase 2 | Phase 3 | Total | ROI Impact |
|----------|---------|---------|---------|-------|------------|
| Personnel | [Amount] | [Amount] | [Amount] | [Total] | [Benefit] |
| Technology | [Amount] | [Amount] | [Amount] | [Total] | [Benefit] |
| External Services | [Amount] | [Amount] | [Amount] | [Total] | [Benefit] |
| Training & Development | [Amount] | [Amount] | [Amount] | [Total] | [Benefit] |
| Infrastructure | [Amount] | [Amount] | [Amount] | [Total] | [Benefit] |
| **Total Investment** | **[Phase Total]** | **[Phase Total]** | **[Phase Total]** | **[Grand Total]** | **[Total ROI]** |

### Financial Management Approach
[How to manage implementation budget and control costs throughout execution]

### ROI Tracking and Validation
- **ROI Calculation Method:** [How ROI will be calculated and validated]
- **Benefit Realization Timeline:** [When benefits will be realized]
- **ROI Monitoring:** [How to track ROI throughout implementation]

### Financial Risk Management
[How to manage budget risks and cost overruns]

---

## Change Management and Adoption Strategy

*Technical implementation is often easier than organizational adoption. Here's how to ensure people embrace the change.*

### Change Management Strategy

**Change Readiness Assessment**
[Evaluate organizational readiness for change and identify potential resistance points]

**Change Communication Strategy**
- **Communication Objectives:** [What change communications must accomplish]
- **Message Framework:** [Key messages for different stakeholder groups]
- **Communication Channels:** [How to reach different audiences effectively]
- **Communication Timeline:** [When key messages will be delivered]

### Adoption Strategy

**User Adoption Approach**
[How to ensure end users successfully adopt new approaches, systems, or processes]

**Adoption Success Metrics**
[How to measure whether people are successfully adopting changes]

**Resistance Management**
[How to identify and address resistance to change]

### Training and Support Strategy

**Training Program Design**
[Comprehensive approach to preparing people for change]

**Ongoing Support Model**
[How to provide continued support after initial training]

**Knowledge Transfer Strategy**
[How to ensure critical knowledge is retained in the organization]

---

## Implementation Success: Sustainable Results

*Implementation success isn't just about completing the project—it's about achieving sustainable business results.*

### Sustainable Success Factors
[What needs to happen to ensure implementation benefits are sustained over time]

### Long-term Success Monitoring
[How to track implementation success after the formal implementation period ends]

### Continuous Improvement Strategy
[How to continue improving and optimizing after initial implementation]

### Knowledge Retention and Transfer
[How to ensure implementation knowledge is retained even as team members change]

---

## Implementation Conclusion: Your Success Roadmap

*Successful implementation requires discipline, persistence, and continuous focus on strategic objectives.*

### Implementation Success Summary
[What successful implementation will accomplish and how it creates sustainable competitive advantage]

### Critical Implementation Success Factors
[The most important things that must happen for implementation to succeed]

### Your Implementation Journey
[Final guidance on executing successful implementation]

---

*Implementation Guide prepared by: Strategic Implementation Team*  
*Guide Date: [Current Date]*  
*Implementation Review Cycle: Weekly during implementation, Monthly post-implementation*  
*Classification: Implementation Planning - Team Distribution*  
*Investment Level: Premium Implementation Strategy ($100K+ Consulting Grade)*

---

**CRITICAL INSTRUCTIONS FOR PREMIUM IMPLEMENTATION QUALITY:**

1. **Implementation Realism**: Base all recommendations on proven implementation methodologies. Address real implementation challenges, not theoretical ones.

2. **Change Management Focus**: Implementation is as much about people as it is about process. Address organizational adoption and change management thoroughly.

3. **Risk Management**: Implementation always involves risk. Provide specific, actionable risk mitigation strategies.

4. **Measurement and Control**: Include detailed approaches for tracking implementation progress and ensuring quality outcomes.

5. **Resource Planning**: Provide realistic resource requirements and budget planning. Implementation failure often comes from under-resourcing.

6. **Stakeholder Engagement**: Success depends on stakeholder engagement. Provide detailed strategies for maintaining support throughout implementation.

7. **Sustainability Focus**: Implementation success must be sustainable. Address how to maintain benefits after the implementation team disbands.

8. **Premium Quality**: This is $100K+ implementation guidance—demonstrate deep implementation expertise and practical experience.

9. **Action Orientation**: Every section should provide specific, actionable guidance for implementation success.

10. **Strategic Connection**: Always connect implementation activities to strategic objectives. Implementation serves strategy, not the other way around.
EOF
            ;;
        *)
            echo "❌ Error: Unknown document type '$doc_type'"
            echo "Available types: strategic_analysis, executive_briefing, market_intelligence, implementation_guide"
            exit 1
            ;;
    esac
}

# Collect all project data for analysis (same approach as enterprise script)
echo "📚 Collecting comprehensive project data..."
PROJECT_DATA_FILE=$(mktemp)

# Combine all research data
{
    echo "=== PREMIUM PROJECT RESEARCH DATA ==="
    echo "Project: $PROJECT_FOLDER"
    echo "Premium Analysis Level: $100K+ Consulting Grade"
    echo "Generated: $(date)"
    echo ""
    
    # Include all research phases
    for folder in "01_searches" "02_fetched_content" "03_extracted_data" "04_analysis" "05_synthesis" "FINAL_REPORTS"; do
        if [ -d "$PROJECT_FOLDER/$folder" ]; then
            echo "=== $(echo "$folder" | tr '[:lower:]' '[:upper:]') ==="
            find "$PROJECT_FOLDER/$folder" -type f \( -name "*.md" -o -name "*.json" \) -print0 | while IFS= read -r -d '' file; do
                echo "--- FILE: $file ---"
                cat "$file"
                echo ""
            done
        fi
    done
    
} > "$PROJECT_DATA_FILE"

PROJECT_DATA=$(cat "$PROJECT_DATA_FILE")
rm "$PROJECT_DATA_FILE"

echo "📝 Generating premium enterprise document prompt..."

# Generate the comprehensive premium prompt
PREMIUM_PROMPT="$(generate_premium_enterprise_prompt "$DOCUMENT_TYPE" "$PROJECT_DATA")

COMPREHENSIVE RESEARCH DATA FOR ANALYSIS:
$PROJECT_DATA

PREMIUM QUALITY INSTRUCTIONS:
- This is a $100K+ premium consulting document
- Write with hybrid formal-conversational tone suitable for C-level executives
- Expand on all insights with detailed explanations of strategic significance
- Include specific statistics and quotes from research with strategic context
- Explain the 'why' behind every finding and the 'so what' for strategic decision-making
- Use authoritative consulting language while remaining accessible
- Focus on actionable insights that drive competitive advantage
- Address implementation realities and change management needs
- Connect all analysis to sustainable business value creation"

# Create output file path
OUTPUT_FILE="$PROJECT_FOLDER/05_synthesis/${OUTPUT_NAME}_Premium.md"

echo "🔄 Generating premium enterprise document with Claude..."

# Generate the premium document
echo "$PREMIUM_PROMPT" | claude > "$OUTPUT_FILE"

echo "✅ Premium enterprise document created: $OUTPUT_FILE"

# Generate PDF version using the document creation script
echo "📄 Creating premium PDF version..."
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -f "$SCRIPT_DIR/create-document.sh" ] && [ -x "$SCRIPT_DIR/create-document.sh" ]; then
    "$SCRIPT_DIR/create-document.sh" "$OUTPUT_FILE"
    echo "✅ Premium PDF version created: ${OUTPUT_FILE%.md}.pdf"
else
    echo "⚠️  PDF generation skipped (create-document.sh not available)"
fi

echo ""
echo "🎉 Premium Enterprise Document Generation Complete!"
echo "📁 Document: $OUTPUT_FILE"
echo "📋 Type: $DOCUMENT_TYPE"
echo "💎 Quality Level: $100K+ Premium Consulting Report"
echo "✨ Features: Hybrid formal-conversational tone, expanded insights, strategic depth"
echo "🎯 Target Audience: C-level executives requiring comprehensive strategic intelligence"