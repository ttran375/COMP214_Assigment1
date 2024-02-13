-- Question 1 List all products whose unit price is less than the average 
-- price. 1 mark
SELECT 
    ProductID,
    ProductName,
    UnitPrice
FROM
    Products
WHERE
    UnitPrice < (
        SELECT AVG(UnitPrice)
        FROM
            PRODUCTS
    );
