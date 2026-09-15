-- ============================================
-- 04_Accounts_Analysis.sql
-- Account Portfolio & Balance Analysis
-- ============================================


-- ============================================
-- ACCOUNT PORTFOLIO ANALYSIS
-- ============================================

-- How many accounts are there in total?
SELECT 
    COUNT(*) AS total_accounts
FROM accounts;

-- How many active and inactive accounts are there?
SELECT 
    status,
    COUNT(*) AS total_accounts
FROM accounts
GROUP BY status
ORDER BY total_accounts DESC;

-- What is the distribution of accounts by account type?
SELECT 
    account_type,
    COUNT(*) AS total_accounts
FROM accounts
GROUP BY account_type
ORDER BY total_accounts DESC;

-- Which account type is the most popular?
SELECT TOP 1
    account_type,
    COUNT(*) AS total_accounts
FROM accounts
GROUP BY account_type
ORDER BY total_accounts DESC;

-- What percentage of accounts are active?
SELECT 
    ROUND(100.0 * SUM(
            CASE 
                WHEN status = 'Active' THEN 1 
                ELSE 0 
            END) / COUNT(*), 2
    ) AS active_account_percentage
FROM accounts;

-- What is the total balance held across all accounts?
SELECT 
    SUM(balance) AS total_balance
FROM accounts;

-- What is the average account balance?
SELECT 
    ROUND(AVG(balance), 2) AS average_account_balance
FROM accounts;

-- Which account type has the highest average balance?
SELECT TOP 1
    account_type,
    ROUND(AVG(balance), 2) AS average_balance
FROM accounts
GROUP BY account_type
ORDER BY average_balance DESC;

-- Which account type holds the highest total deposits?
SELECT TOP 1
    account_type,
    SUM(balance) AS total_deposits
FROM accounts
GROUP BY account_type
ORDER BY total_deposits DESC;

-- What are the top 10 accounts by balance?
SELECT TOP 10
    account_id,
    customer_id,
    account_type,
    balance
FROM accounts
ORDER BY balance DESC;