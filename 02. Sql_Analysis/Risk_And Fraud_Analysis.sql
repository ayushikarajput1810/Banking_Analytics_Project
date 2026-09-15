-- ============================================
-- RISK ANALYSIS
-- ============================================

-- Customers by Credit Risk Category

SELECT
    CASE
        WHEN credit_score >= 750 THEN 'Excellent'
        WHEN credit_score >= 650 THEN 'Good'
        ELSE 'Poor'
    END AS credit_risk_category,
    COUNT(*) AS total_customers
FROM customers
GROUP BY
    CASE
        WHEN credit_score >= 750 THEN 'Excellent'
        WHEN credit_score >= 650 THEN 'Good'
        ELSE 'Poor'
    END
ORDER BY total_customers DESC;

-- High-Risk Customer Identification 
--(Low Credit Score, High Loan and Late Payment)

select * from loan_payments
SELECT
    c.customer_id,
    c.occupation,
    c.credit_score,
    SUM(l.loan_amount) AS total_loan_amount,
    COUNT(DISTINCT l.loan_id) AS total_loans,
    COUNT(lp.payment_id) AS late_payments
FROM customers AS c
JOIN loans AS l
    ON c.customer_id = l.customer_id
JOIN loan_payments AS lp
    ON l.loan_id = lp.loan_id
WHERE c.credit_score < 650
  AND lp.late_payment_flag = 1
GROUP BY
    c.customer_id,
    c.occupation,
    c.credit_score
HAVING SUM(l.loan_amount) > (
    SELECT AVG(loan_amount)
    FROM loans)
ORDER BY
    c.credit_score ASC,
    total_loan_amount DESC;

-- Customers who are likely to default

SELECT
    c.customer_id,
    c.credit_score,
    SUM(l.loan_amount) AS total_loan_amount,
    COUNT(DISTINCT l.loan_id) AS total_loans,
    COUNT(DISTINCT CASE
        WHEN lp.late_payment_flag = 1 THEN lp.payment_id
    END) AS late_payments
FROM customers AS c
JOIN loans AS l
    ON c.customer_id = l.customer_id
JOIN loan_payments AS lp
    ON l.loan_id = lp.loan_id
WHERE c.credit_score < 650
  AND lp.late_payment_flag = 1
GROUP BY
    c.customer_id,
    c.credit_score
HAVING SUM(l.loan_amount) > (
    SELECT AVG(loan_amount)
    FROM loans
)
ORDER BY total_loan_amount DESC;

-- Loan Recovery Rate 

;WITH LoanTotal AS (
    SELECT 
        SUM(loan_amount) AS total_loan_amount
    FROM loans),
PaymentTotal AS (
    SELECT 
        SUM(amount_paid) AS total_amount_recovered
    FROM loan_payments
)
SELECT
    l.total_loan_amount,
    p.total_amount_recovered,
    ROUND(
        (p.total_amount_recovered * 100.0) / NULLIF(l.total_loan_amount, 0), 2
    ) AS loan_recovery_rate
FROM LoanTotal AS l
CROSS JOIN PaymentTotal AS p;

