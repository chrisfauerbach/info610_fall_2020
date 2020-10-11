DROP TABLE IF EXISTS CUSTOMERS, CUSTOMER, BRANCHES;

CREATE TABLE branches (id serial primary key, name varchar);
CREATE TABLE customers (
id serial primary key, 
branch_id int references branches(id), 
name varchar, balance float );
INSERT INTO branches(id, name) values (1, 'home');
INSERT INTO customers(name, branch_id, balance) values ('chris', 1, 10000), ('joe', 1, 33333), ('ted', 1, 321);

SELECT * FROM BRANCHES;

SELECT * FROM customers;

BEGIN;
UPDATE customers set balance = 0 where name = 'chris';

IF 
  SAVEPOINT
   UPDATE customers set branch_id = 2;
   ROLL TO SAVEPOINT
ELSE:
   COMAASDKF

COMMIT; 
ROLLBACK;
