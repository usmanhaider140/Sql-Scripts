-- ** SUMMARIZING DATA ***
USE sql_invoicing;

SELECT
	client_id ,
	SUM(invoice_total) AS total_sales
FROM
	invoices i
WHERE
	invoice_date >= '2019-07-01'
GROUP BY
	client_id
ORDER BY
	total_sales DESC;
-- 2) Combining More than One Table
	
SELECT
	state ,
	city,
	SUM(invoice_total) AS total_sales
FROM
	invoices i
JOIN clients c
		USING(client_id)
GROUP BY
	state,
	city
	-- Exercise

SELECT
	p.`date`,
	pm.name AS payment_method,	
	SUM(amount) AS total_payments
FROM
	payments p
JOIN payment_methods pm
ON
	p.payment_method = pm.payment_method_id
GROUP BY
	`date` ,
	payment_method
ORDER BY
	p.`date` 

SELECT
	*
FROM
	payments p
	-- *** HAVING CLAUSE ***


SELECT
	client_id,
	sum(invoice_total) AS total_sales,
	count(*) AS number_of_invoices
FROM
	invoices i
GROUP BY
	client_id
HAVING
	total_sales > 500
	AND number_of_invoices > 5;
-- Exercise
USE sql_store;

SELECT
	c.customer_id,
	CONCAT(c.first_name, ' ', c.LAST_NAME) AS Customer,
	c.state,
	SUM(oi.quantity * oi.unit_price) AS total_spent
FROM
	order_items oi
JOIN orders o
		USING (order_id)
JOIN customers c
		USING(customer_id)
GROUP BY
	customer_id
HAVING
	total_spent > 100
	AND state = 'VA';

SELECT
	*
FROM
	customers c
WHERE
	state = 'VA';

SELECT
	*
FROM
	orders o;
	
	
-- *** The Rollup Operator ***
USE sql_invoicing;
SELECT
	client_id,
	c.city,
	c.state, 
	SUM(invoice_total) AS total_sales
FROM
	invoices i join clients c using (client_id)
GROUP BY
state, city,
	client_id 
with ROLLUP ;

SELECT
	pm.name as payment_method ,
	SUM(p.amount) as total
FROM
	payments p
JOIN payment_methods pm
WHERE
	p.payment_method = pm.payment_method_id
GROUP BY
	payment_method WITH ROLLUP  
	
	
	
	
	
	
	