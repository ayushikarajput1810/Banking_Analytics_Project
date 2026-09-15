-- ============================================
-- 05_Loan_Analysis.sql
-- Loan Portfolio & Repayment Analysis
-- ============================================
SELECT * FROM loan_payments
SELECT * FROM branches
SELECT * FROM loans

-- 1. How many loans have been issued in total?
SELECT 
    COUNT(*) AS total_loans
FROM loans;

-- 2. What are the minimum and maximum loan amounts?
SELECT 
    MIN(loan_amount) AS minimum_loan_amount,
    MAX(loan_amount) AS maximum_loan_amount
FROM loans;

-- 3. How many loans are there for each loan type?
SELECT 
    loan_type,
    COUNT(*) AS total_loans
FROM loans
GROUP BY loan_type
ORDER BY total_loans DESC;

-- 4. How many loans are active, closed, defaulted and Written Off?
SELECT 
    status,
    COUNT(*) AS total_loans
FROM loans
GROUP BY status
ORDER BY total_loans DESC;

-- 5. What is the average interest rate across all loans?
SELECT 
    ROUND(AVG(interest_rate), 2) AS average_interest_rate
FROM loans;

-- 6. What is the average interest rate by loan type?
SELECT 
    loan_type,
    ROUND(AVG(interest_rate), 2) AS average_interest_rate
FROM loans
GROUP BY loan_type
ORDER BY average_interest_rate DESC;

-- 7. Which loan type has the highest average interest rate?
SELECT TOP 1
    loan_type,
    ROUND(AVG(interest_rate), 2) AS average_interest_rate
FROM loans
GROUP BY loan_type
ORDER BY average_interest_rate DESC;


-- 8. How many loans have late payments?
SELECT 
    COUNT(*) AS loans_with_late_payments
FROM loan_payments
WHERE late_payment_flag = 1;


-- 9. Which loan type has the highest number of late payments?
SELECT TOP 1
    loan_type,
    COUNT(*) AS late_payment_loans
FROM loans
RIGHT JOIN
     loan_payments
     ON loans.loan_id = loan_payments.loan_id
WHERE late_payment_flag = 1
GROUP BY loan_type
ORDER BY late_payment_loans DESC;

-- 10. Which loan type has the highest late-payment amount?
SELECT TOP 1
    loan_type,
    SUM(amount_paid) AS total_late_payment_amount
FROM loan_payments
LEFT JOIN loans 
ON loan_payments.loan_id = loans.loan_id
WHERE late_payment_flag = 1
GROUP BY loan_type
ORDER BY total_late_payment_amount DESC;

-- 11. Which branch has the highest number of late-payment loans?
SELECT TOP 1
    b.branch_name,
    COUNT(*) AS late_payment_loans
FROM branches AS b
JOIN loans AS L
     ON b.branch_id =L.branch_id
JOIN loan_payments AS p
     ON L.loan_id = l.loan_id
WHERE p.late_payment_flag = 1
GROUP BY b.branch_name
ORDER BY late_payment_loans DESC;