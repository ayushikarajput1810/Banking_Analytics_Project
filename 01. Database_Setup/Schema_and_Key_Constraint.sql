create database PRIME_BANK

SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'cards';

ALTER TABLE accounts
ADD CONSTRAINT FK_accounts_customers
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);

ALTER TABLE accounts
ADD CONSTRAINT FK_accounts_branches
FOREIGN KEY (branch_id)
REFERENCES branches(branch_id);

ALTER TABLE transactions
ADD CONSTRAINT FK_transactions_accounts
FOREIGN KEY (account_id)
REFERENCES accounts(account_id);

ALTER TABLE cards
ADD CONSTRAINT FK_cards_customers
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);

ALTER TABLE cards
ADD CONSTRAINT FK_cards_accounts
FOREIGN KEY (account_id)
REFERENCES accounts(account_id);

ALTER TABLE card_transactions
ADD CONSTRAINT FK_card_transactions_cards
FOREIGN KEY (card_id)
REFERENCES cards(card_id);

ALTER TABLE loans
ADD CONSTRAINT FK_loans_customers
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);

ALTER TABLE loans
ADD CONSTRAINT FK_loans_branches
FOREIGN KEY (branch_id)
REFERENCES branches(branch_id);

ALTER TABLE loan_payments
ADD CONSTRAINT FK_loan_payments_loans
FOREIGN KEY (loan_id)
REFERENCES loans(loan_id);

ALTER TABLE employees
ADD CONSTRAINT FK_employees_branches
FOREIGN KEY (branch_id)
REFERENCES branches(branch_id);

ALTER TABLE support_tickets
ADD CONSTRAINT FK_support_tickets_customers
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);