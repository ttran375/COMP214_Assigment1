--Question 1
--List all products whose unit price is less than the average price.
--1 mark
SELECT
    *
FROM
    PRODUCTS
WHERE
    UNITPRICE < (
        SELECT
            AVG(UNITPRICE)
        FROM
            PRODUCTS
    );

--Question 2
--List the shipper id, shipping company and freight cost for the order with the
-- lowest freight charge.
--2 marks
SELECT
    SHIPVIA AS SHIPPERID,
    (
        SELECT
            COMPANYNAME
        FROM
            SHIPPERS
        WHERE
            SHIPPERID = ORDERS.SHIPVIA
    ) AS COMPANYNAME,
    FREIGHT AS LOWEST_FREIGHT_COST
FROM
    ORDERS
WHERE
    FREIGHT = (
        SELECT
            MIN(FREIGHT)
        FROM
            ORDERS
    );

--Question 3
--List all products with their highest unit price, i.e. not discounted.
--3 marks
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
    PRODUCTNAME;

--Question 4
--List the average unit price for each product category and
--the average unit price without discounts
--4 marks
SELECT
    C.CATEGORYID,
    C.CATEGORYNAME,
    (
        SELECT
            AVG(P.UNITPRICE)
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
                    PRODUCTS     P
                WHERE
                    C.CATEGORYID = P.CATEGORYID
            )
    ) AS AVGUNITPRICEWITHOUTDISCOUNT
FROM
    CATEGORIES C
ORDER BY
    C.CATEGORYID;