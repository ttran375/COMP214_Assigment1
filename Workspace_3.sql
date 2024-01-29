--Question 3 List all products with their highest unit price, i.e. not discounted. 3 marks
SELECT
    PRODUCTID,
    PRODUCTNAME,
    MAX(UNITPRICE) AS HIGHESTUNITPRICE
FROM
    PRODUCTS
WHERE
    PRODUCTID IN (
        SELECT
            PRODUCTID
        FROM
            ORDERDETAILS
        WHERE
            DISCOUNT = 0
    )
GROUP BY
    PRODUCTID,
    PRODUCTNAME
ORDER BY
    PRODUCTID;
