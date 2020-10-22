--- CREATE TABLE
--- CREATE FUNCTION
--- CREATE TRIGGER


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

CREATE TRIGGER trigger_employee_salary
    AFTER INSERT ON employee
    FOR EACH ROW
    EXECUTE PROCEDURE add_new_salary();
	
CREATE TRIGGER trigger_employee_vacation
    AFTER INSERT ON employee
    FOR EACH ROW
    EXECUTE PROCEDURE add_new_vacation();

DROP TRIGGER trigger_employee_vacation on employee;
DROP TRIGGER trigger_employee_salary on employee;

INSERT  INTO employee(fname, lname, start_date) 
   VALUES ('Chris', 'Fauerbach', '01-01-2001');
commit;
	
INSERT  INTO employee(fname, lname, start_date) 
   VALUES ('Joe', 'Schmoe', '10-31-2001');
commit;

select * from employee 
LEFT OUTER JOIN vacation_balance on vacation_balance.employee_id = employee.id
LEFT OUTER JOIN salary on salary.employee_id = employee.id






CREATE TABLE emp (
    empname text,
    salary integer,
    last_date timestamp,
    last_user text
);


CREATE OR REPLACE FUNCTION emp_stamp() RETURNS trigger AS $emp_stamp$
    BEGIN
        -- Check that empname and salary are given
        IF NEW.empname IS NULL THEN
            RAISE EXCEPTION '%: new empname cannot be null', OLD.empname;
        END IF;
        IF NEW.salary IS NULL THEN
            RAISE EXCEPTION '% cannot have null salary', NEW.empname;
        END IF;
        -- Who works for us when she must pay for it?
        IF NEW.salary < 0 THEN
            RAISE EXCEPTION '% cannot have a negative salary', NEW.empname;
        END IF;
        -- Remember who changed the payroll when
        
		NEW.last_date := current_timestamp;
		
--		WHERE last_date = current_timestamp
		
		IF NEW.last_date <= OLD.last_date THEN
		    RAISE EXCEPTION 'New TS % cannot be before Old TS: %', NEW.last_date, OLD.last_date;
		END IF;
		IF NEW.empname <> OLD.empname THEN
		    RAISE EXCEPTION 'New Employee name % cannot be different from old: %', NEW.empname, OLD.empname;
		END IF;
		
        NEW.last_user := current_user;
        RETURN NEW;
    END;
$emp_stamp$ LANGUAGE plpgsql;
CREATE TRIGGER emp_stamp BEFORE INSERT OR UPDATE ON emp
    FOR EACH ROW EXECUTE PROCEDURE emp_stamp();
	


CREATE TABLE emp_history(empname text,
    salary integer,
    last_date timestamp,
    last_user text
);

INSERT INTO emp (empname, salary) values ('Chris', 10000);

SELECT * FROM emp;

UPDATE emp set salary = -20 where empname = 'Chris';

UPDATE emp set empname = NULL where empname = 'Chris';


---  BEFORE (n)
---     PERSISTED - recorded and saved
---  AFTER (m)


CREATE OR REPLACE FUNCTION emp_backup() RETURNS trigger AS $emp_backup$
    BEGIN
        INSERT INTO emp_history( empname, salary ,last_date,last_user) VALUES
		    (old.empname, old.salary, old.last_date, old.last_user);
        RETURN NEW;
    END;
$emp_backup$ LANGUAGE plpgsql;


CREATE TRIGGER emp_backup BEFORE DELETE OR UPDATE ON emp
    FOR EACH ROW EXECUTE PROCEDURE emp_backup();
	
	
CREATE OR REPLACE FUNCTION emp_add_one() RETURNS trigger AS $emp_add_one$
    BEGIN
        new.salary := new.salary + 1;
		RETURN NEW;
    END;
$emp_add_one$ LANGUAGE plpgsql;


CREATE TRIGGER emp_add_one_trigger BEFORE DELETE OR UPDATE ON emp
    FOR EACH ROW EXECUTE PROCEDURE emp_add_one();
	
CREATE OR REPLACE FUNCTION emp_add_two() RETURNS trigger AS $emp_add_two$
    BEGIN
        new.salary := new.salary + 2;
		RETURN NEW;
    END;
$emp_add_two$ LANGUAGE plpgsql;


DROP TRIGGER emp_add_two_trigger on emp;
CREATE  TRIGGER emp_add_two_trigger AFTER DELETE OR UPDATE ON emp
    FOR EACH ROW EXECUTE PROCEDURE emp_add_two();
	
	
	
SELECT * FROM emp;
UPDATE emp set salary = 30000 where empname = 'Chris';
SELECT * FROM emp_history;







