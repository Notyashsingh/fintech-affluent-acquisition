--====================================
-- Multi-Level Reallocation Sensitivity
--====================================

WITH base AS (
    SELECT
        campaign_channel,
        total_spend,
        affluent_trb,
        roas_affluent
    FROM mart.channel_roi_summary
),

total_spend_calc AS (
    SELECT SUM(total_spend) AS total_spend_all
    FROM base
),

scenarios AS (
    SELECT 0.05 AS shift_pct UNION ALL
    SELECT 0.10 UNION ALL
    SELECT 0.20 UNION ALL
    SELECT 0.30
),

reallocation AS (
    SELECT
        s.shift_pct,
        b.campaign_channel,
        CASE
            WHEN b.campaign_channel = 'Referral'
                THEN b.total_spend + (t.total_spend_all * s.shift_pct)
            ELSE
                b.total_spend - 
                (b.total_spend / t.total_spend_all) * (t.total_spend_all * s.shift_pct)
        END AS new_spend,
        b.roas_affluent
    FROM base b
    CROSS JOIN total_spend_calc t
    CROSS JOIN scenarios s
),

new_trb_calc AS (
    SELECT
        shift_pct,
        SUM(new_spend * roas_affluent) AS new_affluent_trb
    FROM reallocation
    GROUP BY shift_pct
),

current_trb AS (
    SELECT SUM(affluent_trb) AS current_affluent_trb
    FROM base
)

SELECT
    shift_pct * 100 AS shift_to_referral_pct,
    c.current_affluent_trb,
    n.new_affluent_trb,
    n.new_affluent_trb - c.current_affluent_trb AS incremental_gain,
    ROUND(
        (n.new_affluent_trb - c.current_affluent_trb)
        / c.current_affluent_trb * 100, 2
    ) AS pct_gain
FROM new_trb_calc n
CROSS JOIN current_trb c
ORDER BY shift_to_referral_pct;


-- Create a view for easy access to the sensitivity analysis results

CREATE OR REPLACE VIEW mart.sensitivity_analysis AS
WITH base AS (
    SELECT
        campaign_channel,
        total_spend,
        affluent_trb,
        roas_affluent
    FROM mart.channel_roi_summary
),

total_spend_calc AS (
    SELECT SUM(total_spend) AS total_spend_all
    FROM base
),

scenarios AS (
    SELECT 0.05 AS shift_pct UNION ALL
    SELECT 0.10 UNION ALL
    SELECT 0.20 UNION ALL
    SELECT 0.30
),

reallocation AS (
    SELECT
        s.shift_pct,
        b.campaign_channel,
        CASE
            WHEN b.campaign_channel = 'Referral'
                THEN b.total_spend + (t.total_spend_all * s.shift_pct)
            ELSE
                b.total_spend - 
                (b.total_spend / t.total_spend_all) * (t.total_spend_all * s.shift_pct)
        END AS new_spend,
        b.roas_affluent
    FROM base b
    CROSS JOIN total_spend_calc t
    CROSS JOIN scenarios s
),

new_trb_calc AS (
    SELECT
        shift_pct,
        ROUND(SUM(new_spend * roas_affluent), 2) AS new_affluent_trb
    FROM reallocation
    GROUP BY shift_pct
),

current_trb AS (
    SELECT SUM(affluent_trb) AS current_affluent_trb
    FROM base
)

SELECT
    shift_pct * 100 AS shift_to_referral_pct,
    c.current_affluent_trb,
    n.new_affluent_trb,
    ROUND(n.new_affluent_trb - c.current_affluent_trb, 2) AS incremental_gain,
    ROUND(
        (n.new_affluent_trb - c.current_affluent_trb)
        / c.current_affluent_trb * 100, 2
    ) AS pct_gain
FROM new_trb_calc n
CROSS JOIN current_trb c
ORDER BY shift_to_referral_pct
;