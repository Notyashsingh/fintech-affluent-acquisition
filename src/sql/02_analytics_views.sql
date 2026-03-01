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