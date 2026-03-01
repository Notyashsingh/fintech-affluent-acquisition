-- =====================================
-- Scenario Comparison: Baseline vs Optimized
-- =====================================

CREATE TABLE IF NOT EXISTS mart.scenario_comparison AS

WITH baseline AS (
    SELECT 
        'Baseline' AS scenario,
        SUM(affluent_trb) AS total_affluent_trb
    FROM mart.channel_roi_summary
),

optimized AS (
    SELECT
        'Optimized_Reallocation' AS scenario,
        SUM(projected_affluent_trb) AS total_affluent_trb
    FROM mart.budget_simulation
)

SELECT * FROM baseline
UNION ALL
SELECT * FROM optimized;


-- Check the scenario comparison results

SELECT *,
       total_affluent_trb - 
       LAG(total_affluent_trb) OVER (ORDER BY total_affluent_trb)
       AS incremental_gain
FROM mart.scenario_comparison;