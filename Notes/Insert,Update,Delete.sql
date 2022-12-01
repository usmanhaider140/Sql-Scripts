use sql_store;
-- *** INSERT ***
INSERT
	INTO 
	customers 
		(first_name,
	last_name,
	birth_date,
	address,
	city,
	state)
values 
		('JOHN',
'SMITH',
'1997-09-15',
'address',
'city',
'ca');

SELECT
	*
FROM
	customers;

INSERT
	into
	shippers (name)
values ('shipper_1'),
		('shipper_2');

SELECT
	*
FROM
	shippers;

SELECT
	*
FROM
	products;

INSERT
	INTO
	products (name,
	quantity_in_stock,
	unit_price)
values 
('Pencil',
'1000',
5.65),
('Toys',
500,
10.99);

INSERT
	INTO
	orders (customer_id,
	order_date,
	status)
values
(1,
'1990-01-02',
1);

INSERT
	INTO
	order_items
values 
(LAST_INSERT_ID(),
1,
2,
2.95),
(LAST_INSERT_ID(),
12,
2,
3.95);
-- select last created item Id
SELECT
	LAST_INSERT_ID();

SELECT
	*
FROM
	order_items oi
	-- copying table into new table
CREATE TABLE orders_archived AS
select
	*
FROM
	orders o ;

SELECT
	*
FROM
	orders_archived oa ;

INSERT
	INto
	orders_archived 
SELECT
	*
FROM
	orders o
where
	order_date < '2019-01-01'
	-- EXERCISE
use sql_invoicing;

CREATE table invoices_archived as
SELECT
	i.invoice_id,
	i.number,
	c.name AS 'client',
	i.invoice_total,
	i.payment_total,
	i.invoice_date,
	i.due_date,
	i.payment_date
FROM
	invoices i
JOIN clients c
		USING (client_id)
WHERE
	 i.payment_date IS NOT NULL;

SELECT
	*
FROM
	invoices_archived;
-- *** UPDATE DATA ***
	
UPDATE
	invoices
SET
	payment_total = invoice_total * 0.5,
	payment_date = due_date
where
	invoice_id = 3;

SELECT
	*
FROM
	invoices i ;
-- Multiple Row UPDATE 

UPDATE
	invoices
SET
	payment_total = invoice_total * 0.5,
	payment_date = due_date
where
	client_id In (3, 4);
-- Exercise
use sql_store;

SELECT
	*
FROM
	customers c ;

UPDATE
	customers
SET
	points = points + 50
WHERE
	birth_date < '1990-01-01';
-- *** SubQueries ***
use sql_invoicing;

SELECT
	*
FROM
	clients c ;

SELECT
	*
FROM
	invoices i ;

UPDATE
	invoices
SET
	payment_total = invoice_total * 0.5,
	payment_date = due_date
WHERE
	client_id = 
(
	SELECT
		client_id
	FROM
		clients
	WHERE
		name = 'Myworks');

UPDATE
	invoices
SET
	payment_total = invoice_total * 0.5,
	payment_date = due_date
WHERE
	client_id IN 
(
	SELECT
		client_id
	FROM
		clients
	WHERE
		state IN ('CA', 'NY'));
-- Exercise
-- * Find Clients who have more than 3000 points
-- * If they have orders and their comment is null add comment = 'Gold Customers'
USE sql_store;

SELECT
	customer_id
FROM
	customers c
WHERE
	points > 3000;

SELECT
	*
FROM
	orders;

UPDATE
	orders
set
	comments = 'Gold Customer'
WHERE
	customer_id IN (
	SELECT
		customer_id
	from
		customers
	WHERE
		points > 3000 )
	AND comments IS NULL;


-- *** DELETE DATA ***
USE sql_invoicing;
DELETE FROM sql_invoicing.invoices WHERE invoice_id = 1;

SELECT * FROM sql_invoicing.invoices i ;
SELECT client_id FROM clients WHERE name='Myworks';
DELETE FROM sql_invoicing.invoices WHERE client_id IN (SELECT client_id FROM clients WHERE name='Myworks');

--- *** RESTORE DATA ***




