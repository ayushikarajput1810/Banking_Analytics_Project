-- ============================================
-- Customer_Satisfaction_Analysis
-- ============================================

--  Average satisfaction score

SELECT 
    ROUND(AVG(satisfaction_score), 1) AS avg_satisfaction_score
FROM support_tickets;

--  Average resolution time

SELECT 
    ROUND(AVG(CAST(DATEDIFF(DAY, date_opened, date_resolved) AS DECIMAL(10,2))
        ), 
        2
    ) AS avg_resolution_days
FROM support_tickets
WHERE status = 'Resolved';

-- Most common issue type

SELECT TOP 1
    issue_type,
    COUNT(*) AS number_of_issues
FROM support_tickets
GROUP BY issue_type
ORDER BY number_of_issues DESC;

--  Branches having unhappy customers (Lowest satisfaction scores)

SELECT TOP 3
    b.branch_name,
    ROUND(AVG(st.satisfaction_score), 1) AS avg_sat_score
FROM support_tickets AS st
JOIN accounts AS a 
    ON a.customer_id = st.customer_id
JOIN branches AS b 
    ON b.branch_id = a.branch_id
GROUP BY b.branch_name
ORDER BY avg_sat_score ASC;