-- Question 4 List the average unit price for each product category and the 
-- average unit price without discounts 4 marks
SELECT
    C.CATEGORYID,
    C.CATEGORYNAME,
    (
        SELECT AVG(P.UNITPRICE)
        FROM PRODUCTS AS P -- Explicit aliasing for PRODUCTS table
        WHERE C.CATEGORYID = P.CATEGORYID
    ) AS AVGUNITPRICE,
    (
        SELECT AVG(OD.UNITPRICE)
        FROM ORDERDETAILS AS OD -- Explicit aliasing for ORDERDETAILS table
        WHERE
            OD.DISCOUNT = 0
            AND OD.PRODUCTID IN (
                SELECT P.PRODUCTID
                FROM PRODUCTS AS P -- Explicit aliasing for PRODUCTS table
                WHERE C.CATEGORYID = P.CATEGORYID
            )
    ) AS AVGUNITPRICEWITHOUTDISCOUNT
FROM CATEGORIES AS C -- Explicit aliasing for CATEGORIES table
ORDER BY C.CATEGORYID;
