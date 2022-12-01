-- Transaction

-- A group of sql statement that represent a single unit of work.

-- Atomicity
-- Consistency
-- Isolation
-- Durability - Changes are permanent

-- Creating Transaction

use sql_store;

START TRANSACTION;

INSERT INTO orders (customer_id, order_date, status)
VALUES (1, '2019-01-01', 1);

INSERT INTO order_items values (LAST_INSERT_ID(), 1, 1, 1)
    COMMIT;

-- ROLLBACK
ROLLBACK;


SELECT *
FROM orders;

-- by default mysql wrap our sql queries in auto TRANSACTION and auto COMMIT it.

SHOW VARIABLES LIKE 'autocommit';

-- CONCURRENCY

START TRANSACTION;
UPDATE
    customers
SET points = points + 10
WHERE customer_id = 1;

COMMIT;
# Transaction Isolation

-- Serialization
show variables like 'transaction_isolation';
set global transaction isolation level serializable;


-- read un-committed isolation level
-- dirty read
-- repeatable read isolation level
-- phantom read - serializable isolation level
use sql_store;
start transaction;
# set transaction isolation level read committed;
set transaction isolation level serializable;

select point
from customers
where customer_id = 1;
commit;

# Deadlock

start transaction ;
update customers set state ='va' where customer_id = 1;
update orders set status =1  where order_id = 1;
commit ;



