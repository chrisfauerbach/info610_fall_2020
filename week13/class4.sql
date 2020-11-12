CREATE TABLE foo (fooid INT, foosubid INT, fooname TEXT);
INSERT INTO foo VALUES (1, 2, 'three');
INSERT INTO foo VALUES (4, 5, 'six');

SELECT * FROM foo;

SELECT * FROM foo
    WHERE fooid > 0;

CREATE OR REPLACE FUNCTION getAllFoo(input_value int) RETURNS SETOF foo AS
$$
DECLARE
    r foo%rowtype;
BEGIN
    FOR r IN SELECT * FROM foo
    WHERE fooid > input_value
    LOOP
        -- can do some processing here
        RETURN NEXT r; -- return current row of SELECT
    END LOOP;
    RETURN;
END
$$
LANGUAGE 'plpgsql' ;


SELECT * FROM getallfoo(1);
