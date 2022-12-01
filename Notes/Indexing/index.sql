# Indexing
# indexes speed up our queries
select *
from customers

# increase the database
# slow down the writes operation
# for this reserve indexes for performance critical queries
# Design indexes based on your queries, not your tables, do not try to index every column


# Creating an index

explain
select customer_id
from customers
where state = 'CA';

select count(*)
from customers;

create index idx_state on customers (state);

explain
select points
from customers
where points > 1000;

create index idx_points on customers (points);

show indexes in customer;
show indexes in orders;
analyze table customers;

# Prefixing index
# smaller index are better

create index idx_lastname on customers (last_name(20));

select count(*)
from customers;

select count(distinct LEFT(last_name, 10))
from customers;

# 'react redux'

use sql_blog;

select *
from posts
where title like '%react redux%'
   or body like '%react redux%';

create fulltext index idx_title_body on posts (title, body);

select *, match(title, body) against('react redux')
from posts
where match(title, body) against('react -redux +form' in boolean mode);

use sql_store;
show indexes in customers;

explain
select customer_id
from customers
where state = 'CA'
  and points > 1000;

# Composite indexes
create index idx_state_point on customers (state, points);

explain
select customer_id
from customers
where state = 'ca'
  and points > 1000;

drop index idx_state on customers;
drop index idx_points on customers;
show indexes in customers;

# Order of columns
# Put the frequently used columns first
# Put the columns with cardinality first
# cardinality represent number of unique values
# more cardinality keep it first

explain
select customer_id
from customers use index (idx_state_last_name)
where state like 'A%'
  and last_name like 'A%';
select count(distinct state), count(distinct last_name)
from customers;
# state = 48, last_name = 996
# We will choose last_name first in indexing because it's cardinality or uniqueness more than state
create index idx_last_name_state on customers (last_name, state);
create index idx_state_last_name on customers (state, last_name);


drop index idx_last_name_state on customers;

show indexes in customers;

# frequently used columns
# High Cardinality columns
# Take your queries into account

# When Indexes are ignored
explain
select customer_id
from customers
where state = 'CA'
   or points > 1000;

create index idx_points on customers (points);

explain
select customer_id
from customers
where state = 'CA'
union
select customer_id
from customers
where points > 1000;

# using indexing for sorting
show indexes in customers;

explain
select customer_id
from customers
order by first_name;

show status like 'last_query_cost';

# (a,b)
# a
# a, b
# a DESC, b DESC
# a, c, b


