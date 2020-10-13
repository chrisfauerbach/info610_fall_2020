CREATE TABLE 
employee_salary(id SERIAL PRIMARY KEY, department varchar, 
employee_number int, salary int);
INSERT INTO employee_salary(department, employee_number, salary) 
VALUES
  ('develop',11,5200),
  ('develop',7,4200),
  ('develop',9,4500),
  ('develop',8,6000),
  ('develop',10,5200),
  ('personnel',5,3500),
  ('personnel',2,3900),
  ('sales',3,4800),
  ('sales',1,5000),
  ('sales',4,4800);

SELECT * FROM employee_salary;

SELECT  department, round(avg(salary), 2)
FROM employee_salary GROUP BY   department;


---   4, sales, 4866.67
----  1, sales, 4866.67

---- #, avg dept, delta 

CREATE VIEW avg_salary as SELECT department dt2, round(avg(salary), 2) avg_salary FROM employee_salary GROUP BY department;

SELECT * FROM avg_salary;

SELECT employee_number, salary, department, avg_salary FROM employee_salary
INNER JOIN avg_salary on department = dt2
 
 
SELECT department, employee_number, salary, 
avg(salary)  OVER (PARTITION BY department) 
FROM employee_salary;


SELECT department, employee_number, salary, 
avg(salary)  OVER (partition  by department) 
FROM employee_salary;



SELECT department, employee_number, salary, 
avg(salary)  OVER () 
FROM employee_salary;

SELECT avg(salary) FROM employee_salary;

SELECT department, employee_number, salary, 
avg(salary)  OVER () 
FROM employee_salary
WHERE employee_number < 8;

SELECT department, employee_number, salary, 
max(salary) OVER (PARTITION BY department) ,
min(salary) OVER (PARTITION BY department) ,
avg(salary) OVER (PARTITION BY department) ,
max(salary) OVER ( ) ,
min(salary) OVER ( ) ,
avg(salary) OVER ( ) 
FROM employee_salary
WHERE employee_number < 8;


SELECT department, employee_number, salary
, rank() OVER (PARTITION BY department ORDER BY salary DESC) 
FROM employee_salary;


SELECT department, employee_number, salary
, rank() OVER (  ORDER BY salary DESC) 
FROM employee_salary;

SELECT * FROM employee_salary ORDER BY department desc, salary desc



SELECT salary, sum(salary) OVER (ORDER BY salary) FROM employee_salary;


-- TABLE
-- JOINS (add extras table)
-- FILTER  (Where clause)
-- GROUP BY
-- AGGREGATE FUNCTIONS
-- HAVING FILTER 

-- Return the result set


CREATE TABLE transactions (id serial primary key, value float, description varchar);
INSERT INTO transactions (value, description) values (100, 'Paycheck'), ( -20 , 'ATM Withdrawal');

SELECT description, value, sum(value) OVER (ORDER BY id) FROM transactions;




