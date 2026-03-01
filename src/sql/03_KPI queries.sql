-- ================================
-- Affluent Conversion Rate
-- ================================

SELECT 
    COUNT(*) AS total_customers,
    SUM(target_affluent) AS affluent_customers,
    ROUND(SUM(target_affluent)::numeric / COUNT(*), 4) AS affluent_conversion_rate
FROM mart.customer_analytics_base;

-- ================================
-- CAC & CPAA
-- ================================

WITH base AS (
    SELECT * FROM mart.customer_analytics_base
)

SELECT
    SUM(acquisition_cost) / COUNT(*) AS CAC,
    SUM(acquisition_cost) / SUM(target_affluent) AS CPAA
FROM base;

-- ================================
-- Income Segmentation
-- ================================

SELECT
    CASE 
        WHEN annual_income < 800000 THEN 'Low Income'
        WHEN annual_income BETWEEN 800000 AND 1500000 THEN 'Mid Income'
        ELSE 'High Income'
    END AS income_segment,
    
    COUNT(*) AS customers,
    SUM(target_affluent) AS affluent_customers,
    ROUND(AVG(total_trb),0) AS avg_trb

FROM mart.customer_analytics_base
GROUP BY 1
ORDER BY avg_trb DESC;

-- ================================
-- Channel Performance
-- ================================

SELECT
    campaign_channel,
    COUNT(*) AS customers,
    SUM(target_affluent) AS affluent_customers,
    ROUND(SUM(target_affluent)::numeric / COUNT(*), 4) AS affluent_rate,
    SUM(acquisition_cost) AS total_spend
FROM mart.customer_analytics_base
GROUP BY campaign_channel
ORDER BY affluent_rate DESC;

-- ================================
-- Cohort Analysis
-- ================================

SELECT
    DATE_TRUNC('month', onboarding_date) AS cohort_month,
    COUNT(*) AS customers,
    SUM(target_affluent) AS affluent_customers,
    ROUND(AVG(total_trb),0) AS avg_trb
FROM mart.customer_analytics_base
GROUP BY 1
ORDER BY 1;