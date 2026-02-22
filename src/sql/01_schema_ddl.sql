-- RAW PROSPECTS TABLE
CREATE TABLE raw.prospects_raw (
    prospect_id SERIAL PRIMARY KEY,
    age INT,
    annual_income NUMERIC(15,2),
    occupation TEXT,
    city_tier INT,
    credit_score INT,
    digital_score INT,
    campaign_channel TEXT,
    acquisition_cost NUMERIC(10,2),
    converted BOOLEAN
);

-- CUSTOMERS TABLE
CREATE TABLE analytics.customers (
    customer_id SERIAL PRIMARY KEY,
    prospect_id INT REFERENCES raw.prospects_raw(prospect_id),
    onboarding_date DATE
);

-- FINANCIALS TABLE
CREATE TABLE analytics.financials (
    customer_id INT REFERENCES analytics.customers(customer_id),
    savings_balance NUMERIC(15,2),
    fixed_deposits NUMERIC(15,2),
    investments NUMERIC(15,2),
    insurance_aum NUMERIC(15,2),
    demat_holdings NUMERIC(15,2),
    total_trb NUMERIC(15,2)
);

-- MARKETING SPEND TABLE
CREATE TABLE analytics.marketing_spend (
    campaign_channel TEXT PRIMARY KEY,
    total_spend NUMERIC(15,2),
    total_leads INT
);

-- INDEXES
CREATE INDEX idx_income ON raw.prospects_raw(annual_income);
CREATE INDEX idx_credit ON raw.prospects_raw(credit_score);
CREATE INDEX idx_channel ON raw.prospects_raw(campaign_channel);
CREATE INDEX idx_trb ON analytics.financials(total_trb);