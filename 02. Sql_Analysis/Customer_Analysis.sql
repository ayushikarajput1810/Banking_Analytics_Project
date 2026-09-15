-- ============================================
-- 02_Customer_Analysis.sql
-- Customer Demographic & Financial Analysis
-- ============================================
select * from accounts
-- Top 10 customers by account balance
SELECT TOP 10
    customer_id,
    SUM(balance) AS total_balance
FROM accounts
GROUP BY customer_id
ORDER BY total_balance DESC;

-- States with the most customers
SELECT 
    state,
    COUNT(*) AS total_customers
FROM customers
GROUP BY state
ORDER BY total_customers DESC;

-- Average annual income by occupation
SELECT 
    occupation,
    ROUND(AVG(annual_income), 2) AS avg_annual_income
FROM customers
GROUP BY occupation
ORDER BY avg_annual_income DESC;


-- Occupation with the highest average income
SELECT Top 1
    occupation,
    ROUND(AVG(annual_income), 2) AS avg_annual_income
FROM customers
GROUP BY occupation
ORDER BY avg_annual_income DESC;


-- Average credit score by occupation
SELECT 
    occupation,
    ROUND(AVG(credit_score), 2) AS avg_credit_score
FROM customers
GROUP BY occupation
ORDER BY avg_credit_score DESC;


-- Customers by credit score category
SELECT
    CASE
        WHEN credit_score >= 750 THEN 'Excellent'
        WHEN credit_score >= 650 THEN 'Good'
        ELSE 'Poor'
    END AS credit_category,
    COUNT(*) AS total_customers
FROM customers
GROUP BY
    CASE
        WHEN credit_score >= 750 THEN 'Excellent'
        WHEN credit_score >= 650 THEN 'Good'
        ELSE 'Poor'
    END
ORDER BY total_customers DESC;