-- *** STORED PROCEDURE ***
USE sql_invoicing;
DELIMITER $$
CREATE PROCEDURE get_clients()
BEGIN
	SELECT
		*
FROM
		clients c;
END $$
DELIMITER ;


CALL get_clients();
DELIMITER $$
CREATE PROCEDURE get_invoices_with_balance()
BEGIN
	SELECT
		*,
		(invoice_total - payment_total) AS balance
FROM
		invoices i
WHERE
		(invoice_total - payment_total) > 0;
END$$
DELIMITER ;

CALL get_clients();

CALL get_invoices_with_balance();

CALL get_payments();
-- Drop Store PROCEDURE 

DROP PROCEDURE IF EXISTS get_invoices_with_balance;
-- PARAMETERS - to pass a value
DELIMITER $$ 
CREATE PROCEDURE get_clients_by_state(state char(2))
BEGIN 
IF state IS NULL THEN SET
state = 'ca';
END IF;
	SELECT
	*
FROM
	clients c
WHERE
	c.state = state;
END $$
DELIMITER ;
-- Exercise
DELIMITER $$
CREATE PROCEDURE get_invoices_by_clients(client_id varchar(10))
BEGIN

SELECT
	*
FROM
	invoices i
WHERE
	i.client_id = client_id;
END $$
Delimiter ;

CALL get_invoices_by_clients(1);
-- Exercise

DROP PROCEDURE IF EXISTS get_payments;
delimiter $$
CREATE PROCEDURE get_payments(client_id int,
payment_method_id TINYINT)
BEGIN
SELECT
	*
FROM
	payments p
WHERE
	p.client_id = ifnull(client_id, p.client_id)
	AND
	p.payment_method = ifnull(payment_method_id, p.payment_method);
END $$
delimiter 





CALL get_payments();
DROP PROCEDURE IF EXISTS make_payment;
delimiter $$
CREATE PROCEDURE make_payment(
invoice_id INT,
payment_amount Decimal(9,
2),
payment_date DATE
)
BEGIN 
	IF payment_amount <= 0
	THEN
	SIGNAL SQLSTATE '22003' SET MESSAGE_TEXT = 'Invalide payment amount';
END IF;
	UPDATE
	invoices i
SET
	i.payment_total = payment_amount,
	i.payment_date = payment_date
WHERE
	i.invoice_id = invoice_id;
END$$
delimiter ;
SELECT
	*
FROM
	invoices i;
CALL make_payment(2,
	29853.54,
	'2022-12-22');
    
-- PROCEDURE OUTPUT
DROP PROCEDURE IF EXISTS get_unpaid_invoices_for_client;

delimiter $$
CREATE PROCEDURE get_unpaid_invoices_for_client(client_id INT, out invoices_count int, out invoices_total decimal(9,2))
BEGIN
select COUNT(*), SUM(invoice_total) into invoices_count, invoices_total from invoices i where i.client_id = client_id and payment_total = 0;
END $$
delimiter ;

SELECT * FROM invoices;

call get_unpaid_invoices_for_client(3);

-- USER OR SESSION VARIABLE
set @invoices_count = 0;
set @invoices_total = 0;

-- LOCAL VARIABLE

Delimiter $$
create procedure get_risk_factor()
begin
	DECLARE risk_factor decimal(9,2) default 0;
    declare invoices_total decimal(9,2);
    declare invoices_count int;
    
    select count(*), sum(invoice_total) into invoices_count, invoices_total from invoices;
	set risk_factor = invoices_total / invoices_count * 5;
    select risk_factor;
end$$
Delimiter ;

call get_risk_factor();


-- Functions
delimiter $$
Create Function get_risk_factor_for_client(client_id int)
returns integer
deterministic
reads sql data
-- modifies sql data
begin
	DECLARE risk_factor decimal(9,2) default 0;
    declare invoices_total decimal(9,2);
    declare invoices_count int;
    
    select count(*), sum(invoice_total) into invoices_count, invoices_total from invoices i where i.client_id = client_id;
	set risk_factor = invoices_total / invoices_count * 5;
    return ifnull(risk_factor,0);

end $$
delimiter  ;
drop function if exists get_risk_factor_for_client;
select client_id, name, get_risk_factor_for_client(client_id) from clients;


-- other conventions



