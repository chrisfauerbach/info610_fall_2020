DROP TABLE IF EXISTS table2, table1;


CREATE  TABLE table2(id serial primary key,  
   f3 varchar,   f7 varchar);
INSERT INTO table2(  f3,   f7) values ('a',  'c' );

INSERT INTO table2(  f3,   f7) values ('a',  'c' );



CREATE  TABLE table1(id serial primary key, f1 varchar, 
                     f5 varchar );
INSERT INTO table1(f1,  f5 ) values ('1', '2' );

INSERT INTO table1(f1,  f5 ) values ('5', '9' );


SELECT * FROM table1;
SELECT * FROM table2;

CREATE FUNCTION merge_fields(t_row table1) RETURNS text AS $$
DECLARE
    t2_row table2%ROWTYPE;
BEGIN
    SELECT * INTO t2_row FROM table2 LIMIT 1;
    RETURN t_row.f1 || t2_row.f3 || t_row.f5 || t2_row.f7;
END;
$$ LANGUAGE plpgsql;

SELECT merge_fields(t.*) FROM table1 t  ;

SELECT merge_fields(t.*) FROM table1 t  WHERE id = 1;

SELECT * FROM table1 t;


SELECT * FROM table1 t WHERE id = 1;


   

