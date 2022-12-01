use sql_store;
-- *** INNER JOIN *** 
SELECT 
    order_id, O.customer_id, first_name, last_name
FROM
    orders AS O
        INNER JOIN
    customers AS C ON O.customer_id = C.customer_id;
SELECT 
    order_id, OI.product_id, P.name, quantity, OI.unit_price
FROM
    order_items AS OI
        JOIN
    products AS P ON OI.product_id = P.product_id;
    
-- *** JOIN WITH IN TWO DATABASES ***
SELECT 
    *
FROM
    order_items oi
        JOIN
    sql_inventory.products p ON oi.product_id = p.product_id;    

-- *** Self Join ***
use sql_hr;

SELECT 
    e.employee_id, e.first_name, m.first_name AS Manager
FROM
    employees e
        JOIN
    employees m ON e.reports_to = m.employee_id;
    
-- *** Joining More Than Two Tables ***
use sql_store;

SELECT 
    o.order_id,
    o.order_date,
    c.first_name,
    c.last_name,
    os.name AS status
FROM
    orders o
        JOIN
    customers c ON o.customer_id = c.customer_id
        JOIN
    order_statuses os ON o.status = os.order_status_id;
    
-- Exercise
use sql_invoicing;
SELECT 
    c.name AS client_name,
    p.date,
    pm.name AS payment_method,
    p.amount
FROM
    payments p
        JOIN
    clients c ON p.client_id = c.client_id
        JOIN
    payment_methods pm ON p.payment_method = pm.payment_method_id;
    
-- *** COMPOUND JOIN CONDITIONS ***    
-- Composite keys are more Uniquely Identifiers which are more than one primary key columns
use sql_store;
SELECT 
    *
FROM
    order_items oi
        JOIN
    order_item_notes oin ON oi.order_id = oin.order_Id
        AND oi.product_id = oin.product_id;




-- *** IMPLICIT JOIN SYNTAX ***

SELECT 
    *
FROM
    orders o
        JOIN
    customers c ON o.customer_id = c.customer_id;

SELECT 
    *
FROM
    orders o,
    customers c
WHERE
    o.customer_id = c.customer_id;



-- *** OUTER JOIN ***
-- LEFT JOIN
-- RIGHT JOIN
SELECT 
    *
FROM
    customers c
        LEFT JOIN
    orders o ON c.customer_id = o.customer_id
ORDER BY c.customer_id;
SELECT 
    *
FROM
    customers c
        RIGHT JOIN
    orders o ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

SELECT 
    p.product_id, p.name, oi.quantity
FROM
    products p
        LEFT JOIN
    order_items oi ON p.product_id = oi.product_id;


-- Self Outer Join

use sql_hr;


SELECT 
    e.employee_id, e.first_name, m.first_name AS manager
FROM
    employees e
        LEFT JOIN
    employees m ON e.reports_to = m.employee_id;
    
    
    
    
-- *** USING CLAUSE ***    
use sql_store;

SELECT 
    o.order_fid, c.first_name AS customer, sh.name AS shipper
FROM
    customers c
        LEFT JOIN
    orders o USING (customer_id)
        JOIN
    shippers sh USING (shipper_id)
;
    
SELECT 
    *
FROM
    order_items oi
        JOIN
    order_item_notes oin USING (order_id , product_id);
    
-- Exercise

use sql_invoicing;

SELECT 
    p.date,
    c.name AS client,
    p.amount,
    pm.name AS payment_method
FROM
    payments p
        JOIN
    clients c USING (client_id)
        JOIN
    payment_methods pm ON p.payment_method = pm.payment_method_id;
    
    
-- NATURAL JOIN
use sql_store;
SELECT 
    o.order_id, c.first_name
FROM
    orders o
        NATURAL JOIN
    customers c;
    
-- CROSS JOIN    

SELECT 
    c.first_name AS customer, p.name AS product
FROM
    customers c
        CROSS JOIN
    products p;
    
-- implicit syntax    
SELECT 
    s.name AS shipper, p.name AS product
FROM
    shippers s,
    products p
ORDER BY s.name;

-- explicit syntax
SELECT 
    s.name AS shipper, p.name AS product
FROM
    shippers s
        CROSS JOIN
    products p
ORDER BY s.name;

-- UNION JOINS

SELECT 
    order_id, order_date, 'Active' AS Status
FROM
    orders o
WHERE
    order_date >= '2019-01-01' 
UNION SELECT 
    order_id, order_date, 'Archived' AS Status
FROM
    orders o
WHERE
    order_date <= '2019-01-01';


SELECT 
    first_name AS Customer
FROM
    customers 
UNION SELECT 
    name AS shipper
FROM
    shippers;
    
select customer_id,first_name, points, 'Gold' AS type from customers where points > 3000
union
select customer_id,first_name, points, 'Silver' AS type from customers where points between 2000 and 3000
union
select customer_id,first_name, points, 'Bronze' AS type from customers where points <= 2000;
