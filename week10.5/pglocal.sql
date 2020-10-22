DROP TRIGGER trigger_employee_salary ON employee;
DROP TRIGGER trigger_employee_vacation ON employee;

DROP TABLE IF EXISTS vacation_balance;
DROP TABLE IF EXISTS salary;
DROP TABLE IF EXISTS employee;


CREATE TABLE employee (id serial primary key,-
       fname varchar, lname varchar,-
       start_date date,-
       insert_ts timestamp default now(),-
       last_update_ts timestamp default now());

CREATE TABLE vacation_balance(employee_id int primary key,
       year int, vacation_balance int,
       foreign key (employee_id) REFERENCES employee(id));

CREATE TABLE salary(employee_id int primary key,
       annual_salary int,
       effective_ts timestamp default now(),
       foreign key (employee_id) REFERENCES employee(id));
       
       
CREATE OR REPLACE FUNCTION add_new_salary() RETURNS TRIGGER AS $example_table$
   BEGIN
      INSERT INTO salary(employee_id, annual_salary)
      VALUES (new.id,  0);
      RETURN NEW;
   END;
$example_table$ LANGUAGE plpgsql;


       
CREATE OR REPLACE FUNCTION add_new_vacation() RETURNS TRIGGER AS $example_table$
   BEGIN
      INSERT INTO vacation_balance(employee_id, year, vacation_balance)
      VALUES (new.id, EXTRACT(YEAR FROM NOW()), 0);
      RETURN NEW;
   END;
$example_table$ LANGUAGE plpgsql;


select 'Make Trigger Employee Salary'

CREATE  TRIGGER trigger_employee_salary
    AFTER INSERT ON employee
    FOR EACH ROW
    EXECUTE PROCEDURE add_new_salary();

select 'Make Trigger Employee Vacation'

CREATE  TRIGGER  trigger_employee_vacation
    AFTER INSERT ON employee
    FOR EACH ROW
    EXECUTE PROCEDURE add_new_vacation();
 
DELETE FROM VACATION_BALANCE;
DELETE FROM SALARY;
DELETE FROM EMPLOYEE;

SELECT * FROM SALARY;   
SELECT * FROM VACATION_BALANCE;
INSERT INTO employee(fname, lname, start_date) VALUES ('Chris', 'Fauerbach', '01-01-2001');

SELECT * FROM SALARY;
SELECT * FROM VACATION_BALANCE;
    