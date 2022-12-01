USE sql_store;

-- *** SELECT CLAUSE ***
SELECT *
FROM customers
ORDER BY first_name;

SELECT customer_id,
       first_name,
       last_name,
       points,
       (points / 10) * 10 AS 'discount factor'
FROM customers;

SELECT DISTINCT state
FROM customers;


SELECT name,
       unit_price,
       unit_price * 1.1 AS new_price
FROM products;

-- *** WHERE CLAUSE ***
-- >  Greater Than
-- >= Greater Than or Equal To
-- <  Less than
-- <= Less than or Equal To
-- != or <> Not Equal To

SELECT *
FROM customers
WHERE points > 3000;


SELECT *
FROM customers
WHERE state = 'va';


SELECT *
FROM customers
WHERE state != 'va';

SELECT *
FROM customers
WHERE birth_date > '1990-01-01';

SELECT *
FROM orders
WHERE order_date > '2018-01-01'
  AND order_date < '2019-01-01';

-- *** Combine Multiple Conditions *** 
-- AND (Both Conditions should be true)
-- OR (Either Both or One Condition should be true)
-- AND Operator has higher precedence
SELECT *
FROM customers
WHERE NOT (birth_date > '1990-01-01'
    OR points > 1000);


SELECT *,
       quantity * unit_price AS total_price
FROM order_items
WHERE order_id = 6
  AND quantity * unit_price > 30;

-- *** IN Operator ***        

SELECT *
FROM customers
WHERE state IN ('VA', 'FL', 'GA');

SELECT *
FROM customers
WHERE state NOT IN ('VA', 'FL', 'GA');

SELECT *
FROM products
WHERE quantity_in_stock IN (49, 38, 72);

-- *** BETWEEN Operator ***

SELECT *
FROM customers
WHERE points BETWEEN 1000 AND 3000;

SELECT *
FROM customers
WHERE birth_date BETWEEN '1990-01-01' AND '2000-01-01';

-- *** LIKE Operator ***
-- % any number of characters
-- _ signle character

SELECT *
FROM customers
WHERE last_name LIKE 'b____y';

SELECT *
FROM customers
WHERE address LIKE '%trail%'
   OR address LIKE '%avenue%';
SELECT *
FROM customers
WHERE phone LIKE '%9';


-- *** REG Operator ***
-- ^ start with stirng
-- $ end with string
-- | LOGICAL OR
-- [] [gim]e means either gi,ge or gm
-- [a-b] range
SELECT *
FROM customers
WHERE last_name REGEXP 'field$|mac|^rose';

SELECT *
FROM customers
WHERE last_name REGEXP '[a-h]e';



SELECT *
FROM customers
WHERE first_name REGEXP 'ELKA|AMBUR';
SELECT *
FROM customers
WHERE last_name REGEXP 'ey$|on$';
SELECT *
FROM customers
WHERE last_name REGEXP '^my|se';
SELECT *
FROM customers
WHERE last_name REGEXP 'b[ru]';

-- *** IS NULL Operator ***
SELECT *
FROM customers
WHERE phone IS NOT NULL;

SELECT *
FROM orders
WHERE shipped_date IS NULL
   OR shipper_id IS NULL;


-- *** ORDER BY Operator ***
SELECT *
FROM customers
ORDER BY birth_date;
SELECT *
FROM customers
ORDER BY state, first_name DESC;

SELECT *
FROM customers
ORDER BY birth_date;
SELECT *,
       quantity * unit_price AS total_price
FROM order_items
WHERE order_id = 2
ORDER BY total_price DESC;

-- *** LIMIT CLAUSE ***

SELECT *
FROM customers
LIMIT 6 , 3;
-- page 1: 1 - 3
-- page 2: 4 - 6
-- page 3: 7 - 9

SELECT *
FROM customers
ORDER BY points DESC
LIMIT 3

























