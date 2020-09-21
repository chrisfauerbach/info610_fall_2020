DROP TABLE IF EXISTS students;

CREATE TABLE students (id SERIAL primary key, fname varchar, lname varchar, class varchar, gpa decimal);

INSERT INTO students (fname, lname, class, gpa) values ('A','B','2019', 3.90);
INSERT INTO students (fname, lname, class, gpa) values ('B', 'C', '2019', 3.99);
INSERT INTO students (fname, lname, class, gpa) values ('C', 'C', '2019', 2.99);
INSERT INTO students (fname, lname, class, gpa) values ('D', 'C', '2019', 3.99);
INSERT INTO students (fname, lname, class, gpa) values ('E', 'C', '2019', 2.39);
INSERT INTO students (fname, lname, class, gpa) values ('F', 'C', '2019', 3.49);
INSERT INTO students (fname, lname, class, gpa) values ('H', 'C', '2019', 1.99);
INSERT INTO students (fname, lname, class, gpa) values ('I', 'C', '2019', 3.99);
INSERT INTO students (fname, lname, class, gpa) values ('J', 'C', '2019', 0.6);
INSERT INTO students (fname, lname, class, gpa) values ('K', 'C', '2019', 3.2);

INSERT INTO students (fname, lname, class, gpa) values ('J', 'J', '2020', 3.2);

INSERT INTO students (fname, lname, class, gpa) values ('J', 'J', '2021', 4.2);



select max(id) from students;
UPDATE students SET id = id +1 where id = 12;


--   DO NOT DO THIS INSERT INTO students (fname, lname, class, gpa) values ('ShouldFail', 'J', '2021', 4.2);



-- Get all student records
SELECT * FROM students;

--Find the average gpa per class
SELECT class, avg(gpa) FROM students GROUP BY class;

--Find the max GPA per class
SELECT class, max(gpa) FROM students GROUP BY class;

-- Find the student(s) with the max GPA per class
SELECT class, fname, lname, gpa  FROM students 
WHERE (class, gpa) in 
( SELECT class, max(gpa) FROM students GROUP BY class );


-- Find the student with the highest GPA  (only returns one record)
SELECT FNAME, LNAME, GPA FROM students 
ORDER BY GPA DESC, FNAME desc, lname desc LIMIT 1;


-- Find the studentS with the highest GPA (finds all)
SELECT class, fname, lname, gpa  FROM students 
WHERE gpa =  ( SELECT max(gpa) FROM students  );


-- Find how many students per class
SELECT class, count(*) from students GROUP BY class

-- Find how many students per class will graduate 
SELECT class, count(*) from students WHERE gpa >= 2.76 GROUP BY class

-- List students who won't graduate
SELECT * FROM students where gpa < 2.76;

-- find the min, max and avg gpa per class
SELECT class, min(gpa), max(gpa), avg(gpa) from students group by class;

-- What happens when you min/max a string?
SELECT  min(fname), max(lname), min(class), max(class), min(gpa), max(gpa), avg(gpa) from students;