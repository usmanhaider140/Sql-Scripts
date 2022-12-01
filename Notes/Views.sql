-- *** VIEWS ***
USE sql_invoicing;

CREATE VIEW sales_by_client AS
SELECT
	c.client_id ,
	c.name,
	sum(invoice_total) AS total_sales
FROM
	clients c
JOIN invoices i
		USING
(client_id)
GROUP BY
	client_id,
	name;
-- on views we can apply CONDITION 
SELECT
	*
FROM
	sales_by_client sbc
	-- VIEW
WHERE
	total_sales > 500;
-- on VIEW we can join other table
SELECT
	*
FROM
	sales_by_client sbc
JOIN clients c
		USING (client_id)
	-- Exercise
CREATE
VIEW
clients_balance AS
SELECT
	c.client_id,
	c.name,
	SUM(invoice_total - payment_total) AS balance
FROM
	clients c
JOIN invoices i
		USING (client_id)
GROUP BY
	client_id
	-- Drop View

	DROP VIEW sales_by_client
	-- Create or Replace Vuew
	
	
CREATE OR REPLACE
VIEW sales_by_client AS
SELECT
	c.client_id ,
	c.name,
	sum(invoice_total) AS total_sales
FROM
	clients c
JOIN invoices i
		USING
(client_id)
GROUP BY
	client_id,
	name;


-- Alter or Update Views
-- Distinct
-- Aggregate Functions (Min, Max, SUM)
-- Group By / HAVING 
-- UNION 

CREATE OR REPLACE
VIEW invoices_with_balance AS
SELECT
	invoice_id,
	number,
	client_id,
	invoice_total,
	payment_total,
	invoice_total - payment_total AS balance,
	invoice_date,
	payment_date,
	due_date
FROM
	invoices i
WHERE
	(invoice_total - payment_total) > 0;
