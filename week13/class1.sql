CREATE FUNCTION sum_n_product(x int, y int, OUT sum int, OUT prod int) AS $$
BEGIN
    sum := x + y;
    prod := x * y;
END;
$$ LANGUAGE plpgsql;
 


DO
$$
DECLARE
   out_sum int := 0;
   out_product int := 0;
BEGIN

	SELECT * INTO out_sum, out_product FROM sum_n_product(4, 7);


	RAISE NOTICE 'Output Sum %', out_sum;
	RAISE NOTICE 'Output Prod %', out_product;
END 
$$ LANGUAGE plpgsql;

