-- ============================================
-- 06_Card_Analysis.sql
-- Card Portfolio & Transaction Analysis
-- ============================================
SELECT * FROM branches
SELECT * FROM cards
SELECT * FROM card_transactions

-- ============================================
-- CARD PORTFOLIO ANALYSIS
-- ============================================

-- How many cards have been issued in total?
SELECT 
    COUNT(*) AS total_cards
FROM cards;

-- How many cards are there for each card type?
SELECT 
    card_type,
    COUNT(*) AS total_cards
FROM cards
GROUP BY card_type
ORDER BY total_cards DESC;

-- Which card type is the most popular?
SELECT TOP 1
    card_type,
    COUNT(*) AS total_cards
FROM cards
GROUP BY card_type
ORDER BY total_cards DESC;

-- How many cards are active, blocked, or expired?
SELECT 
    status,
    COUNT(*) AS total_cards
FROM cards
GROUP BY status
ORDER BY total_cards DESC;

-- ============================================
-- CREDIT LIMIT ANALYSIS
-- ============================================

-- What is the average credit limit per card?
SELECT 
    ROUND(AVG(credit_limit), 2) AS average_credit_limit
FROM cards;

-- Which card type has the highest average credit limit?
SELECT TOP 1
    card_type,
    ROUND(AVG(credit_limit), 2) AS average_credit_limit
FROM cards
GROUP BY card_type
ORDER BY average_credit_limit DESC;

-- What are the top 10 cards by credit limit?
SELECT TOP 10
    card_id,
    customer_id,
    card_type,
    credit_limit,
    status
FROM cards
ORDER BY credit_limit DESC;

-- ============================================
-- CUSTOMER & CARD ANALYSIS
-- ============================================

-- Which customers have multiple cards?
SELECT 
    customer_id,
    COUNT(*) AS total_cards
FROM cards
GROUP BY customer_id
HAVING COUNT(*) > 1
ORDER BY total_cards DESC;

-- ============================================
-- CARD TRANSACTION ANALYSIS
-- ============================================

-- What is the total transaction amount made using cards?
SELECT 
    SUM(amount) AS total_transaction_amount
FROM card_transactions;

-- What is the average transaction amount per card?
SELECT 
    ROUND(AVG(amount), 2) AS average_transaction_amount
FROM card_transactions;

-- Which card type has the highest transaction volume?
SELECT TOP 1
    c.card_type,
    COUNT(*) AS transaction_volume
FROM cards AS c
JOIN card_transactions AS ct
    ON c.card_id = ct.card_id
GROUP BY c.card_type
ORDER BY transaction_volume DESC;

-- Which customers have the highest card spending?
SELECT TOP 10
    c.customer_id,
    SUM(ct.amount) AS total_card_spending
FROM cards AS c
JOIN card_transactions AS ct
    ON c.card_id = ct.card_id
GROUP BY c.customer_id
ORDER BY total_card_spending DESC;
