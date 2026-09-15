-- ============================================
-- 07_Transaction_Analysis.sql
-- Transaction Analysis
-- ============================================
select * from transactions

--  Average transaction amount
SELECT 
    ROUND(AVG(amount), 2) AS avg_transaction_amount
FROM transactions;

-- Monthly transaction volume

SELECT
    YEAR(txn_date) AS txn_year,
    MONTH(txn_date) AS txn_month,
    COUNT(transaction_id) AS transaction_count
FROM transactions
GROUP BY 
    YEAR(txn_date),
    MONTH(txn_date)
ORDER BY 
    txn_year,
    txn_month;

-- Top 10 accounts with highest transaction value

SELECT TOP 10
    account_id,
    SUM(amount) AS total_amount
FROM transactions
GROUP BY account_id
ORDER BY total_amount DESC;

-- Most used transaction channel/type

SELECT TOP 1
    txn_type,
    COUNT(*) AS number_of_txn
FROM transactions
GROUP BY txn_type
ORDER BY number_of_txn DESC;

-- Cash withdrawal vs deposit comparison

SELECT
    CASE
        WHEN txn_type IN ('Deposit', 'Interest Credit', 'Transfer In') 
            THEN 'Deposit'
        WHEN txn_type IN ('Withdrawal', 'Fee Debit', 'Transfer Out') 
            THEN 'Withdrawal'
        ELSE 'Other'
    END AS transaction_category,
    SUM(amount) AS total_amount,
    ROUND(AVG(amount), 2) AS average_amount
FROM transactions
GROUP BY
    CASE
        WHEN txn_type IN ('Deposit', 'Interest Credit', 'Transfer In') 
            THEN 'Deposit'
        WHEN txn_type IN ('Withdrawal', 'Fee Debit', 'Transfer Out') 
            THEN 'Withdrawal'
        ELSE 'Other'
    END;


-- Monthly deposit vs withdrawal trend

SELECT
    YEAR(txn_date) AS txn_year,
    MONTH(txn_date) AS txn_month,
    CASE
        WHEN txn_type IN ('Deposit', 'Interest Credit', 'Transfer In') 
            THEN 'Deposit'
        WHEN txn_type IN ('Withdrawal', 'Fee Debit', 'Transfer Out') 
            THEN 'Withdrawal'
        ELSE 'Other'
    END AS transaction_category,
    SUM(amount) AS total_amount
FROM transactions
GROUP BY YEAR(txn_date), MONTH(txn_date),
    CASE
        WHEN txn_type IN ('Deposit', 'Interest Credit', 'Transfer In') 
            THEN 'Deposit'
        WHEN txn_type IN ('Withdrawal', 'Fee Debit', 'Transfer Out') 
            THEN 'Withdrawal'
        ELSE 'Other'
    END
ORDER BY
    txn_year,
    txn_month;