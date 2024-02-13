-- Question 4 List the average unit price for each product category and the 
-- average unit price without discounts 4 marks
SELECT
    C.CATEGORYID,
    C.CATEGORYNAME,
    (
        SELECT AVG(P.UNITPRICE)
        FROM
            PRODUCTS P
        WHERE
            C.CATEGORYID = P.CATEGORYID
    ) AS AVGUNITPRICE,
    (
        SELECT
            AVG(OD.UNITPRICE)
        FROM
            ORDERDETAILS OD
        WHERE
            OD.DISCOUNT = 0
            AND OD.PRODUCTID IN (
                SELECT
                    P.PRODUCTID
                FROM
                    PRODUCTS P
                WHERE
                    C.CATEGORYID = P.CATEGORYID
            )
    ) AS AVGUNITPRICEWITHOUTDISCOUNT
FROM
    CATEGORIES C
ORDER BY
    C.CATEGORYID;
