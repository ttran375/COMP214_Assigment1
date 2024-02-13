-- Question 1 List all products whose unit price is less than the average 
-- price. 1 mark
SELECT PRODUCT_ID, PRODUCT_NAME, UNITPRICE
FROM
    PRODUCTS
WHERE
    UNITPRICE < (
        SELECT AVG(UNITPRICE)
        FROM
            PRODUCTS
    );
