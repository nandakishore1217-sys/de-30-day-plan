create database SCD

DROP TABLE IF EXISTS stg_customer;
DROP TABLE IF EXISTS dim_cust_t1;
DROP TABLE IF EXISTS dim_cust_t2;
DROP TABLE IF EXISTS dim_cust_t3;

-- Incoming data (today's file)
CREATE TABLE stg_customer (
    customer_id INT,
    name        VARCHAR(30),
    city        VARCHAR(30),
    change_date DATE
);

INSERT INTO stg_customer VALUES
(101, 'Asha',  'Delhi',   '2026-10-01'),
(102, 'Ravi',  'Mumbai',  '2026-10-01'),
(103, 'Meena', 'Chennai', '2026-10-01');

CREATE TABLE dim_cust_t1 (
    customer_id INT PRIMARY KEY,
    name        VARCHAR(30),
    city        VARCHAR(30)
);
INSERT INTO dim_cust_t1 VALUES 
(101, 'Asha', 'Pune'),
(102, 'Ravi', 'Mumbai');


select * from dim_cust_t1
select * from stg_customer

--///this is to update an existing customer city which got updated now
update dim_cust_t1 
set dim_cust_t1.city = s.city
from dim_cust_t1 as t
join stg_customer as s
on t.customer_id = s.customer_id

select * from dim_cust_t1


--//now we need to insert the customer id that is not present in the target table 
insert into dim_cust_t1(customer_id,name,city)
select s.customer_id,s.name,s.city 
from stg_customer as s 
where NOT EXISTS (
select 1 from dim_cust_t1 as t
where t.customer_id= s.customer_id);


select * from dim_cust_t1



--///  SCD  TYPE 2============================

CREATE TABLE dim_cust_t2 (
    customer_sk INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT,
    name        VARCHAR(30),
    city        VARCHAR(30),
    start_date  DATE,
    end_date    DATE,
    is_current  BIT
);
INSERT INTO dim_cust_t2 (customer_id, name, city, start_date, end_date, is_current)
VALUES (101, 'Asha', 'Pune',   '2024-01-01', NULL, 1),
       (102, 'Ravi', 'Mumbai', '2024-01-01', NULL, 1);


select * from stg_customer
select * from dim_cust_t2

update dim_cust_t2
set dim_cust_t2.end_date = s.change_date,
dim_cust_t2.is_current = 0  --//this is the condition for making the value is changed indication
from stg_customer as s
join dim_cust_t2 as t
on t.customer_id = s.customer_id
where t.is_current =1 and t.city! = s.city




select * from dim_cust_t2



insert into dim_cust_t2(customer_id,name,city,start_date,end_date,is_current)
select s.customer_id,s.name,s.city,s.change_date,null,1
from stg_customer as s
where not exists (select 1 from dim_cust_t2  as t
where t.customer_id=s.customer_id and t.is_current=1);

select * from dim_cust_t2





















