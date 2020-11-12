DROP TABLE SALES;
DROP FUNCTION extended_sales;

CREATE TABLE sales(itemno serial primary key, quantity int, price int);

INSERT INTO sales (quantity, price) values (30, 355), (20, 5324);


CREATE FUNCTION extended_sales(p_itemno int)
RETURNS TABLE(quantity int, total sales.price%TYPE) AS $$
BEGIN
    RETURN QUERY SELECT s.quantity, s.quantity * s.price FROM sales AS s
                 WHERE s.itemno = p_itemno;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM extended_sales(1);
SELECT * FROM extended_sales(2);
