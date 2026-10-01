DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

CREATE TABLE departments (
    dept_id   INT,
    dept_name VARCHAR(30)
);
INSERT INTO departments VALUES
(1, 'Sales'),
(2, 'IT'),
(3, 'HR'),
(4, 'Finance');

CREATE TABLE employees (
    emp_id   INT,
    emp_name VARCHAR(30),
    dept_id  INT,
    salary   INT
);
INSERT INTO employees VALUES
(1, 'Asha',   1, 50000),
(2, 'Ravi',   1, 60000),
(3, 'Meena',  2, 80000),
(4, 'Kiran',  2, 90000),
(5, 'Suresh', 2, 70000),
(6, 'Divya',  3, 45000),
(7, 'Arjun',  3, 55000),
(8, 'Priya',  1, 40000);


--Q1)Show the name and salary of employees who earn more than the company average salary."
select * from employees where salary > (
select avg(salary) as avg_salary from employees)

--Q2). "Show the names of departments that have at least one employee." (this is an corelated one)
select d.dept_name from departments as d
where exists (
select 1 from  employees as e
where e.dept_id = d.dept_id
) ;

--Q2) same question in non-corelated way

select dept_name from departments
where dept_id in (select dept_id from employees)



--Q3)Show the names of departments that have no employees."
select dept_name from  departments as d
where not exists(
select 1 from employees as e
where e.dept_id= d.dept_id)


select * from employees
select * from departments
------------------ from type questions--------------
---Q1)Show each department's average salary, but only for departments where the average is above 60000."
select * from (
select dept_id, avg(salary) as avg_salary from employees 
group by dept_id) as X
where avg_salary > 60000


------select type --------------------------
--Q1)Show each employee's name, salary, and the company average salary as a third column.
select e1.emp_name,e1.salary,
(select avg(salary) as cmpny_avg_salary
from employees as e2
) as compy_avg
from employees as e1

--Q2)Show each employee's name, salary, and the number of employees in their own department (dept_headcount).
select e2.emp_name,e2.salary,(
select count(*) from employees  as e1
where e1.dept_id = e2.dept_id
) as dept_headcount
from employees  as e2


-----===========================CTE================================================================

select * from employees
select * from departments

---Q)Show the name and salary of employees who earn more than the company average salary."

with avg_sal as (
select avg(salary) as avg_salary from employees
)
select emp_name,salary 
from employees 
where salary > (select avg_salary from avg_sal)


--Q)"Show the department name and the number of employees, only for departments with 3 or more employees."

with dept_count as(
select dept_id,count(*) as head_count
from employees
group by dept_id
),
dept_named as(
select dept_name,c.head_count
from dept_count as c
join departments as d
on c.dept_id = d.dept_id
)

select dept_name,head_count
from dept_named
where head_count >= 3


--Q)show the department name and the total salary paid, only for departments where the total salary is 150000 or more.
with det_sal as(
select dept_id,sum(salary) as total_sal_paid from employees
group by dept_id
),
dept_named as(
select dept_name,s.total_sal_paid
from det_sal as s
join departments as d
on s.dept_id = d.dept_id
)
select dept_name,total_sal_paid
from dept_named 
where total_sal_paid >=150000


--Q)Show each employee's name, salary, and department name, only for employees who earn more than their own department's average salary."
with det_avg as(
select dept_id,avg(salary) as avg_det_sal from employees
group by dept_id
)
select dept_name,salary from employees as e
join departments as d
on e.dept_id = d.dept_id
join det_avg as a 
on a.dept_id = e.dept_id
where salary > avg_det_sal

--===============================sessions===============================

DROP TABLE IF EXISTS clicks;
CREATE TABLE clicks (click_time DATETIME);
INSERT INTO clicks VALUES
('2026-10-01 10:00'),
('2026-10-01 10:05'),
('2026-10-01 10:20'),
('2026-10-01 11:30'),
('2026-10-01 11:35');


select * from clicks


with gaps as (
select click_time,
lag(click_time) over(order by click_time) as prev_click
from clicks
),
flagged as(
select click_time,
case when prev_click is null
or datediff(minute,prev_click,click_time)>30
then 1 else 0 end  as is_new_session
from gaps
),
numbered as(
select click_time,
sum(is_new_session) over(order by click_time
rows unbounded preceding
) as session_id
from flagged
)
 
 -----------last_value --------------
 DROP TABLE IF EXISTS daily_sales;
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


select * from daily_sales

--this gives the new column only the last value onlyand not for all rows
select sale_date,amount,
last_value(amount) over(order by sale_date) as lst_value
from daily_sales

--to ver come this we use the over bound--------
select sale_date,amount,
last_value(amount) over(order by sale_date
rows between unbounded preceding and unbounded following
) as lat_value
from daily_sales
