-- *** SUMMARIZING DATA ***

-- *** Aggregate Functions
-- MAX()
-- MIN()
-- AVG()
-- SUM()
-- COUNT()

use sql_invoicing;

SELECT
	MAX(invoice_total) AS highest,
	Min(invoice_total) AS lowest,
	AVG(invoice_total) AS average,
	SUM(invoice_total/100) AS total,
	COUNT(invoice_total) AS number_of_invoices,	
	COUNT(DISTINCT client_id) AS total_records
from
	invoices i;
	
SELECT
	'First half of 2019' AS date_range,
	SUM(invoice_total) As total_sales,
	SUM(payment_total) AS total_payments,
	SUM(invoice_total - payment_total) AS what_we_expect
FROM
	invoices i
WHERE
	invoice_date BETWEEN '2019-01-01' AND '2019-06-30'
UNION 
SELECT
	'SECOND half of 2019' AS date_range,
	SUM(invoice_total) As total_sales,
	SUM(payment_total) AS total_payments,
	SUM(invoice_total - payment_total) AS what_we_expect
FROM
	invoices i
WHERE
	invoice_date BETWEEN '2019-07-01' AND '2019-12-30'
UNION  
SELECT
	'Total' AS date_range,
	SUM(invoice_total) As total_sales,
	SUM(payment_total) AS total_payments,
	SUM(invoice_total - payment_total) AS what_we_expect
FROM
	invoices i
WHERE
	invoice_date BETWEEN '2019-01-01' AND '2019-12-30'
	
	

	
	