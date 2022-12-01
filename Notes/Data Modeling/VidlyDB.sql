drop database if exists sql_store2;
create database if not exists sql_store3;
use sql_store3;
drop table if exists orders;
drop table if exists customers;
create table if not exists customers
(
    customer_id int primary key auto_increment,
    first_name  varchar(50)  not null,
    points      int          not null default 0,
    email       varchar(255) not null unique
);

-- Modify Table
ALTER table customers
    add last_name varchar(50) not null after first_name,
    add city      varchar(50) not null,
    modify column first_name varchar(55) default '',
    drop points;

drop table if exists orders;
create table if not exists orders (
    order_id int primary key,
    customer_id int not null,
    foreign key fk_orders_customers (customer_id)
                                  references customers (customer_id)
                                  on update cascade # no action, set null, cascade, restrict
                                  on delete no action
);


-- altering primary key, foreign key
alter table orders
#     add primary key order_id,
    drop primary key,
    drop foreign key orders.orders_ibfk_1,
    add foreign key fk_orders_customers (customer_id) references customers (customer_id)
    on update cascade
    on delete no action;

# character set
show character set;

# change character set
# alter table table_name () character set latin_1

#storage engines
show engines;

alter table customers engine = innoDB