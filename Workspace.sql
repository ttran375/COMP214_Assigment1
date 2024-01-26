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
    SHIPPERS.SHIPPERID,
    SHIPPERS.COMPANYNAME,
    ORDERS.FREIGHT       AS LOWEST_FREIGHT_COST
FROM
    ORDERS
    JOIN SHIPPERS
    ON ORDERS.SHIPVIA = SHIPPERS.SHIPPERID
WHERE
    ORDERS.FREIGHT = (
        SELECT
            MIN(FREIGHT)
        FROM
            ORDERS
    ) FETCH FIRST 1 ROWS ONLY;

--Question 3
--List all products with their highest unit price, i.e. not discounted.
--3 marks
SELECT
    P.PRODUCTID,
    P.PRODUCTNAME,
    MAX(OD.UNITPRICE) AS HIGHESTUNITPRICE
FROM
    (
        SELECT
            ORDERID,
            PRODUCTID,
            UNITPRICE
        FROM
            ORDERDETAILS
        WHERE
            DISCOUNT = 0
    )        OD
    JOIN PRODUCTS P
    ON OD.PRODUCTID = P.PRODUCTID
GROUP BY
    P.PRODUCTID,
    P.PRODUCTNAME;

--Question 4
--List the average unit price for each product category and
--the average unit price without discounts
--4 marks
SELECT
    C.CATEGORYNAME,
    AVG(P.UNITPRICE) AS AVGUNITPRICE,
    (
        SELECT
            AVG(P2.UNITPRICE)
        FROM
            PRODUCTS     P2
            JOIN ORDERDETAILS OD2
            ON P2.PRODUCTID = OD2.PRODUCTID
        WHERE
            C.CATEGORYID = P2.CATEGORYID
            AND OD2.DISCOUNT = 0
    ) AS AVGUNITPRICEWITHOUTDISCOUNT
FROM
    CATEGORIES   C
    JOIN PRODUCTS P
    ON C.CATEGORYID = P.CATEGORYID
    LEFT JOIN ORDERDETAILS OD
    ON P.PRODUCTID = OD.PRODUCTID
GROUP BY
    C.CATEGORYID,
    C.CATEGORYNAME
ORDER BY
    C.CATEGORYID;
