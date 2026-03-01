-- ======================================
-- Channel ROI Summary Table
-- ======================================

CREATE TABLE IF NOT EXISTS mart.channel_roi_summary AS
SELECT
    campaign_channel,

    COUNT(*) AS total_customers,

    SUM(target_affluent) AS affluent_customers,

    ROUND(
        SUM(target_affluent)::numeric / COUNT(*), 
        4
    ) AS affluent_rate,

    SUM(acquisition_cost) AS total_spend,

    SUM(total_trb) AS total_trb,

    SUM(
        CASE 
            WHEN target_affluent = 1 
            THEN total_trb 
            ELSE 0 
        END
    ) AS affluent_trb,

    ROUND(
        SUM(acquisition_cost) 
        / NULLIF(SUM(target_affluent),0),
        2
    ) AS cpaa,

    ROUND(
        SUM(
            CASE WHEN target_affluent = 1 
            THEN total_trb ELSE 0 END
        )
        / NULLIF(SUM(acquisition_cost),0),
        4
    ) AS roas_affluent

FROM mart.customer_analytics_base
GROUP BY campaign_channel;

-- Quick check on the channel ROI summary

SELECT * 
FROM mart.channel_roi_summary
ORDER BY roas_affluent DESC;