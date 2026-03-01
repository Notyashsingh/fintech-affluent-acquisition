-- Populate marketing_spend with channel ROI summary data
TRUNCATE TABLE analytics.marketing_spend;

INSERT INTO analytics.marketing_spend (campaign_channel, total_spend, total_leads)
SELECT
    campaign_channel,
    total_spend,
    total_customers
FROM mart.channel_roi_summary;

-- ================================
-- Create Simulation Table
-- ================================

-- Move 20% of RM spend → Referral.

CREATE TABLE IF NOT EXISTS mart.budget_simulation AS
WITH base AS (
    SELECT * FROM mart.channel_roi_summary
),

adjusted AS (
    SELECT
        campaign_channel,
        total_spend,
        roas_affluent,

        CASE
            WHEN campaign_channel = 'Relationship Manager'
                THEN total_spend * 0.80
            WHEN campaign_channel = 'Referral'
                THEN total_spend + (
                    SELECT total_spend * 0.20
                    FROM base
                    WHERE campaign_channel = 'Relationship Manager'
                )
            ELSE total_spend
        END AS new_spend

    FROM base
)

SELECT
    campaign_channel,
    total_spend AS old_spend,
    new_spend,

    roas_affluent,

    new_spend * roas_affluent AS projected_affluent_trb

FROM adjusted;

-- Check the new total affluent TRB under the simulation

SELECT 
    SUM(projected_affluent_trb) AS new_total_affluent_trb
FROM mart.budget_simulation;

-- Check the current total affluent TRB for comparison

SELECT 
    SUM(affluent_trb) AS current_total_affluent_trb
FROM mart.channel_roi_summary;

--====================================
-- Incremental Gain from Simulation
--====================================

-- Incremental Gain = new_total_affluent_trb - current_total_affluent_trb

-- 19555124532.89898600 - 19510915947.83 = 44208585.06898600