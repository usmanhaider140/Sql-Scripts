-- ** SubQuery ***

USE sql_store;

SELECT
	*
FROM
	products p
WHERE
	unit_price > (
	SELECT
		unit_price
	FROM
		products p2
	WHERE
		product_id = 3
);
-- Exercise
USE sql_hr;

SELECT
	e.employee_id ,
	CONCAT(e.first_name, ' ', e.last_name) AS Employee, 
	e.salary
FROM
	employees e
WHERE
	salary > (
	SELECT
		AVG(salary)
	FROM
		employees e2
);
-- *** In Operator ***
USE sql_store;

SELECT
	*
FROM
	products p
WHERE
	p.product_id NOT IN (
	SELECT
		DISTINCT product_id
	FROM
		order_items oi );
-- Exercise
USE sql_invoicing;

SELECT
	*
FROM
	clients c
WHERE
	client_id NOT IN(
	SELECT
		client_id
	FROM
		invoices i2 )
	-- *** SUBQUERIES ***
SELECT
	*
FROM
	clients c ;

SELECT
	*
FROM
	clients c
LEFT JOIN invoices i
		USING (client_id)
WHERE
	invoice_id IS NULL;
-- EXERCISE
USE sql_store;

SELECT
	*
FROM
	customers c
JOIN orders
		USING(customer_id)
WHERE
	customer_id = 3
	
SELECT
	customer_id AS id ,
	CONCAT(first_name, ' ', last_name) AS Customer_Name
FROM
	customers c
WHERE
	customer_id IN (
	SELECT
		o.customer_id
	FROM
		order_items oi
	JOIN orders o
			USING (order_id)
	WHERE
		product_id = 3)



SELECT
	DISTINCT customer_id ,
	CONCAT(first_name, ' ', last_name) AS Customer_Name
FROM
	customers c
JOIN orders o
		USING (customer_id)
JOIN order_items oi
		USING (order_id)
WHERE
	oi.product_id = 3;
-- *** ALL KEYWORD ***

USE sql_invoicing;

SELECT
	*
FROM
	invoices i
WHERE
	invoice_total > (
	SELECT
		MAX(invoice_total)
	FROM
		invoices
	WHERE
		client_id = 3
);
-- it will compare with all values if they are multiple

SELECT
	*
FROM
	invoices i
WHERE
	invoice_total > ALL(
	SELECT
		invoice_total
	FROM
		invoices i2
	WHERE
		client_id = 3) ;

SELECT
	*
FROM
	clients c
WHERE
	client_id = ANY	
	(
	SELECT
		client_id
	FROM
		invoices i
	GROUP BY
		client_id
	HAVING
		COUNT(*) >= 2 
)
	-- CORELATED QUERIES

USE sql_hr;

SELECT
	*
FROM
	employees e ;
-- for each employee
-- calculate the avg salary for employee.office
-- return the employee if salary > avg

SELECT
	e2.employee_id ,
	e2.first_name,
	e2.office_id
FROM
	employees e2
WHERE
	e2.salary > (
	SELECT
		AVG(salary)
	FROM
		employees e
	WHERE
		office_id = e2.office_id
	);
-- Exercise
USE sql_invoicing;

SELECT
	client_id,
	invoice_total
FROM
	invoices i2
WHERE
	invoice_total >
(
	SELECT
		AVG (invoice_total)
	FROM
		invoices i
	GROUP BY
		client_id
	HAVING
		client_id = i2.client_id);
	
-- Other Solution
SELECT
	*
FROM
	invoices i
WHERE
	invoice_total > (
	SELECT
		AVG(invoice_total)
	FROM
		invoices
	WHERE
		client_id = i.client_id);

SELECT
	client_id ,
	AVG (invoice_total),
	COUNT(client_id),
	SUM(invoice_total)
FROM
	invoices i
GROUP BY
	client_id
	
	
	
-- *** Exists Clause ***

	
-- SELECT client that have an invoice
	
	
SELECT
	*
FROM
	clients c
WHERE
	client_id IN (
	SELECT
		DISTINCT client_id
	FROM
		invoices);
	
	
SELECT
	*
FROM
	clients c
WHERE
	EXISTS (
	SELECT
		client_id
	FROM
		invoices i
	WHERE
		client_id = c.client_id 
)
	
	
	
-- Exercise	
	
USE sql_store;

SELECT
	DISTINCT product_id
FROM
	products p
WHERE
	NOT EXISTS (
	SELECT
		product_id
	FROM
		order_items oi
	WHERE
		product_id = p.product_id)
	
	

		
-- SubQuery in SELECT 
		
USE sql_invoicing;

SELECT
	invoice_id,
	invoice_total,
	(
	SELECT
		AVG(invoice_total)
	FROM
		invoices i  
) AS invoice_average,
	invoice_total - (
	SELECT
		invoice_average) AS difference
FROM
	invoices i ;


-- Exercise

SELECT * FROM invoices i ;

SELECT
	client_id , name,
	(SELECT sum(invoice_total) FROM invoices i WHERE client_id = c.client_id ) AS total_sales,
	(SELECT AVG(invoice_total) FROM invoices) AS average,
	(SELECT total_sales -  average) AS difference
FROM
clients c;



-- *** SubQuery in From Clause ***

SELECT 
	* FROM (SELECT
	client_id , name,
	(SELECT sum(invoice_total) FROM invoices i WHERE client_id = c.client_id ) AS total_sales,
	(SELECT AVG(invoice_total) FROM invoices) AS average,
	(SELECT total_sales -  average) AS difference
FROM
clients c
) AS sales_summary WHERE total_sales IS NOT NULL 
	
	
	
	
	
	
	
	
	
	
	
