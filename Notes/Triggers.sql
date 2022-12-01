-- *** TRIGGERS ***
USE sql_invoicing;
DELIMITER $$
-- Drop Trigger
DROP TRIGGER IF EXISTS payments_after_insert;
-- Create Trigger
CREATE TRIGGER payments_after_insert
AFTER
INSERT
	ON
	payments
FOR EACH ROW
BEGIN 
	UPDATE
	invoices
SET
	payment_total = payment_total + NEW.amount
WHERE
	invoice_id = NEW.invoice_id;
    
    INSERT
	INTO
	payments_audit
VALUES (New.client_id,
New.date,
NEW.amount,
'INSERT',
NOW());
END $$
DELIMITER ;

UPDATE
	invoices
SET
	payment_total = 100
WHERE
	invoice_id = 3;

SELECT
	*
FROM
	invoices i;

INSERT
	INTO
	payments
VALUES (DEFAULT,
5,
3,
'2019-01-01',
10,
1);

SELECT
	*
FROM
	payments p;
-- Delete Trigger
DROP TRIGGER IF EXISTS reduce_payment_from_invoice;
-- Create Trigger
delimiter $$
CREATE TRIGGER reduce_payment_from_invoice
AFTER
DELETE
	ON
	payments
FOR EACH ROW
BEGIN
	UPDATE
	invoices
SET
	payment_total = payment_total - old.amount
WHERE
	invoice_id = old.invoice_id;

INSERT
	INTO
	payments_audit
VALUES (Old.client_id,
Old.date,
Old.amount,
'Delete',
NOW());
END $$
delimiter ;

DELETE
FROM
	payments
WHERE
	payment_id = 13;
-- Show Triggers 
SHOW triggers;
-- table_after_insert
-- sql script
USE sql_invoicing;

CREATE TABLE payments_audit
(
	client_id INT NOT NULL, 
    date DATE NOT NULL,
    amount DECIMAL(9,
2) NOT NULL,
    action_type VARCHAR(50) NOT NULL,
    action_date DATETIME NOT NULL
);

INSERT
	INTO
	payments
VALUES (DEFAULT,
5,
3,
'2019-01-01',
10,
1);

DELETE
FROM
	payments
WHERE
	payment_id = 11;

SELECT
	*
FROM
	payments_audit;
-- Event
-- A task (or block of sql code) that gets executed according to a shedule
SHOW variables LIKE 'event%';

SET
GLOBAL event_scheduler = ON;
-- Create an Event
-- start name convention with yearly, monthly, weekly, daily, hourly, once this will give your event when it will trigger
-- for date event use AT 'Date'
-- for recurring event use Every
delimiter $$ 
CREATE event yearly_delete_stale_audit_rows ON
schedule
-- AT '2022-12-09'
 EVERY 1 YEAR starts '2019-01-01' ends '2029-01-01'
 Do BEGIN 
	DELETE
FROM
	payment_audit
WHERE
	action_date < now() - INTERVAL 1 YEAR;
-- DATEADD(NOW(), INTERVAL -1 YEAR);
-- DATEADD(NOW(), INTERVAL 1 YEAR);
END $$
delimiter ;
-- SHOW EVENTS
SHOW EVENTS;
-- DROP EVENTS
DROP Event IF EXISTS yearly_delete_stale_audit_rows;
-- Alter event
-- Alter event syntax same as create event
-- enabled for enabling
-- disabled for disabling
-- alter event yearly_delete_stale_audit_rows disabled;