create user john IDENTIFIED BY '1234';
select *
from mysql.user;
-- drop user
drop user mohsin@localhost

-- change password
-- 1: web/desktop application
create user moon_app identified by '1234';

grant select, insert, update, delete, execute on sql_store.*
    to moon_app;
-- 2: admin
grant all on sql_store.* to moon_app;
grant all on *.* to moon_app;

-- Viewing Privileges

show grants for moon_app;


-- Revoke Privileges
GRANT create view on sql_store.* to moon_app;
REVOKE create view on sql_store.* from moon_app;
