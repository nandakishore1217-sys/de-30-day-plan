create database de_practise;
use de_practise

create table Customers(
id int,
name varchar(50)
);

insert into Customers values
(1, 'Asha'),
(2, 'Ravi'),
(3, 'Meena'),
(4, 'Kiran');


CREATE TABLE orders (
    order_id    INT,
    customer_id INT
);

INSERT INTO orders VALUES
(101, 1),
(102, 1),
(103, NULL),
(104, 3);




CREATE TABLE products (
    product_id   INT,
    product_name VARCHAR(50)
);
INSERT INTO products VALUES
(1, 'Laptop'),
(2, 'Mouse'),
(3, 'Keyboard'),
(4, 'Monitor'),
(5, 'Webcam');

CREATE TABLE sales (
    sale_id    INT,
    product_id INT,
    amount     INT
);
INSERT INTO sales VALUES
(1, 1, 50000),
(2, 1, 52000),
(3, NULL, 800),
(4, 3, 1500);

select * from Customers
select * from orders
select * from sales
select * from products

--Q1.  "Show the names of customers who have never placed an order. Use NOT IN. 
select name from Customers
where id not in (select customer_id from orders)

---Q2.Show the names of customers who have never placed an order. 

select name from Customers as c
where NOT EXISTS ( select 2  from orders as o
where c.id = o.customer_id
)

---Q3)  Show the names of customers who have never placed an order.

select name from Customers as c
left join orders as o
on c.id = o.customer_id
where o.customer_id is null

--Q4) Show the names of customers who have never placed an order.
select name from Customers 
where id not in (
select customer_id from orders
where customer_id is not null)

-- these above are all same questions but what is importent to be noted is that when an NULL value exists in the table always
--make sure to use any of the above last 3 type , not the 1st one 

---another type

--Q)Show the names of customers who have placed at least one order. Each customer must appear only once."

select name from Customers as c where exists (
select 1 from orders as o
where c.id = o.customer_id )


--Q) Show the names of customers who have placed at least one order. Each customer must appear only once.
select name from Customers 
where id in (select customer_id from orders)

--Q)Show the names of products that have never been sold."

select product_name from products as p
where not exists ( select 1 from sales as s
where p.product_id = s.product_id)




---Q) INSERT INTO orders VALUES (105, 2); "Add one more order, then rerun your Q1 NOT IN query. Does it still return 0 rows? Explain why."
INSERT INTO orders VALUES (105, 2);


select name from Customers 
where id not in (
select customer_id from orders)

/*Term	    Simple definition
NULL	     A cell where the value is unknown or missing. It is not zero and not empty text.
UNKNOWN	    The result of comparing anything with NULL. It is neither TRUE nor FALSE.
Three-valued     logic	SQL conditions can be TRUE, FALSE, or UNKNOWN (three outcomes, not two).
Non-NULL value  	A cell that holds a real value.
Subquery	    A query written inside brackets, inside another query.
Correlated subquery 	A subquery that uses a column from the outer query, so it runs once for each outer row.
Existence check	         Asking "does at least one matching row exist?" without needing its data.
Semi-join	                 Rows from table A that have a match in table B, each shown once.
Anti-join	                  Rows from table A that have no match in table B.
LEFT JOIN                    anti-join	A LEFT JOIN followed by WHERE right_column IS NULL, which keeps only the unmatched left rows.
Left table / right table	    The left table is the one whose rows you want in the result. The right table is the one you check for matches.
Aggregate function          	A function that turns many rows into one result, like COUNT, SUM, AVG, MIN, MAX.
Alias	                    A short nickname for a table or column (c for customers).
Qualified column            	A column written with its table name or alias (c.name), so it is clear where it comes from.
SQL dialect	                The flavour of SQL a specific database understands (MySQL, Postgres, Snowflake).*/





------------------------------------LEAD AND LAG

CREATE TABLE daily_sales (
    sale_date DATE,
    amount    INT
);
INSERT INTO daily_sales VALUES
('2026-09-01', 100),
('2026-09-02', 150),
('2026-09-03', 120),
('2026-09-04', 200),
('2026-09-05', 180);


select * from daily_sales;
---Q)Show each sale_date, its amount, and the previous day's amount (prev_amount).
select sale_date,amount,
lag(amount) over(order by sale_date ) as prev_sales
from daily_sales


---Q)Do the same, but show 0 instead of NULL for the first day.
select sale_date,amount,
lag(amount,1,0) over(order by sale_date ) as prev_sales
from daily_sales

----Q). Show sale_date, amount, and the next day's amount (next_amount). Show NULL on the last day.

select sale_date,amount,lead(amount) over(order by sale_date) as next_amount 
from daily_sales

--Q)Show sale_date, amount, and the amount from 2 days later. Show -1 when there is no such row
select sale_date,amount,lead(amount,2,-1) over(order by sale_date) as next_amount 
from daily_sales

--Q). Show sale_date, amount, and the change from the previous day (amount - previous amount). The first day should show NULL, not a made-up number.
select sale_date,amount-lag(amount) over(order by sale_date) as diff_amount
from daily_sales

---or----using subquery
select sale_date,
amount-prev_amount as changed_amount 
from(
select sale_date,amount,lag(amount) over(order by sale_date)
as prev_amount
from daily_sales)as X


-----------------------
CREATE TABLE product_sales (
    product   VARCHAR(20),
    sale_date DATE,
    amount    INT
);
INSERT INTO product_sales VALUES
('Laptop',   '2026-09-01', 500),
('Laptop',   '2026-09-02', 550),
('Laptop',   '2026-09-03', 520),
('Mouse',    '2026-09-01', 20),
('Mouse',    '2026-09-02', 25),
('Mouse',    '2026-09-03', 30);


select * from product_sales


------------------------now with partition by ---------------
--Q)Show product, sale_date, amount, and the previous day's amount for the same product (prev_amount).

select sale_date,
amount,
product,
lag(amount) over (
partition by product
order by sale_date ) as prev_amount
from  product_sales


---Q)Show product, sale_date, amount, and the change from the previous day within the same product (change_amount). 
----The first day of each product should be NULL.

select sale_date,
product,amount-
lag(amount) over(
partition by product
order by sale_date) as diff_sales
from product_sales


----------Q). First run the query from Q6 without PARTITION BY (only ORDER BY product, sale_date).
------------Look at the first Mouse row. What does its prev_amount show, and why is that a bug?

--ANS: its bcz its an product category as its the first mouse in that category so it doesnt have an prev one so its NULL
select sale_date,
amount,
product,
lag(amount) over (order by sale_date ) as prev_amount
from  product_sales


---------------------------now doing the LAG comparission--

select * from daily_sales
select * from product_sales

--Q)Using daily_sales, show the days where amount was higher than the previous day. Use a derived table.

select * from (
select amount, sale_date,lag(amount) over(
order by sale_date) as prev_sales
from daily_sales) as X
where amount > prev_sales



--Q)10. Solve Q9 again using a CTE
with CTE as (
select amount,sale_date,lag(amount) over (order by sale_date) as prev_sales
from daily_sales)  
select * from CTE 
where amount > prev_sales


---Q)11: using product_sales, show the rows where the amount dropped compared to the previous day of the same product.
---Show product, sale_date, amount, and prev_amount.
select * from (
select sale_date,amount,product,lag(amount) over(
partition by product 
order by sale_date) as prev_sales 
from product_sales) as x
where amount < prev_sales

---Q)12 in your own words, why can't LAG go directly in WHERE?

/* LAG cannot go with  where bcz the sql order of execution sequence doesnt match with 
    where execution with LAG 
    where comes before lag so it will give an error */


