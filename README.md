# 💰 Fintech Marketing Budget Reallocation Simulation

> **Channel-Level Unit Economics | ROI Analysis | Scenario Modeling | Sensitivity Testing**

---

## 📌 Business Problem

> Which marketing channel is most efficient at acquiring affluent customers, and how should we reallocate budget to maximize affluent TRB (Total Relationship Balance)?

This is a classic **marketing efficiency & resource allocation challenge** — using data-driven unit economics to shift spend toward the highest-performing acquisition channels.

---

## 🎯 Objectives

| # | Objective |
|---|-----------|
| 1 | 🔍 Identify the most efficient affluent customer acquisition channel |
| 2 | 📊 Quantify channel-level ROI metrics (CPAA, ROAS) |
| 3 | 💡 Simulate budget reallocation scenarios |
| 4 | 📈 Measure incremental affluent TRB impact |
| 5 | ✅ Deliver a defensible business recommendation |

---

## 🧠 Analytical Framework

The project is structured as a three-layer analytical pipeline:

```
Raw Data → KPI & Unit Economics → Budget Simulation → Sensitivity Analysis → Recommendation
```

---

### 1️⃣ KPI & Unit Economics Layer

> **Files:** `src/sql/03_KPI_queries.sql` | `src/sql/04_channel_roi_summary.sql`

#### Channel Efficiency Snapshot

```
Referral  ─────────────── CPAA: 22,248 | ROAS: 216 🏆
Digital   ─────────────── CPAA: 22,949 | ROAS: 208
Branch    ─────────────── CPAA: 23,272 | ROAS: 205
RM        ─────────────── CPAA: 23,507 | ROAS: 204
```

#### Channel ROI Metrics Table

| Channel | Total Customers | Affluent Customers | CPAA (₹) | ROAS (Affluent) | Rank |
|---|---|---|---|---|---|
| Referral | 4599 | 619 | 22,248 | 216 | 🥇 1st |
| Digital Ads | 12660 | 1652 | 22,949 | 208 | 🥈 2nd |
| Branch | 7774 | 1002 | 23,272 | 205 | 🥉 3rd |
| RM | 6204 | 795 | 23,507 | 204 | 4th |

> **Key Insight:** Referral channel delivers the lowest cost-per-affluent-acquisition (CPAA) and highest return on ad spend (ROAS), making it the optimal target for budget reallocation.

---

### 2️⃣ Budget Reallocation Simulation

> **File:** `src/sql/05_budget_simulation.sql`

#### Model Assumptions

| Assumption | Status |
|---|---|
| Stable conversion rates | ✅ Applied |
| Constant CPAA per channel | ✅ Applied |
| Proportional ROAS scaling | ✅ Applied |
| Diminishing returns modeled | ❌ Not modeled |
| Cannibalization effects | ❌ Not modeled |

#### Simulation Result

```
Baseline Budget Allocation  →  Optimized Allocation (↑ Referral) →  +44.2M Incremental Affluent TRB
                                        
```

---

### 3️⃣ Sensitivity Analysis

> **File:** `src/sql/07_sensitivity_analysis.sql`

Measures the TRB uplift from progressively shifting budget toward the Referral channel.

| Budget Shift → Referral | New TRB | Incremental Gain | % Gain |
|---|---|---|---|
| 5% | 19.70B | +187M | +0.96% |
| 10% | 19.88B | +374M | +1.92% |
| 20% | 20.26B | +748M | +3.83% |
| 30% | 20.63B | +1.12B | +5.75% |

> A **10–20% reallocation** offers the best balance of impact and implementation risk.

---

## 🏆 Executive Recommendation

```
💡 ACTION: Reallocate 10–20% of marketing budget → Referral

📊 IMPACT:                                                      
    • 374M – 748M TRB uplift                                     
    • 2% – 3.8% total TRB growth                                 
    • Low implementation risk

✅ WHY FEASIBLE:                                                
     Politically neutral, fully data-backed, immediate impact
```

---

## 📈 Key Results Summary

| Metric | Baseline | Optimized (20% Shift to Referral) | Impact |
|--------|----------|-----------------------------------|--------|
| Affluent TRB | 19.51B | 20.26B | **+748M Incremental** |
| TRB Growth | 0% (Reference Scenario) | 3.83% | **+3.83% Portfolio Lift** |
| Highest Efficiency Channel | Referral (Best ROAS & Lowest CPAA) | Referral (Scaled Allocation) | Efficiency Advantage Maintained |
| Budget Allocation Strategy | Historical Distribution | 20% Reweighted Toward Referral | Strategic Reallocation |
| Implementation Risk | Stable Current Mix | Controlled Moderate Shift | ✅ Low |

---

## 📊 Dashboard

This project includes a presentation-ready executive dashboard summarizing:

- Channel-level CPAA & ROAS  
- Affluent TRB performance  
- Budget reallocation scenario impact  
- Sensitivity analysis results  

<img width="2000" height="1221" alt="image" src="https://github.com/user-attachments/assets/6fd6c91b-5f92-4dc0-aff7-aa0ff1c19823" />


## 🧩 Skills Demonstrated

| Domain | Skill |
|---|---|
| Analytics | Marketing Channel Efficiency Analysis |
| Finance | ROI & Unit Economics (CPAA, ROAS) |
| Modeling | Deterministic Scenario Modeling |
| Testing | Multi-level Sensitivity Testing |
| Communication | Executive-ready Recommendations |

---

## 📁 Repository Structure

```
fintech-affluent-acquisition/
│
├── 📂 src/sql/
│   ├── 01_schema_ddl.sql              # Schema structure & table definitions
│   ├── 02_analytics_views.sql         # Reusable analytics views
│   ├── 03_KPI_queries.sql             # Core performance metrics
│   ├── 04_channel_roi_summary.sql     # Channel-level ROI aggregation
│   ├── 05_budget_simulation.sql       # Budget reallocation model
│   ├── 06_scenario_comparison.sql     # Scenario output comparisons
│   └── 07_sensitivity_analysis.sql    # Sensitivity tests
│
├── 📊 dashboards/                     # Power BI dashboard files (.pbix)
│
├── 📝 reports/                        # Output reports & presentations
│
└── 🗂️ Data/                           # Raw and Processed Data
    ├──Raw/
    ├──Processed/
```

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Data Storage | PostgreSQL / SQL |
| Analytics | SQL (DDL, Views, Aggregations) |
| Simulation | SQL-based deterministic modeling |
| Visualization | Power BI |
| Scripting | Python |

---

## 🚀 Getting Started

### Prerequisites
- PostgreSQL installed and running
- Power BI Desktop (for dashboards)
- Python 3.x (for analysis scripts)

### Installation & Setup

```bash
# 1. Clone the repository
git clone https://github.com/yourusername/fintech-budget-sim.git
cd fintech-budget-sim

# 2. Run the SQL pipeline in sequence
psql -f src/sql/01_schema_ddl.sql
psql -f src/sql/02_analytics_views.sql
psql -f src/sql/03_KPI_queries.sql
psql -f src/sql/04_channel_roi_summary.sql
psql -f src/sql/05_budget_simulation.sql
psql -f src/sql/06_scenario_comparison.sql
psql -f src/sql/07_sensitivity_analysis.sql

# 3. Open Power BI dashboards
# Launch Power BI Desktop and open files from:
# dashboards/reports/*.pbix
```

---

## 📄 License

This project is for portfolio and educational purposes.

---

*Built to demonstrate data-driven marketing budget optimization using SQL-based unit economics and scenario modeling.*
