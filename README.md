💰 Fintech Marketing Budget Reallocation Simulation
Channel-Level Unit Economics | ROI Analysis | Scenario Modeling | Sensitivity Testing

📌 Business Problem
Which marketing channel is most efficient at acquiring affluent customers, and how should we reallocate budget to maximize affluent TRB (Total Relationship Balance)?

Classic marketing efficiency & resource allocation challenge

🎯 Objectives
🔍 Identify most efficient affluent acquisition channel

📊 Quantify channel-level ROI metrics

💡 Simulate budget reallocation scenarios

📈 Measure incremental affluent TRB impact

✅ Deliver defensible business recommendation

🧠 Analytical Framework
1️⃣ KPI & Unit Economics Layer
Files: src/sql/03_KPI_queries.sql | src/sql/04_channel_roi_summary.sql

Channel Efficiency Snapshot:

text
graph TD
    Referral[Referral<br/>CPAA: 22,248<br/>ROAS: 216]
    Digital[Digital Ads<br/>CPAA: 22,949<br/>ROAS: 208]
    Branch[Branch<br/>CPAA: 23,272<br/>ROAS: 205]
    RM[RM<br/>CPAA: 23,507<br/>ROAS: 204]
    
    Referral -->|Strongest| A[🏆 Recommendation]
Key Metrics Table:

Channel	Total Customers	Affluent Customers	CPAA	ROAS (Affluent)
Referral	-	-	22,248	216 🔝
Digital Ads	-	-	22,949	208
Branch	-	-	23,272	205
RM	-	-	23,507	204
2️⃣ Budget Reallocation Simulation
File: src/sql/05_budget_simulation.sql

Linear Reallocation Model Assumptions:

✅ Stable conversion rates

✅ Constant CPAA

✅ Proportional ROAS

❌ No diminishing returns

❌ No cannibalization

Result: +44.2M incremental affluent TRB

3️⃣ Sensitivity Analysis
File: src/sql/07_sensitivity_analysis.sql

% Shift → Referral	New TRB	Incremental Gain	% Gain
5%	19.70B	+187M	+0.96%
10%	19.88B	+374M	+1.92%
20%	20.26B	+748M	+3.83%
30%	20.63B	+1.12B	+5.75%
🏆 Executive Recommendation
text
💡 ACTION: Reallocate 10-20% budget to Referral channel

📊 IMPACT:
• 374M–748M TRB uplift
• 2–3.8% total TRB growth
• Low implementation risk

✅ Why feasible: Politically neutral, data-backed, immediate impact
🧩 Skills Demonstrated
✅ Marketing Channel Efficiency Analysis

✅ ROI & Unit Economics

✅ Deterministic Scenario Modeling

✅ Multi-level Sensitivity Testing

✅ Executive Communication

📁 Repository Structure

💾 src/sql/
├── 01_schema_ddl.sql               # Schema Structure
├── 02_analytics_views.sql          # Analytics View
├── 03_KPI_queries.sql              # Core metrics
├── 04_channel_roi_summary.sql      # Channel aggregation
├── 05_budget_simulation.sql        # Reallocation model
├── 06_scenario_comparison.sql      # Scenario outputs
└── 07_sensitivity_analysis.sql     # Sensitivity tests
|
📊 dashboards/                     # Power BI dashboards
|
📝 reports/                       

🐍 python/                          # Analysis scripts
🛠️ Tech Stack
🚀 Getting Started
bash
# 1. Clone repository
git clone https://github.com/yourusername/fintech-budget-sim.git

# 2. Run SQL pipeline (sequence matters)
psql -f src/sql/01_schema_ddl.sql
psql -f src/sql/02_analytics_views.sql
psql -f src/sql/03_KPI_queries.sql
psql -f src/sql/04_channel_roi_summary.sql
# ... continue through 07_sensitivity_analysis.sql

# 3. Open Power BI dashboards
dashboards/reports/*.pbix
📈 Key Results Summary
Metric	Baseline	Optimized	Uplift
Affluent TRB	19.51B	20.26B	+748M
Channel Efficiency	Mixed	Referral	+3.83%
Implementation Risk	-	Low	✅
