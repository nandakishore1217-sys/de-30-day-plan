----merge-------------------
DROP TABLE IF EXISTS products_target;
DROP TABLE IF EXISTS products_new;

CREATE TABLE products_target (
    product_id   INT PRIMARY KEY,
    product_name VARCHAR(30),
    price        INT
);
INSERT INTO products_target VALUES
(1, 'Laptop',   50000),
(2, 'Mouse',    500),
(3, 'Keyboard', 1500);

CREATE TABLE products_new (
    product_id   INT PRIMARY KEY,
    product_name VARCHAR(30),
    price        INT
);
INSERT INTO products_new VALUES
(2, 'Mouse',    600),
(3, 'Keyboard', 1500),
(4, 'Monitor',  12000);



select * from products_target
select * from products_new

merge products_target as t
using products_new as s
 on t.product_id = s.product_id
 when matched then 
 update set t.product_name = s.product_name,
 t.price = s.price
 when not matched by target then
 insert(product_id,product_name,price)
 values(s.product_id,s.product_name,s.price);


 select * from products_target
 order by product_id
/*---------------this is before mergring checking if the source column has any chaes in value or the same and then 
--updating the target column */
 merge products_target as t
 using products_new as s
 on t.product_id = s.product_id
 when matched 
 and t.price <> s.price  --here is the check ing condition
 then 
 update set t.product_name = s.product_name,
 t.price = s.price

 when not matched by target
 then 
 insert(product_id,product_name,price)
 values(s.product_id,s.product_name,s.price);


 --//---the same above one when an null value is preset in the source table then

 DROP TABLE IF EXISTS products_new_null_test;

CREATE TABLE products_new_null_test (
    product_id   INT PRIMARY KEY,
    product_name VARCHAR(30),
    price        INT
);

INSERT INTO products_new_null_test VALUES
(1, 'Laptop', 55000),      -- normal change
(2, 'Mouse', NULL),        -- 500 -> NULL
(3, 'Keyboard', 1500),     -- no change
(5, 'Webcam', 800);        -- target doesn't have this row

select * from products_new_null_test


merge products_target as t
using products_new_null_test as s
on t.product_id = s.product_id

when matched 
and (
t.price<>s.price
or( t.price is null and s.price is not null)
or( t.price is not null and s.price is null)
)
then
update set t.product_name = s.product_name,
t.price = s.price

when not matched by target then 
insert(product_id,product_name,price)
values(s.product_id,s.product_name,s.price);

select * from products_target


--/// now the same table, what if the target rows  doesnt match with the source table rows 
--/////ex  is like if the target  table has product id 1,2,3 and source table has 1,2 only 
-- but the source table is the actual required model then we ahve to delete the extra row from the target table 

DROP TABLE IF EXISTS products_target_delete_test;
DROP TABLE IF EXISTS products_snapshot;

CREATE TABLE products_target_delete_test (
    product_id   INT PRIMARY KEY,
    product_name VARCHAR(30),
    price        INT
);

INSERT INTO products_target_delete_test VALUES
(1, 'Laptop',   50000),
(2, 'Mouse',      500),
(3, 'Keyboard',  1500);

CREATE TABLE products_snapshot (
    product_id   INT PRIMARY KEY,
    product_name VARCHAR(30),
    price        INT
);

INSERT INTO products_snapshot VALUES
(1, 'Laptop', 50000),
(2, 'Mouse',    600);

select * from products_target_delete_test
select * from products_snapshot


merge products_target_delete_test as t
using products_snapshot as s
on t.product_id = s.product_id

when matched 
and( 
t.price<> s.price
or(t.price is null and s.price is not null)
or(t.price is not null and s.price is null)
)
then 
update set t.product_name = s.product_name,
t.price = s.price

when not matched by target then
insert(product_id,product_name,price)
values(s.product_id,s.product_name,s.price)

when not matched by source    --// this will delete from the target table 
then 
delete;


select * from products_target_delete_test --//here only 2 rows are present noe as in source
order by product_id 



/*WHEN NOT MATCHED BY TARGET ==  applies when a source row has no matching target row
typically to insert the new row. 
WHEN NOT MATCHED BY SOURCE ===applies when a target row has no matching source row,
typically to delete or deactivate the target row.*/


/* if not present in target insert it 
if not present in source presetn in target then delete it*/



--//=============================execution order in data base ============
/* the order of execution in sql is the step by step query execution in database
so to make the quering faster we use index seek for faster quering 
index : is an ordered  look up structure whcih data base used to faster quering 

TYPES OF INDEX:

1) clustered index:
these are sorted insorted order by the key 
each table can have only one clustered index
its created automatically by PRIMARY_KEY(by default)*/


DROP TABLE IF EXISTS orders_demo;
CREATE TABLE orders_demo (
    order_id      INT,
    customer_name VARCHAR(30),
    city          VARCHAR(30)
);
INSERT INTO orders_demo VALUES
(103, 'Meena', 'Pune'),
(101, 'Asha',  'Delhi'),
(105, 'Ravi',  'Mumbai'),
(102, 'Kiran', 'Chennai'),
(104, 'Divya', 'Pune');


select * from orders_demo   --//this is an existing table check the table index(now it is changed)


create clustered index cix_order_demo_order_id
on orders_demo(order_id);


select * from orders_demo

create nonclustered index ix_order_demo_customer_name
on orders_demo(customer_name)


select * from orders_demo

SELECT customer_name, order_id
FROM orders_demo WITH (INDEX(ix_order_demo_customer_name))
ORDER BY customer_name;


SELECT name, type_desc
FROM sys.indexes
WHERE object_id = OBJECT_ID('orders_demo');






---=================order of execution================
DROP TABLE IF EXISTS orders_big;
CREATE TABLE orders_big (
    order_id      INT,
    customer_name VARCHAR(30),
    city          VARCHAR(30)
);

INSERT INTO orders_big
SELECT TOP (100000)
    ROW_NUMBER() OVER (ORDER BY (SELECT NULL)),
    'Customer' + CAST(ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS VARCHAR(10)),
    CASE ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) % 4
        WHEN 0 THEN 'Pune' WHEN 1 THEN 'Delhi'
        WHEN 2 THEN 'Mumbai' ELSE 'Chennai' END
FROM sys.all_objects a CROSS JOIN sys.all_objects b;

CREATE CLUSTERED INDEX cix_orders_big_order_id ON orders_big (order_id);


select * from orders_big

SELECT * FROM orders_big WHERE customer_name = 'Customer77777';