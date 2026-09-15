-- ============================================
-- 03_Branch_Performance.sql
-- Branch Performance
-- ============================================

-- Branches with the highest total deposits
SELECT 
    b.branch_name,
    SUM(a.balance) AS total_deposits
FROM branches AS b
JOIN accounts AS a
    ON b.branch_id = a.branch_id
GROUP BY b.branch_name
ORDER BY total_deposits DESC;

-- Branches with the highest total loan amount
SELECT 
    b.branch_name,
    SUM(l.loan_amount) AS total_loan_amount
FROM branches AS b
JOIN loans AS l
    ON b.branch_id = l.branch_id
GROUP BY b.branch_name
ORDER BY total_loan_amount DESC;

-- Branch having maximum customers (INNER JOIN)
SELECT TOP 1
    b.branch_name,
    COUNT(DISTINCT c.customer_id) AS number_of_customers
FROM branches AS b
JOIN accounts AS a 
    ON b.branch_id = a.branch_id
JOIN customers AS c 
    ON c.customer_id = a.customer_id
GROUP BY b.branch_name
ORDER BY number_of_customers DESC;


-- Average employee salary branch-wise
SELECT 
    b.branch_name,
    ROUND(AVG(e.salary), 1) AS avg_salary
FROM branches AS b
JOIN employees AS e 
    ON b.branch_id = e.branch_id
GROUP BY b.branch_name;


-- Employees hired every year
SELECT
    YEAR(hire_date) AS hire_year,
    COUNT(employee_id) AS employees_hired
FROM employees
GROUP BY YEAR(hire_date)
ORDER BY hire_year;


-- Top 5 performing branches based on deposits
SELECT TOP 5
    b.branch_name,
    SUM(a.balance) AS total_deposits
FROM branches AS b
JOIN accounts AS a 
    ON b.branch_id = a.branch_id
GROUP BY b.branch_name
ORDER BY total_deposits DESC;