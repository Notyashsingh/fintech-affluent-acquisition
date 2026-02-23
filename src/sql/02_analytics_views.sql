-- ================================
-- Analytical Base View
-- ================================

CREATE OR REPLACE VIEW mart.customer_analytics_base AS
SELECT
    c.customer_id,
    c.onboarding_date,
    p.age,
    p.annual_income,
    p.occupation,
    p.city_tier,
    p.credit_score,
    p.digital_score,
    p.campaign_channel,
    p.acquisition_cost,
    f.savings_balance,
    f.fixed_deposits,
    f.investments,
    f.insurance_aum,
    f.demat_holdings,
    f.total_trb,
    
    CASE 
        WHEN f.total_trb >= 4000000 THEN 1
        ELSE 0
    END AS target_affluent

FROM analytics.customers c
JOIN raw.prospects_raw p
    ON c.prospect_id = p.prospect_id
JOIN analytics.financials f
    ON c.customer_id = f.customer_id;

-- Quick check on the number of records in the base view

SELECT COUNT(*) FROM mart.customer_analytics_base;

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