-- *** ESSENTAIL MYSQL FUNCTIONS ***
-- Round Function

SELECT
	ROUND(5.7345, 2)
	-- TRUNCATE Function

SELECT
	TRUNCATE(5.7345, 3)
	-- CEILING Function

SELECT
	CEILING (5.23)
	-- floor Function
SELECT
	floor(-4.333)
	-- ABSOLUTE Function

SELECT
	ABS(-5.33434)
	-- RANDOM Function

SELECT
	RAND(4.33) ;
-- *** STRING FUNCTIONS ***

SELECT
	UPPER('sky');

SELECT
	LOWER('sky');

SELECT
	LTRIM('   sky');

SELECT
	RTRIM('sky  ');

SELECT
	LEFT('Kindergarten',
	4);

SELECT
	RIGHT('kindergarten',
	3);

SELECT
	SUBSTR ('kindergarten',
	3,
	5);

SELECT
	Locate('garten', 'kindergarten');

SELECT
	REPLACE('kindergarten', 'garten', 'garden');

SELECT
	concat ('first',
	'last');
-- *** Date Functions

SELECT
	Now(),
	CURDATE(),
	CURTIME() ;

SELECT
	YEAR (NOW());

SELECT
	MONTH(NOW());

SELECT
	DAYNAME(NOW());

SELECT
	EXTRACT (DAY
FROM
	NOW());

SELECT
	EXTRACT (MONTH
FROM
	NOW());

SELECT
	EXTRACT (YEAR
FROM
	NOW());

USE sql_store;

SELECT
	*
FROM
	orders o
WHERE
	order_date >= '2019-01-01';

SELECT
	DATE_SUB(now(),
	INTERVAL 1 YEAR);

SELECT
	DATEDIFF('2019-01-04', '2018-02-01');
	-- return in days 
-- TIME TO SECONDS
	SELECT
	TIME_TO_SEC('09:00') - TIME_TO_SEC('09:02') ;
	
	
USE sql_store;

SELECT
	order_id,
	IFNULL(shipper_id, 'NOT ASSIGNED') AS SHIPPER
FROM
	orders;
	

SELECT order_id, IFNULL(shipper_id, '...') AS 'shipper',
COALESCE(shipper_id, comments, 'not assigned') AS shipper FROM orders;


SELECT
	CONCAT(c.first_name, ' ', c.last_name),
	IFNULL(phone, 'Unknown')
FROM
	customers c;
	
-- IF FUNCTION
-- if(expression, FIRST, second)

SELECT
	order_id,
	order_date,
	IF(YEAR(o.order_date) = YEAR(NOW()),
	'ACTIVE','ARCHIVED') AS CATEGORY
FROM
	orders o
	
-- 	My Solution
	
	SELECT
	product_id,
	name,
	(
	SELECT
		COUNT(product_id)
	FROM
		order_items oi
	WHERE
		oi.product_id = p.product_id) AS orders,
	IF ((SELECT orders) > 1, 'Many Times', 'One')
FROM
	products p ;
	
-- 	Other Solution
	
SELECT
	product_id,
	name,
	COUNT(*) AS orders ,
	IF (COUNT(*)  > 1,
	'Many Times',
	'One')
FROM
	products p
JOIN order_items oi
		USING (product_id)
GROUP BY
	product_id;
	
SELECT
	order_id,
	CASE
		WHEN YEAR(order_date) = YEAR(NOW()) THEN 'ACTIVE'
		WHEN YEAR(order_date) = YEAR(NOW()) - 1 THEN 'Last Year'
		WHEN YEAR(order_date) = YEAR(NOW()) - 2 THEN 'Two Years ago'
		WHEN YEAR(order_date) = YEAR(NOW()) - 3 THEN 'Three Years ago'
		WHEN YEAR(order_date) < YEAR(NOW()) - 3 THEN 'Archived'
		ELSE 'FUTURE'
		END AS 'Category'
	FROM
		orders;
	
		
SELECT
	CONCAT(c.first_name, ' ', c.last_name) AS 'CUSTOMER',
	points,
	CASE 
		WHEN points > 3000 THEN 'GOLD'
		WHEN points > 2000 THEN 'SILVER'
		WHEN points > 1000 THEN 'BRONZE'
		ELSE 'BRONZE'
	END AS Category
FROM
	customers c ORDER BY category
		
		
		
		
		
		
		
		
		
		

	